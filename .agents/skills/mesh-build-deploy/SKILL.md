# mesh-cloudweb: Build & Deploy Skill

> Два Portainer стека, два env-файла, один shared `mesh-net`.
> Всё крутится на `msk-1-tw-001-cloudweb-root` (72.56.35.78).

---

## 1. Структура репозиториев

### Монорепозиторий `mesh-cloudweb` (локальный — оркестрация)

```
mesh-cloudweb/
├── frontend/                    # юзер-сервисы (бот + кабинет)
│   ├── docker-compose.yml       → стек mesh-services (Redis + bot + app)
│   ├── .env                     → env для mesh-services
│   ├── bot.env                  → расширенный env mesh-bot (80+ vars)
│   ├── mesh-bot/                → embedded fork + Dockerfile + whitelabel патчи
│   ├── mesh-app/                → embedded fork (git subrepo)
│   └── Caddyfile                → reverse proxy для mesh-app
├── backend/                     # панель управления (cp + sub page)
│   ├── docker-compose.yml       → стек mesh-control (Redis + cp + page)
│   ├── cp.env                   → env для mesh-control
│   ├── mesh-cp/                 → embedded fork
│   └── mesh-page/               → embedded fork
├── tunnel/
│   ├── docker-compose.yml       → стек mesh-tunnel (cloudflared)
│   └── config.yml               → ingress rules (4 домена → caddy-proxy:80)
└── .Codex/
    └── AGENTS.md                → правила проекта
```

### Форки-репозитории (`github.com/iLuckyGUY/*`) — независимые git-репозитории

| Репозиторий | Upstream | Назначение |
|---|---|---|
| `github.com/iLuckyGUY/mesh-bot` | `BEDOLAGA-DEV/remnawave-bedolaga-telegram-bot` | Telegram bot (Python, aiogram) |
| `github.com/iLuckyGUY/mesh-app` | `BEDOLAGA-DEV/bedolaga-cabinet` | Cabinet SPA |
| `github.com/iLuckyGUY/mesh-cp` | `remnawave/backend` | Remnawave panel (NestJS) |
| `github.com/iLuckyGUY/mesh-page` | нет upstream | Sub page (Node.js) |

**Важно:** имена форков с префиксом `mesh-`, оригинальные upstream репозитории — без.

---

## 2. Portainer стеки (production на сервере)

| Стек | Состав | Env-файл | Сеть |
|---|---|---|---|
| `mesh-services` | `redis-bot` + `mesh-bot` + `mesh-app` | `frontend/.env` + встроенные def | `mesh-net` |
| `mesh-control` | `redis-cp` + `mesh-cp` + `mesh-page` | `backend/cp.env` + встроенные def | `mesh-net` |
| `mesh-tunnel` | `cloudflared` | `tunnel/mesh-trust.env` (только CF_TOKEN) | `mesh-net` |

**Важно:** Portainer НЕ поддерживает `env_file:`. Все переменные вставляются прямо в UI.

**Как деплоить:**
1. Открыть Portainer → Stacks → Add stack
2. Имя: `mesh-services` (или `mesh-control`, `mesh-tunnel`)
3. Build method: Web editor (вставить содержимое `docker-compose.yml`)
4. Environment variables: Switch to "Advanced mode" → вставить содержимое `.env`
5. Deploy

---

## 3. Два env-файла (ключевые переменные)

### `frontend/.env` — для стека mesh-services (бот + кабинет)

Обязательные переменные (≈15 ключевых из 43):
```bash
# База (локальный PostgreSQL, mesh_bot база)
DATABASE_URL_BOT=postgresql+asyncpg://postgres:${POSTGRES_PASSWORD}@PostgreSQL:5432/mesh_bot

# Redis
REDIS_BOT_PASSWORD=...

# Telegram
BOT_TOKEN=...
ADMIN_IDS=...
PROXY_URL=socks5://...       # SOCKS5 для обхода блокировок

# Cabinet
CABINET_URL=https://mesh.cloudweb.name
CABINET_JWT_SECRET=...
CABINET_ALLOWED_ORIGINS=https://mesh.cloudweb.name

# Remnawave API
REMNAWAVE_API_KEY_BOT=...
REMNAWAVE_API_URL=http://mesh-cp:3000   # Docker DNS, не домен!

# Уведомления
ADMIN_NOTIFICATIONS_CHAT_ID=-1003936506855
```

