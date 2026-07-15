# Mesh Ecosystem Architecture

## Overview

```
┌─────────────────────────────────────────────────────────┐
│                    Cloudflare Tunnel                     │
│  mesh.cloudweb.name → portainer:9443                    │
│  mesh-cp.cloudweb.name → mesh-cp:3000                   │
│  mesh-go.cloudweb.name → mesh-page:3000                 │
│  mesh-api.cloudweb.name → mesh-bot:8080                 │
└──────────────────┬──────────────────────────────────────┘
                   │ (TLS termination at tunnel)
┌──────────────────▼──────────────────────────────────────┐
│                   Portainer (Docker)                     │
│                                                         │
│  ┌───────────── mesh-back stack ──────────────┐         │
│  │  redis-cp (redis:8-alpine)                  │         │
│  │  mesh-cp  (iluckyguy/mesh-cp:latest)       │         │
│  │  mesh-page (iluckyguy/mesh-page:latest)     │         │
│  └────────────────────────────────────────────┘         │
│                                                         │
│  ┌──────────── mesh-front stack ──────────────┐         │
│  │  redis-bot (redis:8-alpine)                 │         │
│  │  mesh-bot  (iluckyguy/mesh-bot:latest)      │         │
│  │  mesh-app  (iluckyguy/mesh-app:latest)      │         │
│  └────────────────────────────────────────────┘         │
│                                                         │
 │  ┌───────── PostgreSQL (mesh-back) ───────────┐         │
 │  │  Локальный контейнер на сервере             │         │
 │  │  Schema: public (mesh_cp, mesh_bot)          │         │
 │  └────────────────────────────────────────────┘         │
└─────────────────────────────────────────────────────────┘
```

## Repository Structure

### Orchestration stacks (clean, no app code)

| Repo | Stack | Images | File |
|---|---|---|---|
| **iLuckyGUY/mesh-back** | mesh-control | mesh-cp, mesh-page | `docker-compose.yml` + `.env.example` |
| **iLuckyGUY/mesh-front** | mesh-services | mesh-bot, mesh-app | `docker-compose.yml` + `Caddyfile` + `.env.example` |

### Component repos (forks with whitelabel patches)

| Repo | Docker Image | Upstream |
|---|---|---|
| **iLuckyGUY/mesh-cp** | `iluckyguy/mesh-cp:latest` | `remnawave/backend` (upstream remote) |
| **iLuckyGUY/mesh-page** | `iluckyguy/mesh-page:latest` | `remnawave/subscription-page` (upstream remote) |
| **iLuckyGUY/mesh-bot** | `iluckyguy/mesh-bot:latest` | `BEDOLAGA-DEV/remnawave-bedolaga-telegram-bot` (origin fetch) |
| **iLuckyGUY/mesh-app** | `iluckyguy/mesh-app:latest` | `BEDOLAGA-DEV/bedolaga-cabinet` (origin fetch) |

### How forks work

- **mesh-cp / mesh-page**: `origin` → `iLuckyGUY/<name>`, `upstream` → `remnawave/<name>`
- **mesh-bot / mesh-app**: `origin` has dual URL — fetch from upstream, push to iLuckyGUY (`remote.origin.fetch` ≠ `remote.origin.push`)

#### Updating a fork from upstream

```bash
# For mesh-cp and mesh-page:
git fetch upstream main
git merge upstream/main
# Resolve conflicts, then
git push origin main

# For mesh-bot and mesh-app:
git fetch origin main    # fetches from upstream (BEDOLAGA-DEV)
git merge origin/main
# Resolve conflicts, then
git push origin main     # pushes to iLuckyGUY
```

Whitelabel patches in `patches/` dir are applied in Dockerfile during build.

## CI/CD Workflows

### Component repos (mesh-cp, mesh-page, mesh-bot, mesh-app)

All use `.github/workflows/build.yml` (or `docker-hub.yml` for mesh-bot):

| Event | Action |
|---|---|
| PR → main | Build only (no push) |
| Push → main | Build + push `:latest` |
| Tag `v*` | Build + push `:latest` + `:vX.Y.Z` |

**Secrets required** (set per repo):
- `DOCKER_USERNAME` = `iluckyguy`
- `DOCKER_PASSWORD` = Docker Hub PAT token

### Orchestration repos (mesh-back, mesh-front)

Simple lint/validation CI only:
- PR → main: `docker compose config` (validate YAML)
- No builds (these are compose-only repos)

## Deployment

### 1. Local (Mac Mini) — via Portainer

Create Portainer stacks manually:

#### Stack: mesh-back
```yaml
services:
  redis-cp:  image: redis:8-alpine  ...
  mesh-cp:   image: iluckyguy/mesh-cp:latest  ...
  mesh-page: image: iluckyguy/mesh-page:latest  ...
```

#### Stack: mesh-front
```yaml
services:
  redis-bot: image: redis:8-alpine  ...
  mesh-bot:  image: iluckyguy/mesh-bot:latest  ...
  mesh-app:  image: iluckyguy/mesh-app:latest  ...
```

Both on `mesh-net` (external: true). Cross-stack communication:
- mesh-bot → mesh-cp via `http://mesh-cp:3000` (Docker DNS)
- mesh-page → mesh-cp via `http://mesh-cp:3000`

### 2. Remote (msk-1 / VPS)

Same compose files, same images — copy `docker-compose.yml` + `.env` to the VPS and `docker compose up -d`.

