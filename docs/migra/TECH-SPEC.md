# Technical Specification — Database Backend Migration (Supabase → Local PostgreSQL 18)

**Project:** mesh-cloudweb
**Host:** Mac-mini-CloudWEB.local (macOS 26.5)
**Repo root:** `/Users/iHome/Developer/mesh-cloudweb/`
**Author/Operator:** Boss · **Architect/Executor:** Claude
**Status:** In progress (panel side done, bot side + data migration pending)

---

## 1. Context & systems

The stack runs entirely on a single Mac mini under Docker, deployed via Portainer. Public traffic enters through Cloudflare → `cloudflared-tunnel` → `caddy-proxy` → local containers.

| Component | Image | Role | Stack (compose) |
|---|---|---|---|
| `mesh-cp` | `iluckyguy/mesh-cp:latest` | Panel — Remnawave backend `@remnawave/backend` 2.7.4 (NestJS + Prisma 6.19) | `backend/` (`mesh-backend`) |
| `mesh-page` | `iluckyguy/mesh-page:latest` | Subscription page | `backend/` |
| `redis-cp` | `redis:8-alpine` | Panel Redis | `backend/` |
| `mesh-bot` | `ghcr.io/iluckyguy/mesh-bot:latest` | Telegram bot — `remnawave-bedolaga-telegram-bot` 3.58.0 (Python, SQLAlchemy + asyncpg) | `frontend/` (`mesh-frontend`) |
| `mesh-app` | `iluckyguy/mesh-app:latest` | App service | `frontend/` |
| `redis-bot` | `redis:8-alpine` | Bot Redis | `frontend/` |

Shared external Docker network: `mesh-net`. Both apps previously stored data in **one Supabase project** (`vgwwidekswqeffltqhag`, eu-central-1, PG 17.6) in two named schemas: `mesh_cp` and `mesh_bot`.

---

## 2. Problem statement & root-cause journey

This documents the full diagnostic path (the iterations matter — they explain the final decision).

1. **Symptom:** panel `https://mesh-cp.cloudweb.name/...` returned **502**. `mesh-cp` was `unhealthy`.
2. **Cause #1:** entrypoint `prisma migrate deploy` failed with **`P1017: Server has closed the connection`**, looping the container. The `DATABASE_URL` pointed at the Supabase **transaction pooler** (port `6543`, `pgbouncer=true`); the migration engine's session-level advisory lock cannot survive transaction-mode pooling. Remnawave's `prisma/schema.prisma` has **no `directUrl`**, so migrate could not be split off to a direct connection.
3. **Fix attempt:** repointed `DATABASE_URL` to the Supabase **session pooler** (port `5432`). Migrations succeeded, panel went `healthy`.
4. **Cause #2 (regression):** the session pooler is hard-capped at **`pool_size: 15`**, and that pool is **shared between the 5432/6543 ports and between both apps**. Remnawave (Prisma pool + BullMQ workers) exhausted it → **`FATAL: (EMAXCONNSESSION) max clients reached in session mode`**. Downstream: `/api/system/stats` returned **HTTP 500 / errorCode `A048`** (the error the bot reported as "no connection"), health check `database: down`, traffic workers failing. The **bot's database access was never broken** — its CRUD worked throughout; it was light enough not to exhaust the pool alone.

**Documentation evidence (Supabase):** pool size is shared across session/transaction ports; session mode opens one backend per client up to the pool size; transaction mode multiplexes many clients over few connections and is recommended for application traffic.

**Conclusion:** Remnawave is connection-hungry and designed for a **dedicated PostgreSQL** (its stock compose ships a `postgres:17` container). Bolting it onto Supabase's pooler is fighting the platform. Decision: stop using Supabase for these two apps and self-host PostgreSQL.

---

## 3. Decision & rationale

**Decision:** Run **one local PostgreSQL 18.3 container** hosting **two databases** (`mesh_cp`, `mesh_bot`), with the **single default `postgres` superuser** (password identical to the current Supabase `postgres` password), on the shared `mesh-net`, internal standard port `5432`.

Topology chosen: **one server / two databases** (not one PG per stack).

| Option | Verdict |
|---|---|
| One shared PG, two databases | **Chosen.** Mirrors current Supabase topology (1 instance, 2 schemas), lighter on a single host, one thing to back up/tune/monitor, generous `max_connections` removes the pooler cap, single startup-order rule (DB first). |
| One PG per stack (upstream default) | Rejected. 2× RAM/WAL/autovacuum/backups on one host; "isolation" is illusory when both share the same physical host. |

PostgreSQL **18.3** selected per operator decision (already validated locally). Note vendor default is `postgres:17`; 18.3 is acceptable but carries the PG18 data-directory change (see §4).

---

## 4. Target architecture

