# mesh-cloudweb — Project Rules

> Mesh ecosystem: mesh-cp (Remnawave panel) + mesh-page (sub page) + mesh-bot (Telegram bot) + mesh-app (Cabinet SPA).
> Deploy: Portainer stack mesh-cw (id 110) + manual docker run. Routing via Cloudflare Tunnel (dashboard).
>
> **📖 См. `skills/mesh-build-deploy/SKILL.md`** — полный гайд по сборке, CI/CD, деплою, патчам и импортам.

---

## Architecture

### Traffic Flow (incoming)

```
Internet → Cloudflare Edge → Cloudflare Tunnel (outbound from server)
                                ↓
    Cloudflare Dashboard (Public Hostname routes):
      mesh.cloudweb.name     → http://mesh-app:80
      mesh-api.cloudweb.name → http://mesh-bot:8080
      panel.cloudweb.name    → http://mesh-cp:3000
      sub.cloudweb.name      → http://mesh-page:3000
```

**Ключевой момент:** Cloudflare Tunnel маршрутизирует напрямую к контейнерам по имени. Никакие порты наружу не торчат. Caddy-контейнер на сервере НЕ участвует в проксировании (стоит с дефолтной конфигурацией).

### Stacks

| Стек | Состав | Управление |
|------|--------|-----------|
| `mesh-back` (Portainer stack 5) | mesh-cp, mesh-page, redis-cp, postgres, cloudflared-tunnel, caddy | Portainer GitOps (репо `iLuckyGUY/mesh-back`, poll 5m) |
| `mesh-front` (Portainer stack 6) | mesh-bot, mesh-app, redis-bot | Portainer GitOps (репо `iLuckyGUY/mesh-front`, poll 5m) |
| Отдельные стеки БД | postgres (mesh-back), supabase (внешний) | См. раздел 7 |

### Portainer

Локальный Portainer на `https://localhost:9443` управляет удалёнными агентами:
- `Mesh CloudWEB` (endpoint 8, `213.182.213.22:9001`) — основной сервер, на нём mesh-back + mesh-front
- `Stack Control Main` (endpoint 3) — локальный Mac Mini, только для тестов

**API-ключ** сохранён в `~/.portainer_key` (общий для всех проектов).

### Services — Portainer Labels

Для отображения в правильном стеке Portainer контейнеры должны иметь лейблы:
- `com.docker.compose.project=mesh-front`
- `com.docker.compose.service=<service-name>`
- `com.docker.compose.container-number=1`
- `com.docker.compose.oneoff=False`

### Compose файлы для миграции

| Файл | Для чего |
|------|----------|
| `docker-compose.yml` | Бэкенд: mesh-cp, mesh-page, redis-cp |
| `frontend/docker-compose-pg.yml` | Фронт: mesh-bot, mesh-app, redis-bot |

### Healthcheck — всегда IPv4

Внутри контейнеров nginx/Caddy слушают ТОЛЬКО на IPv4. Healthcheck должен быть на `127.0.0.1`, не на `localhost` (локальный хост резолвится в `::1` и падает).

```dockerfile
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://127.0.0.1:80/ || exit 1
```

### mesh-app — внутренний nginx

mesh-app использует **nginx** внутри контейнера (не Caddy). nginx.conf:
- раздаёт статику SPA из `/usr/share/nginx/html`
- проксирует `/api/*` → `mesh-bot:8080` (через Docker resolver `127.0.0.11`)
- SPA-роутинг: `try_files $uri /index.html`

---

## 1. ENV File Naming Convention

| File | Component | Source |
|---|---|---|
| `.env.sample` / `.env.example` | Оригинал автора | **НЕ ТРОГАТЬ** — read-only reference |
| `.env` | Локальная разработка | gitignored |
| `panel.env` | mesh-cp | копия `.env.sample` + real data |
| `page.env` | mesh-page | копия `.env.sample` + real data |
| `bot.env` | mesh-bot | копия `.env.example` + real data |
| `app.env` | mesh-app | копия `.env.example` + real data |
| `backend/cp.env` | Stack mesh-back (Portainer) | Runtime env для панели и страницы (локально, не в git) |
| `frontend/bot.env` | Stack mesh-front (Portainer) | Runtime env для бота и кабинета (локально, не в git) |
| `tunnel/tunnel.env` | Туннель | `CF_TUNNEL_TOKEN` + опции |

## 2. Правила создания deploy env

- **Полная точная копия** `.env.sample` / `.env.example`: каждая строка, каждый комментарий, каждый отступ сохраняются.
- **Ничего не вырезать и не удалять** из оригинального файла.
- **Только значения** меняются на реальные production-данные из `full-prod.env`.
- Если в `full-prod.env` нет значения для переменной — оставить как в sample/example.
- Новые переменные (которых нет в sample/example, но есть в `full-prod.env`) добавляются в конец файла, если они реально используются приложением.

