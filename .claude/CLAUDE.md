# mesh-cloudweb — Project Rules

> Mesh ecosystem: mesh-cp (Remnawave panel) + mesh-page (sub page) + mesh-bot (Telegram bot) + mesh-app (Cabinet SPA).
> Deploy via 3 Portainer stacks on shared `mesh-net`.

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
| `control/prod.env` | Stack mesh-control (Portainer) | только `${VAR}` из `docker-compose.control.yml` |
| `backend/prod.env` | Stack mesh-services (Portainer) | только `${VAR}` из `docker-compose.services.yml` |
| `tunnel/tunnel.env` | Туннель | `CF_TUNNEL_TOKEN` + опции |

## 2. Правила создания deploy env

- **Полная точная копия** `.env.sample` / `.env.example`: каждая строка, каждый комментарий, каждый отступ сохраняются.
- **Ничего не вырезать и не удалять** из оригинального файла.
- **Только значения** меняются на реальные production-данные из `full-prod.env`.
- Если в `full-prod.env` нет значения для переменной — оставить как в sample/example.
- Новые переменные (которых нет в sample/example, но есть в `full-prod.env`) добавляются в конец файла, если они реально используются приложением.

## 3. Правила stack env (control/prod.env, backend/prod.env)

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
