# Config Profiles + Xray JSON — Remnawave Panel State

<!-- Last reviewed: 2026-05-16 -->

## Config Profile: CloudWEB-Split

| Field | Value |
|---|---|
| **UUID** | `00000000-0000-0000-0000-000000000000` |
| **Name** | CloudWEB-Split |
| **View Position** | 1 |
| **Protocol** | VLESS + XHTTP + REALITY, port 443 |
| **Target (camouflage)** | `www.icloud.com:443` |
| **mode** | `auto` |
| **scMaxEachPostBytes** | `1000000` |
| **Created** | 2026-05-15 |

### PrivateKey
```
CAt1Qg9l7IlODpdNKSdTDWEE6MIIKjN4Qa4pX-tOQ0A
```

### PublicKey (pbk в подписке)
```
qqAAQmEaE2gIFHdW8aogSqHBl-tor9F5YsYpmfesOF8
```

### ShortIds
```
c6, b9526fc05cee5f, 96be80cd, 5038c1c7ad59c190, ad0cfb2a47f2, 1c64, 081489cb8d, 5b7ee1
```

### ServerNames
```
www.icloud.com
```

> **Почему icloud.com:** пока работает с `mode: auto`. Альтернатива — selfsteal: Caddy/Nginx на ноде, REALITY target = `127.0.0.1:443` → активное зондирование ТСПУ получает реальный ответ. Apple ограничил РФ (апрель 2026), поэтому при переходе на github.com нужна проверка.

---

## Nodes (2)

| UUID | Name | Address | Port | Country | Panel | VPN (RU) |
|------|------|---------|------|---------|-------|----------|
| `0ec14786-6978-4523-b2a3-574ae06b96fb` | US-Node-oo1 | 23.26.0.77 | 2222 | US | ✅ Connected | ❌ Не доступна из RU |
| `780aca89-03c4-4e8d-af79-c17c889341cb` | DE Node oo1 | 213.182.213.22 | 2222 | DE | ✅ Connected | ✅ ~400ms |

> **US нода**: xray работает (порт 443 открыт, TLS отвечает), но VPN-соединение из RU не устанавливается — вероятно ТСПУ блокирует IP 23.26.0.77. Нода подлежит замене (пользователь заменит самостоятельно).

## Hosts (2)

| UUID | Remark | Address | Port |
|------|--------|---------|------|
| `3b913a0c-65c1-4065-9aa5-d9dbe9493764` | US NYC 01 🇺🇸 | 23.26.0.77 | 443 |
| `9b09048b-714d-4f44-b3c7-26547eea3192` | DE FRA 01 🇩🇪 | 213.182.213.22 | 443 |

## Profile Inbounds (1)

| UUID | Tag | Type | Network | Security | Port |
|------|-----|------|---------|----------|------|
| `fb194bfc-4ce0-4ad5-8ba0-cd5711ede394` | VLESS_XHTTP_REALITY | vless | xhttp | reality | 443 |

## Inbound → Nodes
- `VLESS_XHTTP_REALITY` → US-Node-oo1 + DE Node oo1

---

## Profile Raw Config JSON (актуальный, в панели)

```json
{
  "log": {"loglevel": "warning"},
  "routing": {
    "rules": [
      {"ip": ["geoip:private"], "type": "field", "outboundTag": "BLOCK"},
      {"type": "field", "domain": ["geosite:private"], "outboundTag": "BLOCK"},
      {"type": "field", "protocol": ["bittorrent"], "outboundTag": "BLOCK"}
    ],
    "domainStrategy": "AsIs"
  },
  "inbounds": [{
    "tag": "VLESS_XHTTP_REALITY",
    "port": 443,
    "listen": "0.0.0.0",
    "protocol": "vless",
    "settings": {"clients": [], "decryption": "none"},
    "sniffing": {"enabled": false, "routeOnly": true, "destOverride": ["http", "tls", "quic"]},
    "streamSettings": {
      "network": "xhttp", "security": "reality",
      "xhttpSettings": {"host": "", "mode": "auto", "path": "/", "headers": {}, "xPaddingBytes": "100-1000", "scMaxBufferedPosts": 30, "scMaxEachPostBytes": "1000000", "scStreamUpServerSecs": "20-80"},
      "realitySettings": {"show": false, "xver": 0, "target": "www.icloud.com:443", "shortIds": ["c6", "b9526fc05cee5f", "96be80cd", "5038c1c7ad59c190", "ad0cfb2a47f2", "1c64", "081489cb8d", "5b7ee1"], "privateKey": "CAt1Qg9l7IlODpdNKSdTDWEE6MIIKjN4Qa4pX-tOQ0A", "serverNames": ["www.icloud.com"]}
    }
  }],
  "outbounds": [
    {"tag": "DIRECT", "protocol": "freedom"},
    {"tag": "BLOCK", "protocol": "blackhole"}
  ]
}
```

---

# Subscription Templates (в панели)

## 1. XRAY_JSON — "Default"
**UUID**: `a87a16e9-cb34-4aad-8b10-78257b277428` | **Position**: 1