## 3. Правила stack env (backend/cp.env, frontend/bot.env)

- Содержит **только** переменные, на которые есть ссылки `${VAR}` в `docker-compose.yml`.
- Никаких лишних переменных — только то, что нужно compose-файлу.
- Формат: плоский `KEY=VALUE`, без кавычек вокруг значений (Portainer не поддерживает `env_file`).

## 3.5. Правило разделения env: DISPLAY vs VERSION CHECK

Переменные, связанные с GitHub репозиториями, делятся на две категории:

| Тип | Переменные | Куда должны указывать |
|---|---|---|
| **DISPLAY** (ссылки) | `GITHUB_BOT_URL`, `GITHUB_CABINET_URL` | На форк (`iLuckyGUY/mesh-*`) |
| **VERSION CHECK** (API) | `VERSION_CHECK_REPO`, `CABINET_REPO` | На upstream (там есть GitHub Releases) |

**Почему:** GitHub Actions publish releases только в upstream репозитории. В форках релизов нет — API возвращает 404, проверка версий не работает. DISPLAY-ссылки при этом должны вести на форк (там лежит актуальный код с whitelabel-патчами).

**Где задавать:** defaults в `docker-compose.yml` и `config.py`. Если Portainer UI переопределяет их старыми значениями — удалить из Portainer или обновить.

---

## 4. Запрещено

- **Хардкодить домены в коде** — домены определяются только в env-файлах, `docker-compose.yml` или `nginx.conf`.
- **Менять `.env.sample` / `.env.example`** — это read-only оригиналы от разработчика компонента.
- **Использовать `env_file:` в docker-compose.yml** — Portainer не поддерживает.
- **Коммитить секреты** — все `*.env` кроме `.env.sample`/`.env.example` в `.gitignore`.

## 5. Сеть

### mesh-net (основная)
```yaml
networks:
  mesh-net:
    name: mesh-net
    external: true
```
Все сервисы mesh стека всегда на `mesh-net`.
```
mesh-cp  → mesh-net → supabase-db:5432  (Docker DNS, cf. ниже)
mesh-bot → mesh-net → supabase-db:5432
mesh-page, mesh-app, redis → mesh-net (взаимодействие между собой)
caddy, cloudflared-tunnel → mesh-net (доступ к контейнерам)
```

### почему не через домен
- `grand-supabase.cloudweb.name` работает для Kong (HTTP) и Studio, НО НЕ для PostgreSQL — CF Tunnel не проксирует PgSQL без warp-routing
- Docker DNS (`supabase-db:5432`) работает на любой ОС без правок env при переезде

## 6. Docker Hub — образы и их сборка

Все образы на `docker.io/iluckyguy/*`, multi-arch (amd64 + arm64).

| Образ | Где собирается | Триггер |
|---|---|---|
| `iluckyguy/mesh-cp` | `iLuckyGUY/mesh-cp` (отд. репо) | push в main / тэг `v*` |
| `iluckyguy/mesh-page` | `iLuckyGUY/mesh-page` (отд. репо) | push в main / тэг `v*` |
| `iluckyguy/mesh-bot` | `iLuckyGUY/mesh-bot` (отд. репо) | push в main / тэг `v*` |
| `iluckyguy/mesh-app` | `iLuckyGUY/mesh-app` (отд. репо) | push в main / тэг `v*` |

**Тэги для триггера CI — обязательно с префиксом `v`** (например `v2.8.0`).
Без `v` workflow не запустится (условие `tags: ['v*']`).

Fallback при сбое CI — ручная сборка:
```bash
docker buildx build --platform linux/amd64 \
  --tag iluckyguy/mesh-xxx:latest --push .
```

## 6b. Полный workflow обновления (bot + app) — проверено на v3.62.0 / v1.59.0

Portainer использует **GitOps**: каждый стек следит за своим git-репозиторием и
перезапускается при новом коммите. Триггер — **именно новый коммит**, а не новый образ
на Docker Hub.

Правильная последовательность:

```
1. Обновить код           → git merge upstream (бот: mesh-bot/, кабинет: mesh-app/)
2. Собрать Docker образы  → docker buildx build --push (вручную или CI)
3. Закоммитить версию     → git commit (обновить submodule pointer в mesh-front/)
4. Запушить в GitHub      → git push (бот, кабинет, и mesh-front — все три репозитория)
5. Portainer GitOps       → замечает новый коммит в mesh-front за ≤5 мин
6. Перезапуск стека       → Portainer дёргает `docker compose up -d` с новыми :latest
```