## Database

### Remote PostgreSQL (self-hosted)

**Server:** `cloud-control-stack-msk-luckyguy` (`185.50.202.177`)  
**Container:** `postgres-18` (postgres:18.3), network `cloudweb-net`  
**User:** `postgres`  
**Password:** `kJpuL_RrCn9IM4THHa3JvbLUaxejfWld` (хранится в `~/.ai/env/keys.env`)

### Databases

| Database | Используется | Схемы |
|---|---|---|
| `mesh_bot` | mesh-bot | public (миграции через Alembic) |
| `mesh_cp` | mesh-cp | public (миграции через Prisma) |
| `cloudweb_crm` | CRM | — |

### Connection Strings

| Service | Driver | Connection |
|---|---|---|
| mesh-bot | asyncpg | `postgresql+asyncpg://postgres:${PASSWORD}@185.50.202.177:5432/mesh_bot` |
| mesh-cp | Prisma | `postgresql://postgres:${PASSWORD}@185.50.202.177:5432/mesh_cp` |

### Принципы

- Каждый сервис — отдельная **база данных**, а не схема
- Все базы на одном сервере, один пользователь `postgres`
- PG доступен снаружи на порту `5432` (bind 0.0.0.0)
- Из Docker контейнеров на том же хосте — тоже через `185.50.202.177:5432`
- Миграции — Alembic (mesh-bot) / Prisma (mesh-cp), создают таблицы в public схеме
- No DROP/TRUNCATE/DELETE without WHERE в production

### Image Registry
- **Docker Hub** — `iluckyguy/<name>:latest` (all images)
- **No GHCR** — only Docker Hub

## Key Ports (in-stack)

| Service | Internal Port | Service | Internal Port |
|---|---|---|---|
| mesh-cp | 3000 (API), 3001 (metrics) | mesh-bot | 8080 (WebAPI) |
| mesh-page | 3000 (sub page) | mesh-app | 80 (nginx SPA) |

Cloudflare Tunnel maps these to public domains.

## Remotes Reference

```
mesh-cloudweb/          — monorepo (local dev only, NOT on GitHub)
├── backend/
│   ├── mesh-cp/        → iLuckyGUY/mesh-cp    (upstream: remnawave/backend)
│   ├── mesh-page/      → iLuckyGUY/mesh-page  (upstream: remnawave/subscription-page)
│   └── docker-compose.yml → copy to mesh-back
└── frontend/
    ├── mesh-bot/       → iLuckyGUY/mesh-bot   (fetch: BEDOLAGA-DEV/..., push: iLuckyGUY)
    ├── mesh-app/       → iLuckyGUY/mesh-app   (fetch: BEDOLAGA-DEV/..., push: iLuckyGUY)
    └── docker-compose.yml → copy to mesh-front
```

## Deployment Methods

### Method 1 — Portainer (рекомендуемый)

1. Создать внешнюю сеть: `docker network create mesh-net` (один раз)
2. В Portainer UI → Stacks → Add stack
3. Вставить содержимое `docker-compose.yml` из mesh-back / mesh-front
4. Добавить env vars из `.env.example` (заполнив реальные значения)
5. Deploy stack

Обновление сервиса:
- Portainer → Stack → Editor → Change image tag → Update
- Или: Pull & recreate через кнопку "Update" на каждом контейнере

### Method 2 — Docker CLI (VPS / bare metal)

```bash
# === mesh-back ===
git clone https://github.com/iLuckyGUY/mesh-back.git /opt/mesh-back
cd /opt/mesh-back
cp .env.example cp.env
# ✏️ отредактировать cp.env — вставить реальные секреты
docker compose -f docker-compose.yml up -d

# === mesh-front ===
git clone https://github.com/iLuckyGUY/mesh-front.git /opt/mesh-front
cd /opt/mesh-front
cp .env.example .env
# ✏️ отредактировать .env — вставить реальные секреты
docker compose -f docker-compose.yml up -d
```

### Method 3 — GitHub Actions (CI/CD)

Пуш в `main` любого компонентного репозитория автоматически:
1. Собирает multi-arch образ (`linux/amd64 + linux/arm64`)
2. Пушит в Docker Hub: `iluckyguy/<name>:latest`
3. Для тегов `v*` — дополнительно пушит `:vX.Y.Z`

На сервере достаточно сделать `docker compose pull && docker compose up -d`.

Или настроить Portainer Webhook для авто-деплоя:
1. Portainer → Stack → Webhook → Enable
2. Скопировать URL
3. Добавить в GitHub Actions как шаг после push:

```yaml
- name: Trigger Portainer redeploy
  run: curl -X POST https://portainer.cloudweb.name/api/stacks/webhook/WEBHOOK_ID
```

## How Deploy Works

```mermaid
flowchart LR
    A[Push to main] --> B[GitHub Actions]
    B --> C[Docker Hub buildx multi-arch]
    C --> D[iluckyguy/*:latest]
    D --> E[Portainer pull]
    D --> F[docker compose pull]
    E --> G[Recreate container]
    F --> G
```

## Before Deploying a New Version

1. Build updates in component repos (CI auto-pushes to Docker Hub)
2. Wait for `:latest` tag to update (check with `docker manifest inspect iluckyguy/<name>:latest`)
3. In Portainer: re-pull image + recreate container for each service
4. Verify health checks pass
