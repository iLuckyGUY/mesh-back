# mesh-build-deploy — Сборка, CI/CD и деплой

## Структура репозиториев

| Компонент | GitHub (форк) | Upstream | Docker Hub | Место в монорепе |
|---|---|---|---|---|
| **mesh-cp** (панель) | `iLuckyGUY/mesh-cp` | `remnawave/backend` | `iluckyguy/mesh-cp` | `backend/mesh-cp/` (отдельный git) |
| **mesh-page** (страница) | `iLuckyGUY/mesh-page` | `remnawave/subscription-page` | `iluckyguy/mesh-page` | `backend/mesh-page/` (отдельный git) |
| **mesh-bot** | `iLuckyGUY/mesh-bot` | `fr1ngg/remnawave-bedolaga-telegram-bot` | `iluckyguy/mesh-bot` | `frontend/mesh-bot/` (в монорепе) |
| **mesh-app** | `iLuckyGUY/mesh-app` | `BEDOLAGA-DEV/bedolaga-cabinet` | `iluckyguy/mesh-app` | `frontend/mesh-app/` (в монорепе) |

## Сборка образов

### mesh-cp и mesh-page — отдельные репозитории

У каждого свой `.github/workflows/build.yml` в корне репозитория.

**Триггеры:**
```yaml
on:
  push:
    branches: [main]       # → iluckyguy/*:latest
    tags: ['v*']           # → iluckyguy/*:vX.Y.Z
  pull_request:
    branches: [main]       # → только сборка, без пуша
```

**Тэги:** обязательно с префиксом `v` (например `v2.8.0`, `v7.2.6`) — иначе workflow не сработает.

**Архитектуры:** `linux/amd64 + linux/arm64` (multi-arch).

**Секреты GitHub (repo → Settings → Secrets and variables → Actions):**
- `DOCKER_USERNAME` = `iluckyguy`
- `DOCKER_PASSWORD` = пароль от Docker Hub

### mesh-bot — в монорепе

Workflow: `frontend/mesh-bot/.github/workflows/docker-hub.yml`
Публикует на `iluckyguy/mesh-bot`.

### Fallback: ручная сборка

Если GitHub Actions не сработал (кончились минуты, ошибка):
```bash
# mesh-cp
cd backend/mesh-cp
docker buildx build --platform linux/amd64 \
  --tag iluckyguy/mesh-cp:latest --tag iluckyguy/mesh-cp:<version> \
  --push .

# mesh-page
cd backend/mesh-page
docker buildx build --platform linux/amd64 \
  --tag iluckyguy/mesh-page:latest --tag iluckyguy/mesh-page:<version> \
  --push .
```

## Ребейз на новый upstream

### mesh-cp
```bash
cd backend/mesh-cp

# Подтянуть upstream
git fetch upstream --tags

# Создать ветку от нового тэга
git checkout -b rebase <новый-тэг-upstream>

# Снять наши CI-коммиты (только build.yml + .dockerignore)
# Обычно это коммиты с префиксом "ci:" или "fix:" от iLuckyGUY
# Смотрим, какие коммиты наши:
git log upstream/main..main --oneline

# Удаляем upstream workflow-файлы (они не нужны в форке):
rm .github/workflows/build-and-push.yml .github/workflows/build-dev.yml \
   .github/workflows/deploy-lib.yml .github/workflows/push-openapi-specs.yml \
   .github/workflows/release-to-panel.yml 2>/dev/null

# Добавляем наш build.yml + .dockerignore (создать из предыдущего main)
# Создать если ещё нет:
#   .github/workflows/build.yml — CI для iluckyguy/mesh-cp
#   .dockerignore

# Проверить версию в package.json (должна быть от upstream)
git log -1 --format="%H"  # проверить, что HEAD на новом тэге

# Закоммитить
git add -A && git commit -m "chore: rebase on upstream v<версия>"

# Переместить main и запушнить
git checkout main && git reset --hard rebase
git push origin main --force --follow-tags
git push origin v<версия> --force
```

### mesh-page
Аналогично mesh-cp, но:

1. Есть дополнительный файл `package.json` в корне (версия для трекинга) — обновить вручную
2. Не забудьте удалить `dev_frontend` если он появится — это локальная симлинка
3. `.dockerignore` уже есть в upstream, свои CI-файлы только build.yml

```bash
cd backend/mesh-page
git fetch upstream --tags
git checkout -b rebase <новый-тэг-upstream>

# Удалить upstream workflow
rm .github/workflows/build-and-push.yml .github/workflows/build-and-push-dev.yml 2>/dev/null

# Создать build.yml + package.json
# build.yml — CI для iluckyguy/mesh-page
# package.json — {"name":"mesh-page","version":"X.Y.Z"}

git add -A && git commit -m "chore: rebase on upstream v<версия>"
git checkout main && git reset --hard rebase
git push origin main --force --follow-tags
git push origin v<версия> --force
```

## Деплой (Portainer)

Настроен auto-pull каждые 4 минуты для стека `mesh-cw` (id 110).
Портаиновский стек обновляет mesh-cp, mesh-page, redis-cp.

После пуша образа на Docker Hub — Portainer сам подхватит в течение 4 минут.
Принудительно: Portainer → Stacks → mesh-cw → Update stack → Pull images → Deploy.

## Upstream-репозитории

| Компонент | GitHub | Docker Hub |
|---|---|---|
| mesh-cp | `remnawave/backend` | `remnawave/backend` (также тэг `2`) |
| mesh-page | `remnawave/subscription-page` | `remnawave/subscription-page` |
| mesh-bot | `fr1ngg/remnawave-bedolaga-telegram-bot` | `fr1ngg/remnawave-bedolaga-telegram-bot` |
| mesh-app | `BEDOLAGA-DEV/bedolaga-cabinet` или `fr1ngg/bedolaga-cabinet` | — |
| frontend | `remnawave/frontend` (встраивается в mesh-cp при сборке) | — |

## Полезные команды

```bash
# Проверить текущую версию upstream
curl -s https://api.github.com/repos/remnawave/backend/releases/latest \
  | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('tag_name','N/A'))"

curl -s https://api.github.com/repos/remnawave/subscription-page/releases/latest \
  | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('tag_name','N/A'))"

# Проверить образ на Docker Hub
curl -s https://hub.docker.com/v2/repositories/iluckyguy/mesh-cp/tags/latest \
  | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('last_updated','N/A'))"

# Дамп БД mesh_cp с сервера
ssh root@fra-1-hm-001-cloudweb-root \
  "docker exec PostgreSQL pg_dump -U postgres -d mesh_cp --no-owner --no-acl" \
  | gzip > backup_mesh_cp_$(date +%Y%m%d_%H%M%S).sql.gz
```
