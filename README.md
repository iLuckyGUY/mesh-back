<div align="center">
  <img src="https://aibcore.wordpress.com/wp-content/uploads/2026/04/logo_g_retina.png" alt="CloudWEB Mesh" width="120"/>

  # CloudWEB Mesh

  **Admin panel (Remnawave) + Subscription page + Redis**  — Backend Stack

  <br/>
</div>

This repository contains the **backend deployment stack** for the CloudWEB Mesh ecosystem: the Remnawave admin panel and the subscription (sub) page.

---

## Architecture

```
Internet → Cloudflare Edge → Cloudflare Tunnel → container-name:port

mesh-back (this repo):
  redis-cp     → mesh-cp (panel)  → mesh-page (sub page)
                                       ↓
mesh-front (companion repo):
  redis-bot    → mesh-bot (Telegram bot + API) → mesh-app (cabinet SPA)
```

> **All services** share the same Docker network `mesh-net` and communicate by container name.
> Ports are never exposed externally — routing goes through Cloudflare Tunnel only.

### Service Map

| Service | Image | Port | Purpose |
|---------|-------|------|---------|
| `redis-cp` | `redis:8-alpine` | 6379 | Cache for panel |
| `mesh-cp` | `iluckyguy/mesh-cp:latest` | 3000 | Remnawave admin panel |
| `mesh-page` | `iluckyguy/mesh-page:latest` | 3000 | Subscription (sub) page |

---

## Prerequisites

