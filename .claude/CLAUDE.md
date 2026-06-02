# mesh-cloudweb — Project Rules

> Mesh ecosystem: mesh-cp (Remnawave panel) + mesh-page (sub page) + mesh-bot (Telegram bot) + mesh-app (Cabinet SPA).
> Deploy via 3 Portainer stacks on shared `mesh-net`.
>
> **📖 См. `skills/mesh-build-deploy/SKILL.md`** — полный гайд по сборке, CI/CD, деплою, патчам и импортам.

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
| `backend/cp.env` | Stack mesh-control (Portainer) | Runtime env для панели и страницы подписок |
| `frontend/.env` | Stack mesh-services (Portainer) | Runtime env для бота и кабинета |
| `tunnel/tunnel.env` | Туннель | `CF_TUNNEL_TOKEN` + опции |

## 2. Правила создания deploy env

- **Полная точная копия** `.env.sample` / `.env.example`: каждая строка, каждый комментарий, каждый отступ сохраняются.
- **Ничего не вырезать и не удалять** из оригинального файла.
- **Только значения** меняются на реальные production-данные из `full-prod.env`.
- Если в `full-prod.env` нет значения для переменной — оставить как в sample/example.
- Новые переменные (которых нет в sample/example, но есть в `full-prod.env`) добавляются в конец файла, если они реально используются приложением.

## 3. Правила stack env (backend/cp.env, frontend/.env)

- Содержит **только** переменные, на которые есть ссылки `${VAR}` в `docker-compose.yml`.
- Никаких лишних переменных — только то, что нужно compose-файлу.
- Формат: плоский `KEY=VALUE`, без кавычек вокруг значений (Portainer не поддерживает `env_file`).

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

### supabase-*_default (для БД)
```yaml
  supabase-cloudweb_default:
    external: true
```
Только mesh-cp и mesh-bot подключаются к сети supabase для доступа к БД.
```
mesh-cp  → mesh-net + supabase-cloudweb_default  → supabase-db:5432
mesh-bot → mesh-net + supabase-cloudweb_default  → supabase-db:5432
```
Остальные сервисы (mesh-page, mesh-app, redis) — только `mesh-net`.

### почему не через домен
- `grand-supabase.cloudweb.name` работает для Kong (HTTP) и Studio, НО НЕ для PostgreSQL — CF Tunnel не проксирует PgSQL без warp-routing
- Docker DNS (`supabase-db:5432`) работает на любой ОС без правок env при переезде

## 6. Docker Hub

Образы без `ghcr.io/`:
```
iluckyguy/mesh-cp:latest
iluckyguy/mesh-page:latest
iluckyguy/mesh-bot:latest
iluckyguy/mesh-app:latest
```

---

## 7. Supabase Database — Схемы и подключение

### 7.1. Supabase Project

| Параметр | Значение |
|----------|----------|
| Project ref | `vgwwidekswqeffltqhag` |
| Pooler host | `aws-1-eu-central-1.pooler.supabase.com` (⚠️ не `aws-0`) |
| DB password | `FX8oT1ozHjnTGzvWgyaEOwtGo6kQCL` (в `~/.ai/env/keys.env` как `SUPABASE_DB_PASSWORD`) |
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
postgresql+asyncpg://postgres:05cad91ad8a2ebec721de200709dfb2d@supabase-db:5432/postgres
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
# См. frontend/.env, bot.env, backend/cp.env
```
