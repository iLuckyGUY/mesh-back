# Action Plan — Supabase → Local PostgreSQL 18 Migration

> **⚠️ Исторический документ.** Миграция завершена, Supabase не используется. Все данные в локальном PostgreSQL. Owner tags: **[C]** = Claude (diagnostics/edits/data), **[B]** = Boss (Portainer deploys, MCP/host control).

---

## Status snapshot (as of 2026-06-03)

### ✅ Done — panel side (`backend/`)
- Backup created: `docs/backups/claude-pre-pg18-20260603_033757.tar.gz` (backend+frontend compose, cp.env, bot.env).
- `backend/docker-compose.yml`:
  - added service `mesh-postgres` (`postgres:18.3`, volume `mesh_pg_data:/var/lib/postgresql`, init mount, healthcheck);
  - added named volume `mesh_pg_data`;
  - `mesh-cp` now `depends_on: mesh-postgres (service_healthy)`;
  - removed `supabase-cloudweb_default` network (def + `mesh-cp` attachment).
- `backend/init/10-databases.sql` created → `CREATE DATABASE mesh_cp; CREATE DATABASE mesh_bot;`.
- `backend/cp.env`: `DATABASE_URL_CP` and bare `DATABASE_URL` repointed to `postgres@mesh-postgres:5432/mesh_cp?schema=mesh_cp`; `PG_PASSWORD` added; old Supabase values kept as `# SB-archive:` comments.

### ⛔ Blocked / pending
- **Blocker:** `macos-control` MCP disconnected/unstable → host file edits paused. `MCP_DOCKER` is available (container exec only). Supabase connector available (read).
- Bot side (`frontend/`) not yet edited.
- Data not yet migrated.
- Nothing deployed yet with the new config.

---

## Remaining steps (in order)

### Phase A — Restore tooling  **[B]**
1. Ensure `claude_desktop_config.json` has only `macos-control` + `MCP_DOCKER` active; fully quit & reopen Claude Desktop so `macos-control` reconnects.
2. Confirm to Claude → Claude probes with a lightweight command.

### Phase B — Bot-side edits  **[C]** (needs `macos-control`)
3. Read `frontend/docker-compose.yml` fully; confirm `mesh-bot` (and `mesh-app` if needed) attach to `mesh-net`.
4. Edit `frontend/docker-compose.yml`: ensure `mesh-bot`/`mesh-app` on `mesh-net`; remove `supabase-cloudweb_default`.
5. Edit `frontend/bot.env`: `DATABASE_URL_BOT` → `postgresql+asyncpg://postgres:<PG_PASSWORD>@mesh-postgres:5432/mesh_bot`; keep Supabase value as `# SB-archive:` comment.
6. Verify edits (masked) + back up before writing.

### Phase C — Bring up the database  **[B]**
7. In Portainer, deploy/redeploy stack **`mesh-backend`**. This starts `mesh-postgres` (init creates `mesh_cp` + `mesh_bot`). `mesh-cp` will boot and may auto-migrate an *empty* `mesh_cp` — expected; do not act on the empty panel.

### Phase D — Data migration  **[C]** (via `MCP_DOCKER` → `docker exec mesh-postgres`)
8. Create `/var/lib/postgresql/backups` inside the container (or use a mounted path) and produce full dumps from Supabase session pooler (5432):
   ```sh
   pg_dump -Fc --no-owner --schema=mesh_cp \
     "postgresql://postgres.vgwwidekswqeffltqhag:<PW>@aws-1-eu-central-1.pooler.supabase.com:5432/postgres" \
     -f /backups/mesh_cp_$(date +%Y%m%d_%H%M).dump
   pg_dump -Fc --no-owner --schema=mesh_bot \
     "postgresql://postgres.vgwwidekswqeffltqhag:<PW>@aws-1-eu-central-1.pooler.supabase.com:5432/postgres" \
     -f /backups/mesh_bot_$(date +%Y%m%d_%H%M).dump
   ```
9. Copy both dumps into host `docs/backups/`.
10. Restore into local DBs (overwriting any empty Prisma-created objects):
    ```sh
    pg_restore --no-owner --clean --if-exists -d mesh_cp  /backups/mesh_cp_*.dump
    pg_restore --no-owner --clean --if-exists -d mesh_bot /backups/mesh_bot_*.dump
    ```
11. Verify table counts: `mesh_cp` = 37, `mesh_bot` = 107.

### Phase E — Bring up apps  **[B]**
12. Restart `mesh-cp` (picks up restored data; migrate becomes a no-op).
13. Deploy/redeploy stack **`mesh-frontend`** (bot now points at local `mesh_bot`).

### Phase F — Verification  **[C] reads logs, [B] clicks**
14. `mesh-postgres`, `mesh-cp`, `mesh-page`, `redis-cp`, `mesh-bot`, `mesh-app`, `redis-bot` → all `healthy`.
15. Panel: `curl -s -o /dev/null -w '%{http_code}' http://localhost:3001/health` → 200; `GET /api/system/stats` → 200, no `A048`.
16. `mesh-cp` logs: no `EMAXCONNSESSION`, no `P1017`.
17. Bot logs: DB CRUD OK, admin infra alerts clean.
18. Confirm no runtime connections to `*.pooler.supabase.com`.

---

## Verification checklist (copy/paste targets)
- [ ] All 7 containers healthy
- [ ] Panel `/health` 200
- [ ] `/api/system/stats` 200 (no A048)
- [ ] No `EMAXCONNSESSION` / `P1017`
- [ ] Bot CRUD clean
- [ ] `mesh_cp` 37 tables / `mesh_bot` 107 tables restored
- [ ] Supabase detached at runtime; archive duplicates intact

## Rollback
1. Redeploy `-sb` compose variants in Portainer.
2. Restore `# SB-archive:` env lines (or extract from `docs/backups/claude-pre-pg18-20260603_033757.tar.gz`).
3. Keep `mesh_pg_data` volume for later retry.