| Requirement | Notes |
|-------------|-------|
| **Docker** + **Docker Compose** | v2.20+ recommended |
| **Docker network `mesh-net`** | `docker network create mesh-net` |
| **PostgreSQL** | Self-hosted — see [Database](#database) |
| **Cloudflare Tunnel** | For routing traffic to containers — see [Cloudflare Setup](#cloudflare-setup) |
| **Companion repo** | [`iLuckyGUY/mesh-front`](https://github.com/iLuckyGUY/mesh-front) — Telegram bot + user cabinet |

### Optional

| Tool | Benefit |
|------|---------|
| **Portainer** | UI for stack management — create stack from git repo |
| **Caddy** | Can be added for internal SSL/proxy, but **not required** for Cloudflare Tunnel routing |

---

## Startup Order

The stack has a strict dependency chain:

```
1. Docker network  ─── create mesh-net (once)
2. PostgreSQL      ─── must be running and reachable on mesh-net
       │
3. redis-cp        ─── starts first (depends on nothing)
       │
4. mesh-cp         ─── waits for redis-cp healthy
       │
5. mesh-page       ─── waits for mesh-cp healthy
```

**mesh-cp** requires a running PostgreSQL instance. During first start it runs Prisma migrations to create all tables in the `mesh_cp` schema.

---

## Quick Start

### 1. Create the shared network

```bash
docker network create mesh-net
```

### 2. Start PostgreSQL

**Self-hosted PostgreSQL** (локальный контейнер):

```bash
docker run -d --name PostgreSQL --network mesh-net \
  -v postgres_data:/var/lib/postgresql/data \
  -e POSTGRES_DB=mesh_cp \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=<strong-password> \
  postgres:16-alpine
```

Для mesh-bot дополнительно создать БД:
```bash
docker exec PostgreSQL psql -U postgres -c "CREATE DATABASE mesh_bot;"
```

### 3. Configure environment

```bash
# Example env values — put real secrets in your stack.env / .env
export DATABASE_URL_CP="postgresql://..."
export REDIS_CP_PASSWORD=<redis-password>
export JWT_AUTH_SECRET=<random-64-chars>
export JWT_API_TOKENS_SECRET=<random-64-chars>
export PANEL_DOMAIN=panel.yourdomain.com
export SUB_PUBLIC_DOMAIN=sub.yourdomain.com
export REMNAWAVE_API_TOKEN_PAGE=<api-token-from-panel>
export INTERNAL_JWT_SECRET=<random-64-chars>
```

> See [Environment Variables](#environment-variables) for the full list.

### 4. Start the stack

```bash
docker compose up -d
```

### 5. Set up Cloudflare Tunnel

```bash
docker run -d --name cloudflared-tunnel --restart unless-stopped \
  --network mesh-net \
  cloudflare/cloudflared:latest tunnel --no-autoupdate --protocol http2 \
  run --token "$CF_TUNNEL_TOKEN"
```

### 6. Configure routes in Cloudflare Dashboard

| Hostname | Target |
|----------|--------|
| `panel.yourdomain.com` | `http://mesh-cp:3000` |
| `sub.yourdomain.com` | `http://mesh-page:3000` |

---

## Cloudflare Setup

1. Create a Tunnel in [Zero Trust → Tunnels](https://one.dash.cloudflare.com)
2. Copy the tunnel token
3. Start `cloudflared-tunnel` container (step 5 above)
4. Add Public Hostnames pointing to mesh-cp:3000 and mesh-page:3000

The Tunnel connects **outbound** from your server — no open firewall ports needed.

---

## Database

### Connection URIs

| Parameter | Format |
|-----------|--------|
| `DATABASE_URL_CP` | `postgresql://postgres:pass@PostgreSQL:5432/mesh_cp` |
| `DATABASE_URL_BOT` | `postgresql+asyncpg://postgres:pass@PostgreSQL:5432/mesh_bot` |

### Schema

All panel tables live in the `mesh_cp` schema. Prisma auto-creates them on first startup.

---

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `DATABASE_URL_CP` | ✅ | — | PostgreSQL connection string |
| `REDIS_CP_PASSWORD` | ✅ | — | Redis password |
| `JWT_AUTH_SECRET` | ✅ | — | JWT secret for auth tokens (min 32 chars) |
| `JWT_API_TOKENS_SECRET` | ✅ | — | JWT secret for API tokens (min 32 chars) |
| `PANEL_DOMAIN` | ✅ | — | Public domain for the admin panel |
| `SUB_PUBLIC_DOMAIN` | ✅ | — | Public domain for the sub page |
| `REMNAWAVE_API_TOKEN_PAGE` | ✅ | — | API token from panel for sub page |
| `INTERNAL_JWT_SECRET` | ✅ | — | Internal JWT secret for sub page |
| `BOT_TOKEN` | — | — | Telegram bot token (for panel notifications) |
| `PROXY_URL` | — | — | SOCKS5 proxy for Telegram bot API |
| `METRICS_PASS` | — | — | Metrics endpoint password |
| `IS_TELEGRAM_NOTIFICATIONS_ENABLED` | — | false | Enable Telegram notifications |
| `TELEGRAM_NOTIFY_USERS` | — | — | Telegram chat ID for user notifications |
| `TELEGRAM_NOTIFY_NODES` | — | — | Telegram chat ID for node notifications |
| `TELEGRAM_NOTIFY_CRM` | — | — | Telegram chat ID for CRM notifications |
| `TELEGRAM_NOTIFY_SERVICE` | — | — | Telegram chat ID for service notifications |
| `TELEGRAM_NOTIFY_TBLOCKER` | — | — | Telegram chat ID for traffic blocker |
| `WEBHOOK_URL` | — | — | Webhook URL for panel events |
| `WEBHOOK_SECRET_HEADER` | — | — | Webhook secret header |

---

## Compose Variants

| File | Use Case |
|------|----------|
| `docker-compose.yml` | Basic — needs external PostgreSQL |

---

## Portainer Deployment

1. **Stack name:** `mesh-cw` (or `mesh-backend`)
2. **Repository:** `https://github.com/iLuckyGUY/mesh-back`
3. **Compose file:** select variant (`docker-compose.yml`, `docker-compose-sb.yml`, etc.)
4. **Environment variables:** upload or paste the `stack.env`
5. **Network:** ensure `mesh-net` exists on the host

> Portainer does **not** support `env_file:` — all variables must be in the stack's environment section.

---

## Companion Repo: mesh-front

[**`iLuckyGUY/mesh-front`**](https://github.com/iLuckyGUY/mesh-front) — the frontend ecosystem:

| Service | Role |
|---------|------|
| **mesh-bot** | Telegram bot (user management, payments, support) |
| **mesh-app** | User cabinet SPA (Mini App, web dashboard) |
| **redis-bot** | Cache + session store for the bot |

```bash
# Clone and deploy alongside mesh-back
git clone https://github.com/iLuckyGUY/mesh-front
cd mesh-front
docker compose -f docker-compose-pg.yml up -d
```

Both stacks **must** be on the same `mesh-net` network. The bot connects to the panel at `http://mesh-cp:3000` and the cabinet connects to the bot at `http://mesh-bot:8080`.

---

## Healthchecks

All containers use IPv4 (`127.0.0.1`) for health checks — never `localhost` (which resolves to IPv6 `::1` inside containers).

---

## License

This project is a white-label deployment stack for the [Remnawave](https://github.com/remnawave/remnawave-panel) ecosystem. All upstream components retain their original licenses.
