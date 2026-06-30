# Деплой Mesh CloudWEB

## Быстрый старт на новом сервере

```bash
# 1. Создать сеть
docker network create mesh-net

# 2. Запустить бэкенд (mesh-cp + mesh-page + redis-cp)
#    Предварительно: cp backend/cp.env → .env, заполнить секреты
cd backend
docker compose up -d

# 3. Запустить фронт (mesh-bot + mesh-app + redis-bot)
#    Предварительно: cp frontend/bot.env → .env, заполнить секреты
cd frontend
docker compose -f docker-compose-pg.yml up -d

# 4. Cloudflare Tunnel
docker run -d --name cloudflared-tunnel --restart unless-stopped \
  --network mesh-net \
  cloudflare/cloudflared:latest tunnel --no-autoupdate --protocol http2 \
  run --token "$CF_TUNNEL_TOKEN"
```

## Обновление образов

Образы собираются автоматически через GitHub Actions при пуше в main.
После пуша на Docker Hub — Portainer стеки подхватывают за ~4 мин.

Подробнее: [`skills/mesh-build-deploy/SKILL.md`](skills/mesh-build-deploy/SKILL.md)