```json
{
  "dns": {"servers": ["1.1.1.1", "1.0.0.1"], "queryStrategy": "UseIP"},
  "routing": {
    "rules": [{"type": "field", "protocol": ["bittorrent"], "outboundTag": "direct"}],
    "domainMatcher": "hybrid", "domainStrategy": "IPIfNonMatch"
  },
  "inbounds": [
    {"tag": "socks", "port": 10808, "listen": "127.0.0.1", "protocol": "socks", "settings": {"udp": true, "auth": "noauth"}, "sniffing": {"enabled": true, "routeOnly": false, "destOverride": ["http", "tls", "quic"]}},
    {"tag": "http", "port": 10809, "listen": "127.0.0.1", "protocol": "http", "settings": {"allowTransparent": false}, "sniffing": {"enabled": true, "routeOnly": false, "destOverride": ["http", "tls", "quic"]}}
  ],
  "outbounds": [{"tag": "direct", "protocol": "freedom"}, {"tag": "block", "protocol": "blackhole"}]
}
```

## 2. XRAY_JSON — "XRay-One" (split routing)
**UUID**: `46665184-20c4-4ab8-9c17-e4351814fbd6` | **Position**: 6
**Routing**: 🇷🇺 Russian sites → DIRECT, 🌐 International + blocked → PROXY

```json
{
  "dns": {
    "servers": [
      {"address": "77.88.8.8", "domains": ["geosite:ru", "regexp:.*\\.ru$"], "skipFallback": true},
      {"address": "https://1.1.1.1/dns-query", "domains": ["geosite:geolocation-!cn"]},
      "77.88.8.8"
    ],
    "queryStrategy": "UseIPv4"
  },
  "routing": {
    "rules": [
      {"type": "field", "protocol": ["bittorrent"], "outboundTag": "direct"},
      {"ip": ["geoip:private"], "type": "field", "outboundTag": "direct"},
      {"type": "field", "domain": ["1.1.1.1", "1.0.0.1", "dns.cloudflare.com"], "outboundTag": "proxy"},
      {
        "type": "field",
        "domain": [
          "cloudflare.com", "cloudflareaccess.com", "cfargotunnel.com", "argotunnel.com", "cloudflaretunnel.net",
          "sberbank.ru", "sber.ru", "sberpay.ru", "sbrf.ru",
          "tinkoff.ru", "t-bank.ru",
          "raiffeisen.ru", "raiffeisenbank.ru",
          "vtb.ru", "vtbonline.ru",
          "alfabank.ru", "alfa.ru",
          "gazprombank.ru", "rshb.ru", "pochtabank.ru", "rosbank.ru", "uralsib.ru", "sovcombank.ru",
          "gosuslugi.ru", "mos.ru",
          "nalog.ru", "nalog.gov.ru", "pfr.gov.ru", "sfr.gov.ru",
          "cbr.ru", "government.ru", "kremlin.ru",
          "rkn.gov.ru", "mil.ru", "mvd.ru", "fsb.ru", "fas.gov.ru",
          "minzdrav.gov.ru", "edu.ru", "minobrnauki.gov.ru",
          "yandex.ru", "yandex.net", "ya.ru", "yastatic.net", "yandexcloud.net",
          "vk.com", "vk.me", "vkontakte.ru", "vk.ru", "userapi.com", "vk-cdn.net",
          "ok.ru", "odnoklassniki.ru",
          "mail.ru", "list.ru", "bk.ru", "inbox.ru", "myteam.mail.ru", "mcs.mail.ru",
          "avito.ru", "avito.st",
          "wildberries.ru", "wbx-ru.com", "wb.ru",
          "ozon.ru", "ozon.st",
          "dns-shop.ru", "dns-home.ru", "citilink.ru", "eldorado.ru", "mvideo.ru", "svyaznoy.ru",
          "beeline.ru", "megafon.ru", "mts.ru", "tele2.ru", "rostelecom.ru",
          "1c.ru", "1c-dn.com", "kaspersky.ru", "drweb.ru",
          "2gis.ru", "2gis.com",
          "hh.ru", "headhunter.ru", "superjob.ru",
          "ivi.ru", "okko.tv", "more.tv", "kion.ru", "kinopoisk.ru", "premier.one", "rutube.ru",
          "rbc.ru", "ria.ru", "tass.ru", "kommersant.ru", "iz.ru", "rt.com", "gazeta.ru", "lenta.ru", "fontanka.ru",
          "sbis.ru", "kontur.ru", "diadoc.ru", "mos-reg.ru", "goskey.ru", "epgu.ru", "pfdo.ru",
          "gosbar.ru", "gostech.ru", "gosteh.ru",
          "sbermarket.ru", "sbermegamarket.ru", "samokat.ru", "kuper.ru",
          "cdek.ru", "boxberry.ru", "pochta.ru"
        ],
        "outboundTag": "direct"
      },
      {"type": "field", "geoip": ["cloudflare"], "outboundTag": "proxy"},
      {
        "type": "field",
        "domain": [
          "claude.ai", "anthropic.com",
          "openai.com", "chatgpt.com", "api.openai.com", "auth.openai.com",
          "gemini.google.com", "aistudio.google.com", "deepmind.com",
          "grok.com", "x.ai", "mistral.ai", "perplexity.ai", "huggingface.co", "copilot.microsoft.com",
          "telegram.org", "t.me", "tg.dev",
          "cdn1.telegram.org", "cdn2.telegram.org", "cdn3.telegram.org", "cdn4.telegram.org",
          "cdn5.telegram.org", "dc1.cdn.telegram.org", "dc2.cdn.telegram.org",
          "instagram.com", "cdninstagram.com", "facebook.com", "fbcdn.net", "whatsapp.com", "whatsapp.net", "threads.net",
          "twitter.com", "x.com", "twimg.com", "t.co",
          "youtube.com", "youtu.be", "googlevideo.com", "ytimg.com", "yt3.ggpht.com",
          "gvt1.com", "gvt2.com", "ggpht.com",
          "reddit.com", "redd.it", "redditmedia.com", "redditstatic.com",
          "discord.com", "discordapp.com", "discordapp.net", "discord.gg", "discord.media",
          "tiktok.com", "tiktokcdn.com", "snapchat.com", "pinterest.com", "twitch.tv",
          "medium.com", "notion.so", "figma.com", "canva.com",
          "netflix.com", "nflxvideo.net", "spotify.com", "spotifycdn.com",
          "github.com", "githubusercontent.com", "githubassets.com", "npmjs.com",
          "signal.org", "protonmail.com", "proton.me",
          "wikimedia.org", "wikipedia.org", "archive.org", "web.archive.org",
          "apple.com", "itunes.apple.com", "apps.apple.com", "mzstatic.com", "icloud.com", "apple-cloudkit.com",
          "paypal.com", "stripe.com",
          "google.com", "googleapis.com", "googleusercontent.com", "google-analytics.com"
        ],
        "outboundTag": "proxy"
      }
    ],
    "domainMatcher": "hybrid", "domainStrategy": "IPIfNonMatch"
  },
  "inbounds": [
    {"tag": "socks", "port": 10808, "listen": "127.0.0.1", "protocol": "socks", "settings": {"udp": true, "auth": "noauth"}, "sniffing": {"enabled": true, "routeOnly": false, "destOverride": ["http", "tls", "quic"]}},
    {"tag": "http", "port": 10809, "listen": "127.0.0.1", "protocol": "http", "settings": {"allowTransparent": false}, "sniffing": {"enabled": true, "routeOnly": false, "destOverride": ["http", "tls", "quic"]}}
  ],
  "outbounds": [{"tag": "direct", "protocol": "freedom"}, {"tag": "block", "protocol": "blackhole"}]
}
```