**Fix для ForcePullImage:** GitOps не тянет образы принудительно. Если надо —
через Portainer API:
```bash
curl -sk -X PUT \
  -H "X-API-Key: $PORTAINER_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"pullImage": true}' \
  "https://localhost:9443/api/stacks/{id}/git/redeploy?endpointId={ep}"
```

### Структура git-репозиториев

| Репо | Содержит | Роль |
|---|---|---|
| `iLuckyGUY/mesh-front` | `docker-compose.yml` + submodule pointer на bot/app | **Триггер GitOps** — коммит сюда перезапускает стек |
| `iLuckyGUY/mesh-bot` | Исходный код Python-бота | После пуша можно собрать образ (CI или вручную) |
| `iLuckyGUY/mesh-app` | Исходный код React-кабинета | После пуша можно собрать образ (CI или вручную) |

Внутри монорепы `mesh-front/` лежат вложенные git-репозитории `mesh-bot/` и `mesh-app/`.
После их обновления нужно закоммитить новый submodule pointer в `mesh-front/`.

### Migration (Alembic)

Миграции БД mesh-bot запускаются **автоматически** при старте контейнера —
в `main.py` есть startup-хук. Новые файлы в `migrations/alembic/versions/` не требуют
ручного запуска.

### Если контейнеры не стартуют

Проверить логи через Portainer или SSH:
```bash
ssh fra-1-hm-001-cloudweb-root
docker logs redis-bot --tail 50
docker logs mesh-bot --tail 50
docker logs mesh-app --tail 50
```

**Типичная проблема:** `redis-bot` в статусе restarting. Если в логах
```
FATAL CONFIG FILE ERROR ... 'requirepass "--loadmodule"'
```
— значит переменные окружения не подставились, команда сломана. Проверить
`REDIS_BOT_PASSWORD` в Portainer → Stack → Env и в `docker-compose.yml`.

---

## 7. Supabase Database — Схемы и подключение

### 7.1. Supabase Project

| Параметр | Значение |
|----------|----------|
| Project ref | `vgwwidekswqeffltqhag` |
| Pooler host | `aws-1-eu-central-1.pooler.supabase.com` (⚠️ не `aws-0`) |
| DB password | `${SUPABASE_DB_PASSWORD}` (в `~/.ai/env/keys.env`) |
| MCP config | `~/.config/opencode/opencode.json` → `mcp.supabase` (remote, OAuth) |
| Management PAT | `${SUPABASE_MANAGEMENT_PAT}` (в `~/.ai/env/keys.env`) |
| Где взять PAT | `https://supabase.com/dashboard/account/tokens` |
| Аутентификация MCP | `opencode mcp auth supabase` |

### 7.2. Схемы

Одна БД, разные схемы для разных сервисов. Никогда не путай, с какой схемой работаешь.

| Схема | Владелец | Сервис | Статус |
|-------|----------|--------|--------|
| `mesh_bot` | mesh-bot | Telegram bot + Cabinet API | ✅ перенесена в облако |
| `mesh_cp` | mesh-cp | Remnawave панель | ✅ перенесена в облако |
| `crm` | — | CRM (пустая) | ✅ создана в облаке |

### 7.3. Как подключаться

**Локально (Mac Mini)** — через Docker DNS:
```
postgresql+asyncpg://postgres:${SUPABASE_DB_PASSWORD}@supabase-db:5432/postgres
```

**Облачно (Supabase FRA)** — через pooler (session mode 5432 / transaction 6543):
```
# Bot (asyncpg, session mode)
postgresql+asyncpg://postgres.${PROJECT_REF}:${SUPABASE_DB_PASSWORD}@aws-1-eu-central-1.pooler.supabase.com:5432/postgres?search_path=mesh_bot

# CP (Prisma, transaction mode + pgbouncer)
postgresql://postgres.${PROJECT_REF}:${SUPABASE_DB_PASSWORD}@aws-1-eu-central-1.pooler.supabase.com:6543/postgres?schema=mesh_cp&pgbouncer=true
```

Пароль хранится в `~/.ai/env/keys.env` → `SUPABASE_DB_PASSWORD` и в `stack.env` файлах проектов.

### 7.4. Когда и каким инструментом работать

| Действие | Инструмент |
|----------|-----------|
| SELECT / INSERT / UPDATE / DELETE (с RLS) | Supabase MCP (через opencode) |
| DDL (CREATE TABLE, ALTER, миграции) | `PGPASSWORD=... psql -h aws-1-... -U postgres.vgwwidekswqeffltqhag -d postgres -p 5432` |
| Создание схемы для нового сервиса | `CREATE SCHEMA IF NOT EXISTS <name>;` |
| Копирование схемы между БД | `pg_dump` + pipe to `psql` (см. ниже) |
| Миграции mesh-bot | Alembic (`migrations/alembic/`) — сам создаёт таблицы в `mesh_bot` |
| Миграции mesh-cp | Prisma — сам создаёт таблицы в `mesh_cp` |