### `backend/cp.env` — для стека mesh-control (панель + страница подписок)

Обязательные (≈10 ключевых из 35):
```bash
# База (локальный PostgreSQL, mesh_cp база)
DATABASE_URL=postgresql://postgres:${POSTGRES_PASSWORD}@PostgreSQL:5432/mesh_cp

# JWT
JWT_AUTH_SECRET=...
JWT_API_TOKENS_SECRET=...

# Домены
PANEL_DOMAIN=mesh-cp.cloudweb.name
SUB_PUBLIC_DOMAIN=mesh-go.cloudweb.name

# Webhook — идёт в mesh-bot через docker DNS
WEBHOOK_URL=https://mesh-api.cloudweb.name/remnawave-webhook

# Telegram (нотификации)
TELEGRAM_ADMIN_ID=...

# Метрики
METRICS_USER=admin
METRICS_PASS=...
```

---

## 4. Сборка образов (build)

### 4.1. mesh-bot (с whitelabel патчами)

**Вариант A — локальная сборка на macOS:**
```bash
# Сборка из embedded fork с авто-применением патчей
docker compose -f frontend/docker-compose.yml build --no-cache mesh-bot

# Патчи лежат в frontend/mesh-bot/patches/ и накладываются прямо в Dockerfile
```

**Вариант B — сборка из fork-репозитория (для CI/CD):**
```bash
git clone git@github.com:iLuckyGUY/mesh-bot.git
cd mesh-bot
docker build -t iluckyguy/mesh-bot:latest .
docker push iluckyguy/mesh-bot:latest
```

**Вариант C — push в GitHub → GitHub Actions:**
- Триггер: push в `iLuckyGUY/mesh-bot` ветка `master`
- Сборка: `docker build -t ghcr.io/iluckyguy/mesh-bot:latest .`
- Пуш: `ghcr.io/iluckyguy/mesh-bot:latest` (GitHub Container Registry)
- Параллельно: `iluckyguy/mesh-bot:latest` (Docker Hub)

**Как обновить upstream:**
```bash
# 1. В mesh-cloudweb-ols/mesh-bot стянуть новый апстрим
cd mesh-cloudweb-ols/mesh-bot
git fetch upstream
git merge upstream/master
# разрешить конфликты

# 2. Собрать
docker compose -f frontend/docker-compose.yml build --no-cache mesh-bot

# 3. Запустить
docker compose -f frontend/docker-compose.yml up -d mesh-bot
```



### 4.2. mesh-cp (Remnawave panel)

**Вариант A — локальная сборка:**
```bash
docker build -t iluckyguy/mesh-cp:latest ./backend/mesh-cp
docker push iluckyguy/mesh-cp:latest
```

**Вариант B — CI/CD:**
```yaml
# .github/workflows/build.yml в iLuckyGUY/mesh-cp
# Триггер: push в master
# docker build -t iluckyguy/mesh-cp:latest ./backend/mesh-cp
# docker push iluckyguy/mesh-cp:latest
```

**Как обновить upstream (Remnawave):**
```bash
cd mesh-cloudweb-ols/mesh-cp
git remote add upstream https://github.com/remnawave/backend
git fetch upstream
git merge upstream/main
git push origin master
```

### 4.3. mesh-app и mesh-page

```bash
docker build -t iluckyguy/mesh-app:latest ./frontend/mesh-app
docker build -t iluckyguy/mesh-page:latest ./backend/mesh-page
docker push iluckyguy/mesh-app:latest
docker push iluckyguy/mesh-page:latest
```

---

## 5. Деплой на сервер (пошагово)

### 5.1. Через образы (рекомендуется)

```bash
# 1. Собрать и запушить образы локально
docker build -t iluckyguy/mesh-bot:latest ./frontend/mesh-bot
docker push iluckyguy/mesh-bot:latest

# 2. На сервере — редеплой через Portainer
# Stacks → mesh-services → Update → Force re-pull → Deploy
```

### 5.2. Через Portainer Webhook

```bash
# В настройках стека включить Webhook
# После пуша образа:
curl -X POST https://portainer.cloudweb.name/api/webhooks/${HOOK_ID}
```