## 3–6. MIHOMO / STASH / CLASH / SINGBOX — "Default"
Positions 2–5 — стандартные шаблоны без изменений.

---

# Subscription Settings
- **Profile Title**: `Mesh 🗽 CloudWEB`
- **Support Link**: `https://t.me/ProxyMeshCloudbot`
- **Update Interval**: 6 часов
- **Response Rules**: Browser → BROWSER, Mihomo → MIHOMO, Stash → STASH, Sing-box → SINGBOX, Clash → CLASH, Fallback → XRAY_BASE64

---

# Xray параметры — что на что влияет

| Параметр | Влияние |
|---|---|
| `target / serverNames` | Сайт-маскировка REALITY. Клиент и сервер должны совпадать (SNI). ТСПУ видит TLS до этого домена. |
| `mode: auto` | XHTTP сам выбирает submode (обычно stream-up). Безопаснее, работает из коробки. |
| `mode: packet-up` | Каждый чанк данных — отдельный HTTP POST. Обходит ТСПУ-throttle 15–20KB/соед, но клиент тоже должен поддерживать packet-up. |
| `scMaxEachPostBytes` | Максимум байт в одном POST (packet-up). Слишком мало → разрыв соединения. Слишком много → задержка перед отправкой. `"1000000"` = 1MB, работает стабильно. |
| `xPaddingBytes` | Случайный мусор в заголовках для обфускации размера пакетов. |
| `scMaxBufferedPosts` | Сколько POST можно буферизовать на сервере одновременно. |
| `shortIds` | Список допустимых идентификаторов клиентов в ClientHello. Несовпадение → forwarded to camouflage. |
| `privateKey / pbk` | X25519 ключевая пара REALITY. privateKey на сервере, pbk в подписке. |

---

# TODO

- [ ] **US нода**: заменить 23.26.0.77 на новый IP (текущий блокируется ТСПУ из RU). При замене: добавить ноду в панель, назначить тот же config profile, обновить Host `US NYC 01`.
- [ ] **Selfsteal**: поднять Caddy на нодах, REALITY target = `127.0.0.1:443` + свой домен → защита от активного зондирования.
- [ ] **Fallback порт**: добавить второй inbound на `8443` — резерв при блокировке 443.
- [ ] **geosite:ru-blocked**: подключить [runetfreedom/russia-blocked-geosite](https://github.com/runetfreedom/russia-blocked-geosite) — 700K+ доменов, обновляется каждые 6 часов.