### Service (`backend/docker-compose.yml`, stack `mesh-backend`)
```yaml
mesh-postgres:
  image: postgres:18.3
  container_name: mesh-postgres
  hostname: mesh-postgres
  restart: unless-stopped
  environment:
    POSTGRES_PASSWORD: ${PG_PASSWORD}     # == previous Supabase postgres password
    TZ: UTC
  volumes:
    - mesh_pg_data:/var/lib/postgresql     # PG18: mount the PARENT, not /data
    - ./init:/docker-entrypoint-initdb.d:ro
  networks: [mesh-net]
  healthcheck:
    test: ["CMD-SHELL", "pg_isready -U postgres"]
    interval: 5s
    timeout: 5s
    retries: 10
    start_period: 20s
```

### PostgreSQL 18 volume note (critical)
PG18 changed `PGDATA` to a version-specific path (`/var/lib/postgresql/18/docker`) and moved the declared `VOLUME` to `/var/lib/postgresql`. The historical mount `/var/lib/postgresql/data` is now a symlink and **breaks container start**. Therefore the volume is mounted at **`/var/lib/postgresql`** and `PGDATA` is left at the image default.

### Database init (`backend/init/10-databases.sql`)
```sql
CREATE DATABASE mesh_cp;
CREATE DATABASE mesh_bot;
```
Both owned by `postgres`. Data is restored into the named schemas `mesh_cp` / `mesh_bot` inside the respective databases (preserves current schema resolution).

### Connection strings (host = container name, not IP)
- Panel (`DATABASE_URL_CP`): `postgresql://postgres:<PG_PASSWORD>@mesh-postgres:5432/mesh_cp?schema=mesh_cp`
- Bot (`DATABASE_URL_BOT`): `postgresql+asyncpg://postgres:<PG_PASSWORD>@mesh-postgres:5432/mesh_bot`

### Networking
`mesh-postgres` joins `mesh-net`. The bot (`mesh-frontend` stack) reaches it cross-stack by hostname over `mesh-net`; Supabase не используется.

---

## 5. Operating constraints (hard rules)

- **Deployment is Boss-only via Portainer.** Claude never runs `docker compose up` / `docker run`. Claude's scope: diagnostics, file edits, **data copying** (dumps/restores via `docker exec`), cleanup.
- `sudo` over MCP is non-interactive → Boss runs such commands manually.
- **Never modify originals without a backup.** Corrected files saved alongside or backed up to `docs/backups/`.
- **Supabase is disabled, not deleted.** The `-sb` / `-self-sb` compose duplicates and commented `# SB-archive:` env lines are retained for future research.
- Files and code in English; chat in Russian.

---

## 6. Data migration specification

### Source inventory (Supabase `vgwwidekswqeffltqhag`)
| Schema | Tables | Approx rows |
|---|---|---|
| `mesh_cp` | 37 | ~1,146 |
| `mesh_bot` | 107 | ~1,574 |

No tables in `public` — both apps use their named schemas.

### Method (executed via `MCP_DOCKER` / `docker exec mesh-postgres`, since the Mac has no native `pg_dump`)
1. `pg_dump` each schema from the Supabase **session pooler (5432)** using the PG18 client (forward-compatible with source 17.6), custom format.
2. Store full dumps in `/Users/iHome/Developer/mesh-cloudweb/docs/backups/`.
3. Restore into the local databases (`--clean --if-exists` to overwrite any empty tables Prisma may have auto-created on first boot).

---

## 7. Acceptance criteria

- `mesh-cp`, `mesh-page`, `redis-cp`, `mesh-bot`, `mesh-app`, `redis-bot`, `mesh-postgres` all `healthy`.
- Panel `/health` = 200; `GET /api/system/stats` = 200 (no `A048`); no `EMAXCONNSESSION` / `P1017` in `mesh-cp` logs.
- Bot performs DB CRUD against local `mesh_bot`; no DB errors; admin infra alerts clean.
- Table counts in local DBs match source (`mesh_cp` 37, `mesh_bot` 107).
- No application container connects to `*.pooler.supabase.com` at runtime.
- Supabase configuration preserved (archive duplicates intact).

## 8. Risks & rollback

| Risk | Mitigation |
|---|---|
| PG18 volume mis-mount → data loss | Mount at `/var/lib/postgresql`; verified before first deploy. |
| Panel boots on empty DB before restore | Restore with `--clean --if-exists`, then restart `mesh-cp`. |
| Password mismatch (single `postgres` user) | All URLs use the one `PG_PASSWORD`. |
| `macos-control` MCP instability | Recurring; tracked as a separate follow-up (see §9). |

**Rollback:** redeploy the `-sb` compose variants and restore the `# SB-archive:` env lines; pre-change backup at `docs/backups/claude-pre-pg18-20260603_033757.tar.gz`.

## 9. Out of scope / deferred

- Supabase advisor remediation ("Вариант В", 2 security warnings on one function) — paused; needs the original options text from the source chat.
- `macos-control` MCP stability investigation — server hangs/disconnects intermittently; investigate after this task.
- mesh-page / mesh-app DB needs — confirmed panel/bot only; no change required unless they prove to need the DB.
