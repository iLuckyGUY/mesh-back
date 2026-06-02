# Mesh White-Label: изменения относительно upstream

> Upstream: BEDOLAGA-DEV/remnawave-bedolaga-telegram-bot  
> Fork: iLuckyGUY/mesh-bot  
> Последний merge: v3.56.0 (2026-05-16)

---

## Как обновлять в будущем

1. Добавить upstream remote (уже есть): `git remote add upstream https://github.com/BEDOLAGA-DEV/remnawave-bedolaga-telegram-bot.git`
2. Fetch тегов: `git fetch upstream --tags`
3. Создать ветку от нового тега: `git checkout -b update-vX.Y.Z vX.Y.Z`
4. Применить патч наших изменений поверх нового тега:
   ```bash
   git diff v<PREV_TAG>..main > /tmp/mesh-custom.patch
   git apply --3way /tmp/mesh-custom.patch
   ```
5. Исправить конфликты (если есть), прогнать `uvx ruff format` на изменённых файлах
6. Обновить версию в `Dockerfile`: `ARG VERSION="vX.Y.Z"`
7. Коммит → force-push в main → CI собирает образ
8. На VPS: `docker compose --env-file prod.env pull mesh-bot && docker compose --env-file prod.env up -d --force-recreate mesh-bot`

---

## Изменения относительно upstream

### 1. Переименование модуля: `remnawave_api` → `mesh_api`

**Файл:** `app/external/mesh_api.py` (был `remnawave_api.py`)  
**Причина:** white-label — убрать упоминание "remnawave" из кода.

Все импорты во всех файлах изменены с:
```python
from app.external.remnawave_api import ...
```
на:
```python
from app.external.mesh_api import ...
```

**Затронутые файлы:**
- `app/services/remnawave_service.py`
- `app/services/subscription_service.py`
- `app/services/maintenance_service.py`
- `app/services/monitoring_service.py`
- `app/services/startup_notification_service.py`
- `app/services/account_merge_service.py`
- `app/cabinet/routes/admin_users.py`
- `app/handlers/admin/users.py`
- `app/logging_config.py` (имя логгера)

---

### 2. White-label поля в `app/config.py`

Добавлены 7 полей после `SUPPORT_USERNAME`:

```python
DEVELOPER_CONTACT_URL: str = 'https://t.me/MyTeleGO'
COMMUNITY_URL: str = 'https://t.me/CloudWEBname'
BOT_DISPLAY_NAME: str = 'Remnawave Bedolaga Bot'

GITHUB_BOT_URL: str = 'https://github.com/fr1ngg/remnawave-bedolaga-telegram-bot'
GITHUB_CABINET_URL: str = 'https://github.com/iLuckyGUY/mesh-app'
CABINET_REPO: str = 'iLuckyGUY/mesh-app'
```

Задаются через `prod.env` на VPS — переопределяют дефолты.

---

### 3. Подключение полей config к коду (было захардкожено)

Upstream хардкодит URLs и имя бота прямо в файлах. Мы заменили на вызовы `settings.*`:

| Файл | Было | Стало |
|------|------|-------|
| `app/services/startup_notification_service.py` | `GITHUB_BOT_URL: Final[str] = 'https://github.com/BEDOLAGA-DEV/...'` × 4 константы | `_get_github_bot_url()` → `settings.GITHUB_BOT_URL` |
| `app/services/startup_notification_service.py` | `'<b>Remnawave Bedolaga Bot</b>'` (×2 — старт и краш) + `'Remnawave:'` в статусе | `_get_bot_display_name()` → `settings.BOT_DISPLAY_NAME` |
| `app/middlewares/global_error.py` | `DEVELOPER_CONTACT_URL: Final[str] = 'https://t.me/fringg'` и `'<b>Remnawave Bedolaga Bot</b>'` | `_get_developer_contact_url()` и `_get_bot_display_name()` → `settings.*` |
| `app/cabinet/routes/admin_updates.py` | `CABINET_REPO = 'BEDOLAGA-DEV/bedolaga-cabinet'` | `_cabinet_repo()` → `settings.CABINET_REPO` |

**Паттерн:** вместо `Final[str] = '...'` — функция-геттер, читающая из `settings` при вызове (не при импорте), что позволяет переопределять через env.

**При обновлении upstream:** проверять `startup_notification_service.py` и `global_error.py` на новые хардкоды строки `'Remnawave Bedolaga Bot'`.

---

### 4. Dockerfile

- Версия: `ARG VERSION="v3.56.0"`
- Labels изменены на Mesh-брендинг:
  ```
  org.opencontainers.image.title="CloudWEB Mesh Bot"
  org.opencontainers.image.source="https://github.com/iLuckyGUY/mesh-bot"
  org.opencontainers.image.vendor="iLuckyGUY"
  ```

---

### 5. CI/CD: `.github/workflows/build.yml`

- Пушит в `ghcr.io/iluckyguy/mesh-bot:latest` и `:${{ github.sha }}`
- Auth: `secrets.GHCR_TOKEN || secrets.GITHUB_TOKEN`
- Platforms: `linux/amd64,linux/arm64`
- Триггер: push в `main` + `workflow_dispatch`

**Секрет `GHCR_TOKEN`** должен быть выставлен в настройках репо (GitHub → Settings → Secrets). Токен хранится в `iCloud/Keys/global.env`.

---

### 6. Отключён `docker-hub.yml`

Upstream workflow "BedolagaBot" пытался пушить в Docker Hub — отключён (нет учётных данных, используем GHCR).

---

### 7. Дополнительные файлы

- `docker-compose.yml` — полный стек для локальной разработки
- `docs/blacklist.txt` — список заблокированных пользователей
- `vpn_logo.png` — логотип Mesh

---

## Что НЕ меняли

- Логика бизнес-процессов (тарифы, платежи, подписки)
- База данных и миграции
- Локализации (`app/localization/locales/`) — используются upstream-версии
- Все новые фичи v3.56.0 (device aliases, Stars fix, cabinet improvements)
