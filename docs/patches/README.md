# patches/

Container-level patches applied during the 2026-05-19 session.

## Changes applied to `docker-compose.yml` (committed)

1. `mesh-cp > WEBHOOK_ENABLED: "false"` → `"true"`
   - Enables mesh-cp to push events (user/node/service changes) to the bot via webhook.
   - Webhook URL: `https://mesh-api.cloudweb.name/remnawave-webhook`
   - HMAC-SHA256 signed with `WEBHOOK_SECRET_HEADER`.

2. Added `mesh-api.cloudweb.name` HTTPS block to Caddy
   - Matches the existing `mesh-api.cloudweb.name:80` block but for port 443 (HTTPS).
   - Auto-obtains Let's Encrypt TLS certificate.
   - Required for mesh-cp webhook POSTs to `https://mesh-api.cloudweb.name/remnawave-webhook`.
   - Proxies to `mesh-bot:8080`, same routing as HTTP (strip `/api/*` prefix).

## Changes applied to `prod.env` (gitignored)

1. `TELEGRAM_API_URL=https://your-telegram-proxy.workers.dev` → commented out (`# TELEGRAM_API_URL=...`)
   - Reason: domain `your-telegram-proxy.workers.dev` returns NXDOMAIN. Bot's `bot_factory.py:17`
     reads this var; when non-null, the bot sends all Telegram API calls to this URL instead
     of `api.telegram.org`. This caused DNS resolution failure → bot crash loop.
   - Fix verified: bot goes through SOCKS5 proxy directly to `api.telegram.org`.

2. `REMNAWAVE_AUTO_SYNC_ENABLED=true` — already present (was added earlier, kept)
3. `REMNAWAVE_WEBHOOK_ENABLED=true` — already present (was added earlier, kept)
   - `REMNAWAVE_WEBHOOK_SECRET` matches `WEBHOOK_SECRET_HEADER` in docker-compose.yml.

## Proxy routing

- `PROXY_URL` (mesh-bot) and `TELEGRAM_BOT_PROXY` (mesh-cp) read from `prod.env` and `cp.env`.
- NO hardcoded proxy IPs in TypeScript/Python source code.
- Validation in `mesh-bot/app/config.py:1067-1090` requires `socks5://`, `socks5h://`, or `socks4://`.

## Webhook verification (prod, 2026-05-19)

- `19:58:13` — bot log: "RemnaWave webhook router mounted at /remnawave-webhook"
- `19:58:13` — bot log: "• RemnaWave: https://mesh-api.cloudweb.name/remnawave-webhook"
- `10:21:04` — bot log: "RemnaWave webhook received: service.panel_started"
- `10:21:05` — bot log: "Уведомление отправлено в чат" (notification sent to Telegram) ✅

## Future work

- `remnawave_retry_queue.py` — JSON-file-based retry queue for bot → panel sync (not committed yet).
- `proxy-check.middleware.js` — function-style middleware for mesh-page v7.2.1 (`ExceptionFilterMeta` not exported).
- `not-found-exception.filter.js` — filter class without `ExceptionFilterMeta` dependency.