### 5.3. Через Portainer API (curl)

```bash
JWT=$(curl -s -X POST https://portainer.cloudweb.name/api/auth \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"${PORTAINER_PASS}"}' | jq -r '.jwt')

curl -X POST https://portainer.cloudweb.name/api/stacks/${STACK_ID}/redeploy \
  -H "Authorization: Bearer $JWT" \
  -H "Content-Type: application/json" \
  -d '{"PullImage":true,"Prune":true}'
```

---

## 6. Полный цикл обновления (end-to-end)

```
 1. Правка кода в mesh-cloudweb-ols/<repo>/
    (или в embedded fork внутри монорепозитория)

 2. git commit + git push в github.com/iLuckyGUY/<repo>
    → GitHub Actions собирает образ и пушит в registry

 3. Portainer: Update stack → Force re-pull → Deploy
    (или Webhook / API — см. 5.2, 5.3)

 4. Проверить логи: Portainer → Stack → Container → Logs

 5. Если mesh-bot → alembic upgrade head (если миграции)
    docker exec mesh-bot alembic upgrade head
    Или: npx prisma migrate deploy (для mesh-cp)
```

---

## 7. Whitlebal патчи (только mesh-bot)

Патчи лежат в `frontend/mesh-bot/patches/` и накладываются в Dockerfile (`RUN /patches/apply.sh`):
```
apply.sh        → 15 sed-блоков замены
whitelabel.env  → константы (COMMUNITY_URL, DEVELOPER_CONTACT, etc.)
```

**Как добавить новый патч:**
1. Найти строку в upstream коде
2. Добавить блок `sed_checked` в `apply.sh`
3. Если строка в конфиге — добавить переменную в `whitelabel.env`

**Как отключить патч:** закомментировать вызов в `apply.sh`.

**Как обновить upstream (с сохранением патчей):**
```bash
# 1. Смержить новый апстрим (см. выше)
# 2. Собрать — патчи наложатся автоматически
docker compose -f frontend/docker-compose.yml build --no-cache mesh-bot
# 3. Проверить логи сборки на ⚠️ warnings (строка не найдена)
# 4. Если warnings — обновить apply.sh под новый код
```

---

## 8. Импорты и модули (mesh-bot)

После патча `remnawave_api → mesh_api`:
```python
# Было (upstream)
from remnawave_api import RemnawaveAPI

# Стало (white-label) — оба варианта работают:
from mesh_api import RemnawaveAPI      # предпочтительно
from remnawave_api import RemnawaveAPI # тоже работает (копия модуля)
```

Патч создаёт копию `remnawave_api/` → `mesh_api/` и заменяет все импорты.

---

## 9. Переменные: где что лежит

| Где | Что хранится |
|---|---|
| `~/.ai/env/keys.env` | `POSTGRES_PASSWORD`, `DOCKER_TOKEN`, `GH_PAT` |
| `frontend/.env` | runtime env для mesh-services (bot + app) |
| `frontend/bot.env` | расширенный env mesh-bot (80+ vars, не в Portainer, только для справки) |
| `backend/cp.env` | runtime env для mesh-control (cp + page) |
| `tunnel/mesh-trust.env` | `CF_TUNNEL_TOKEN` |
| Portainer UI | копии env-файлов (вставлены руками) |

**Правило:** секреты только в `keys.env`, в `.env` файлах — только пароль БД и API ключи сервисов.

---

## 10. Частые операции

### Поменять пароль БД

```bash
# 1. Новый пароль в ~/.ai/env/keys.env → POSTGRES_PASSWORD
# 2. Обновить в frontend/.env, backend/cp.env
# 3. docker exec PostgreSQL psql -U postgres -c "ALTER USER postgres PASSWORD '${NEW_PASS}';"
# 4. Передеплоить оба стека
```

### Посмотреть логи

```bash
# Через Portainer:
Stacks → mesh-services → Container name → Logs

# Через SSH:
ssh root@72.56.35.78
docker logs -f mesh-bot --tail 100
```

### Зайти в консоль БД

```bash
docker exec -it PostgreSQL psql -U postgres -d mesh_bot
```

### Миграции

```bash
# Bot (Alembic)
docker exec mesh-bot alembic upgrade head

# CP (Prisma)
docker exec mesh-cp npx prisma migrate deploy
```
