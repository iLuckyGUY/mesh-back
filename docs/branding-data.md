# Branding Data — Mesh CloudWEB

Извлечено из старого дампа mesh_cp (pg_mesh_cp_2026-05-12_22-38.dump).
Восстановлено на локальный PostgreSQL в БД `restore_mesh_cp`.

---

## 1. Remnawave Settings — таблица `remnawave_settings`

**Поле:** `branding_settings`

Источник: `restore_mesh_cp → public.remnawave_settings`

```json
{
  "title": "Mesh 🗽 CloudWEB",
  "logoUrl": "https://wplogobit.wordpress.com/wp-content/uploads/2026/04/favicon.webp"
}
```

Назначение: отображается в личном кабинете (шапка, название сервиса, логотип).

---

## 2. Subscription Page Config — таблица `subscription_page_config`

### 2a. `brandingSettings`

Источник: `restore_mesh_cp → public.subscription_page_config → поле config → ключ brandingSettings`

```json
{
  "title": "Join 🗽 Mesh",
  "logoUrl": "https://wplogobit.wordpress.com/wp-content/uploads/2026/04/favicon.webp",
  "supportUrl": "https://t.me/ProxyMeshCloudbot"
}
```

Назначение: отображается на странице подписки (заголовок, логотип, ссылка поддержки).

### 2b. `baseSettings`

Источник: `restore_mesh_cp → public.subscription_page_config → поле config → ключ baseSettings`

```json
{
  "metaTitle": "Join Mesh 🗽 CloudWEB"
}
```

Назначение: meta-тег title для страницы подписки.

---

## 3. Логотип

**URL:** `https://wplogobit.wordpress.com/wp-content/uploads/2026/04/favicon.webp`

Используется в:
- Remnawave branding (кабинет)
- Subscription page branding (страница подписки)

---

## Сводка

| Раздел | Ключ | Значение |
|---|---|---|
| remnawave_settings.branding_settings | title | Mesh 🗽 CloudWEB |
| remnawave_settings.branding_settings | logoUrl | https://wplogobit.wordpress.com/wp-content/uploads/2026/04/favicon.webp |
| subscription_page_config.brandingSettings | title | Join 🗽 Mesh |
| subscription_page_config.brandingSettings | logoUrl | https://wplogobit.wordpress.com/wp-content/uploads/2026/04/favicon.webp |
| subscription_page_config.brandingSettings | supportUrl | https://t.me/ProxyMeshCloudbot |
| subscription_page_config.baseSettings | metaTitle | Join Mesh 🗽 CloudWEB |
