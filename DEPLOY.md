# mesh-cloudweb — Deploy Guide

## Architecture

3 Portainer stacks, 1 shared Docker network `mesh-net`, 0 reverse proxy (traffic through CF Tunnel).

### Стеки

| Стек | Portainer name | Services |
|---|---|---|
| Control | `mesh-control` | mesh-cp + mesh-page + redis-cp |
| Services | `mesh-services` | mesh-bot + mesh-app + redis-bot |
| Tunnel | `mesh-tunnel` | cloudflared-tunnel |

### Сеть

```bash
docker network create mesh-net
```

Все три стека используют `network: mesh-net external: true`.

---

## Таблица доменов

Всё идёт через Cloudflare Tunnel → контейнер напрямую.

| Домен | CF Tunnel → | Описание |
|---|---|---|
| `mesh-cp.cloudweb.name` | `mesh-cp:3000` | Панель Remnawave (admin UI + API) |
| `mesh-go.cloudweb.name` | `mesh-page:3000` | Страница подписки `/go/:shortUuid` |
| `mesh.cloudweb.name` | `mesh-app:80` | Кабинет пользователя (SPA) |
| `mesh-api.cloudweb.name` | `mesh-bot:8080` | Web API бота + вебхуки |

### Как работает `mesh.cloudweb.name`

Nginx внутри mesh-app обрабатывает:

```
mesh.cloudweb.name/                → nginx serve SPA
mesh.cloudweb.name/api/cabinet/*   → nginx → proxy_pass → mesh-bot:8080/ (prefix stripped)
```

---

## Образы

Docker Hub, без `ghcr.io/`:

| Компонент | Имя образа |
|---|---|
| mesh-cp | `iluckyguy/mesh-cp:latest` |
| mesh-page | `iluckyguy/mesh-page:latest` |
| mesh-bot | `iluckyguy/mesh-bot:latest` |
| mesh-app | `iluckyguy/mesh-app:latest` |

---

## Deploy

### 1. Создать сеть

```bash
docker network create mesh-net
```

### 2. Собрать и запушить образы

```bash
# backend/ — панель управления
docker build -t iluckyguy/mesh-cp:latest ./mesh-cp
docker build -t iluckyguy/mesh-page:latest ./mesh-page
docker push iluckyguy/mesh-cp:latest
docker push iluckyguy/mesh-page:latest

# frontend/ — юзер-сервисы
docker build -t iluckyguy/mesh-bot:latest ./mesh-bot
docker build -t iluckyguy/mesh-app:latest ./mesh-app
docker push iluckyguy/mesh-bot:latest
docker push iluckyguy/mesh-app:latest
```

### 3. Portainer — Stack 1: mesh-control

- **Name:** `mesh-control`
- **Build method:** `Stack`
- **Webhook:** optional
- **Compose:** paste contents of `backend/docker-compose.yml`
- **Environment variables:** paste contents of `backend/cp.env`
- **Deploy**

### 4. Portainer — Stack 2: mesh-services

- **Name:** `mesh-services`
- **Build method:** `Stack`
- **Compose:** paste contents of `frontend/docker-compose.yml`
- **Environment variables:** paste contents of `frontend/.env`
- **Deploy**

### 5. Portainer — Stack 3: mesh-tunnel

- **Name:** `mesh-tunnel`
- **Build method:** `Stack`
- **Compose:** paste contents of `tunnel/docker-compose.yml`
- **Environment variables:** paste contents of `tunnel/tunnel.env` (предварительно вписать реальный `CF_TUNNEL_TOKEN`)
- **Deploy**

Туннель ни от кого не зависит — просто соединяется с Cloudflare и ждёт инструкций.

### 6. Cloudflare Tunnel — Public Hostnames

Добавить в настройках туннеля "Mesh Project Trust":

| Hostname | Service |
|---|---|
| `mesh-cp.cloudweb.name` | `http://localhost:3000` |
| `mesh-go.cloudweb.name` | `http://localhost:3010` |
| `mesh.cloudweb.name` | `http://localhost:3020` |
| `mesh-api.cloudweb.name` | `http://localhost:8080` |

### 7. Проверка

```bash
curl https://mesh-cp.cloudweb.name/docs
curl https://mesh-go.cloudweb.name/X0WjdkqetPzZEZKMAPy936rX
curl https://mesh.cloudweb.name
```

---

## Файлы

```
mesh-cloudweb/
├── backend/                         # панель управления
│   ├── docker-compose.yml           # mesh-cp + mesh-page + redis-cp
│   ├── cp.env                       # stack env for Portainer (mesh-control)
│   ├── mesh-cp/
│   │   ├── .env.sample              # оригинал автора — НЕ ТРОГАТЬ
│   │   └── .env                     # локальный дев (gitignored)
│   └── mesh-page/
│       ├── .env.sample              # оригинал автора — НЕ ТРОГАТЬ
│       └── .env                     # локальный дев (gitignored)
│
├── frontend/                        # юзер-сервисы
│   ├── docker-compose.yml           # mesh-bot + mesh-app + redis-bot
│   ├── .env                         # stack env for Portainer (mesh-services)
│   ├── bot.env                      # расширенный env mesh-bot (80+ vars)
│   ├── mesh-bot/
│   │   ├── .env.example             # оригинал автора — НЕ ТРОГАТЬ
│   │   └── .env                     # локальный дев (gitignored)
│   └── mesh-app/
│       ├── .env.example             # оригинал автора — НЕ ТРОГАТЬ
│       └── .env                     # локальный дев (gitignored)
│
├── tunnel/
│   ├── docker-compose.yml           # cloudflared-tunnel
│   └── tunnel.env                   # deploy env — вписать CF_TUNNEL_TOKEN
│
└── DEPLOY.md                        # этот файл