### 7.5. Правила

1. **Всегда указывай schema** в SQL запросах: `SELECT * FROM mesh_bot.users` — даже если search_path настроен.
2. **Никогда не делай DROP / TRUNCATE / DELETE без WHERE** в `mesh_bot` или `mesh_cp` — спроси разрешения.
3. **Не редактируй `auth` и `storage` схемы** — это Supabase internal.
4. **Новые сервисы** получают свою схему: `CREATE SCHEMA IF NOT EXISTS service_name;`. Никогда не сваливай таблицы разных сервисов в одну схему.
5. **`public` схема** — для shared данных между сервисами (справочники, общие конфиги). Не занимать без необходимости.
6. **Pooler host** — всегда `aws-1-{region}.pooler.supabase.com`, НЕ `aws-0`. Разные шифры пулеров назначаются проектам произвольно.
7. **Пароль** можно сбросить через Management API: `PATCH /v1/projects/{ref}/database/password` с PAT-токеном.
8. **DDL через pooler** — только session mode (port 5432). Transaction mode (port 6543) не поддерживает CREATE TABLE и prepared statements.

### 7.6. Миграция локальный → облачный (checklist)

```bash
# 1. Создать схемы в облаке (если не существуют)
PGPASSWORD=... psql -h aws-1-eu-central-1.pooler.supabase.com -p 5432 \
  -U postgres.vgwwidekswqeffltqhag -d postgres \
  -c "CREATE SCHEMA IF NOT EXISTS mesh_bot; CREATE SCHEMA IF NOT EXISTS mesh_cp;"

# 2. Дамп схемы из локальной БД и pipe в облако (plain SQL)
docker exec supabase-db pg_dump -U postgres -n mesh_bot --no-owner --no-acl -Fp 2>/dev/null | \
  PGPASSWORD=... psql -h aws-1-eu-central-1.pooler.supabase.com -p 5432 \
    -U postgres.vgwwidekswqeffltqhag -d postgres -q

docker exec supabase-db pg_dump -U postgres -n mesh_cp --no-owner --no-acl -Fp 2>/dev/null | \
  PGPASSWORD=... psql -h aws-1-eu-central-1.pooler.supabase.com -p 5432 \
    -U postgres.vgwwidekswqeffltqhag -d postgres -q

# 3. Обновить DATABASE_URL в stack.env каждого сервиса
# См. backend/cp.env (mesh-back), frontend/bot.env (mesh-front)
```

---

## 8. Migration to new server — checklist

### Pre-requisites
- Docker + Docker Compose на новом сервере
- Доступ к GitHub (ssh ключ для git pull, или скачать репозиторий)
- Доступ к Docker Hub (docker login)
- Cloudflare Tunnel token (из `tunnel/tunnel.env`)

### Images (Docker Hub, multi-arch amd64+arm64)
Все образы уже запушены:
```
iluckyguy/mesh-bot:latest
iluckyguy/mesh-app:latest
iluckyguy/mesh-cp:latest
iluckyguy/mesh-page:latest
```

### Steps

```bash
# 1. Создать сеть
docker network create mesh-net

# 2. Развернуть compose стеки

# 2a. Backend (mesh-cp + mesh-page + redis-cp)
#    см. backend/cp.env
cd docker-compose.yml  # name: mesh-backend
docker compose up -d

# 2b. Frontend (mesh-bot + mesh-app + redis-bot)
#    см. frontend/bot.env
cd frontend/docker-compose-pg.yml  # name: mesh-frontend
docker compose up -d

# 3. Настроить Cloudflare Tunnel
docker run -d --name cloudflared-tunnel --restart unless-stopped \
  --network mesh-net \
  cloudflare/cloudflared:latest tunnel --no-autoupdate --protocol http2 \
  run --token "$CF_TUNNEL_TOKEN"

# 4. Настроить маршруты в Cloudflare Dashboard
#    Zero Trust → Tunnels → (выбрать туннель) → Public Hostname
#    mesh.cloudweb.name     → http://mesh-app:80
#    mesh-api.cloudweb.name → http://mesh-bot:8080
#    panel.cloudweb.name    → http://mesh-cp:3000
#    sub.cloudweb.name      → http://mesh-page:3000
```

### Если альтернативно через Portainer
- Stack `mesh-cw` (110) — backend (git-pull из mesh-cloudweb)
- Контейнеры mesh-front управляются вручную (Portainer stack 174 удалён, compose на диске отсутствует)
- Для нового сервера проще использовать `docker compose` (шаг 2), а не Portainer
