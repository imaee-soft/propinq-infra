# Propinq — guía rápida (local y CT102)

Vistazo para demo / presentación. Stack levantado desde **`propinq-infra`**.

## Repos y ramas

| Repo | Rama despliegue | Ruta local |
|------|-----------------|------------|
| `propinq-api` | `PROPINQ-108-Despliegue` | `propinq/propinq-api` |
| `propinq-frontend` | `PROPINQ-108-Despliegue` | `propinq/propinq-frontend` |
| `propinq-infra` | `homeserver/metabase-subdomain-deploy` | `propinq/propinq-infra` |

## Variables de front (build time)

Config en `propinq-frontend/src/environments/` — **no** hay `.env.frontend` en infra.

| Variable | `environment.development.ts` (`ng serve`) | `environment.production.ts` (Docker) |
|----------|-------------------------------------------|----------------------------------------|
| `mapPoisEnabled` | `false` | `false` |
| `reCAPTCHA_enabled` | `false` | `true` |
| `reCAPTCHA_SiteKey` | clave dev | clave prod (`propinq.online`) |
| `apiUrl` | `http://localhost:8080/api/v1` | `/api/v1` (nginx hace proxy) |

Cambiar flags en Docker → editar `environment.production.ts` y **rebuild** del contenedor `frontend`.

---

## Forma 1 — Docker Compose en infra (recomendada para la demo)

Réplica del stack con nginx en **http://localhost**.

### Pre-requisitos

En `propinq/propinq-infra/` deben existir (copiar de `.example` si aplica):

- `.env.api` — seed demo, CORS `http://localhost`, POI scheduler off
- `.env.mysql`
- `.env.mongodb`
- `.env.nginx`

### Arranque

```powershell
cd propinq\propinq-infra
docker compose -f docker-compose.home.yaml up --build
```

Primera vez o DB limpia (aplica SQL seed):

```powershell
docker compose -f docker-compose.home.yaml down -v
docker compose -f docker-compose.home.yaml up --build
```

La API tarda ~45–60 s en estar lista tras el seed.

### URLs

| Servicio | URL |
|----------|-----|
| App (nginx → front + API) | http://localhost |
| API directa (debug) | http://localhost:18080/api/v1 |
| Swagger | http://localhost:18080/docs |

### Parar

```powershell
docker compose -f docker-compose.home.yaml down
```

### Usuarios demo (seed `01_users.sql`)

Contraseña para todos: **`admin123`**

| Email | Rol |
|-------|-----|
| `admin@propinq.com` | ADMIN |
| `propietario@propinq.com` | OWNER |
| `inquilino@propinq.com` | TENANT |

---

## Forma 2 — `ng serve` (solo frontend en caliente)

Backend aparte (Maven o API en Docker).

### Terminal 1 — API

Opción A — Maven:

```powershell
cd propinq\propinq-api
mvn spring-boot:run
```

Opción B — solo API en Docker (desde infra, con MySQL/Mongo ya arriba):

```powershell
cd propinq\propinq-infra
docker compose -f docker-compose.home.yaml up mysql-db mongodb api
```

### Terminal 2 — Front

```powershell
cd propinq\propinq-frontend
npm ci
ng serve
```

App: **http://localhost:4200**

Usa `environment.development.ts` (`reCAPTCHA_enabled: false`, `mapPoisEnabled: false`).

CORS en `.env.api` local debe incluir `http://localhost:4200` si la API corre en Docker.

---

## CT102 (producción — `servidor-propinq`)

Rutas en el servidor:

```
/srv/apps/propinq/propinq-api
/srv/apps/propinq/propinq-frontend
/srv/apps/propinq/infra
```

### Deploy front + compose

```bash
ssh servidor-propinq

cd /srv/apps/propinq/propinq-frontend
git fetch origin
git checkout PROPINQ-108-Despliegue
git pull origin PROPINQ-108-Despliegue

cd /srv/apps/propinq/infra
# docker-compose.prod.yaml actualizado (sin .env.frontend)
docker compose -f docker-compose.prod.yaml up -d --build frontend
```

App pública: **https://www.propinq.online**

### Env en CT102 (solo infra, backend)

En `/srv/apps/propinq/infra/`:

- `.env.api` — `GOOGLE_RECAPTCHA_SECRET`, JWT, DB, `POI_SCHEDULER_ENABLED=false`, etc.
- `.env.mysql`, `.env.mongodb`, `.env.nginx`, `.env.tunnel`, `.env.metabase`

**No** se usa `.env.frontend` (eliminado; config en `environment.production.ts`).

---

## reCAPTCHA — ¿funciona?

| Capa | Local Docker | `ng serve` | CT102 |
|------|--------------|------------|-------|
| Front `reCAPTCHA_enabled` | `true` (build production) | `false` | `true` |
| Front carga widget / token | **No** — ningún componente lo usa aún | **No** | **No** |
| API valida token | **No** — validación comentada en `AuthService` | **No** | **No** |
| `GOOGLE_RECAPTCHA_SECRET` en API | Sí (`.env.api`) | Sí si API con Docker | Sí |

**Conclusión:** la configuración (claves site/secret) está puesta, pero **reCAPTCHA no está activo en la UI ni obligatorio en el login**. Login y registro funcionan sin captcha. Para activarlo falta cablear el front (script + token en forms) y descomentar validación en la API.

---

## POIs en el mapa

`mapPoisEnabled: false` en todos los entornos → el home **no** llama a `/api/v1/pois/within`.

En CT102 la tabla `poi` está vacía y el import OSM (`POI_SCHEDULER_*` en `.env.api`) está apagado.

---

## Comandos útiles

```powershell
# Logs API (local Docker)
docker logs -f propinq-api-prod

# Logs front
docker logs -f propinq-frontend-prod

# Estado
docker compose -f docker-compose.home.yaml ps
```

```bash
# CT102
ssh servidor-propinq 'docker ps --filter name=propinq --format "table {{.Names}}\t{{.Status}}"'
```

---

## Alternativa local (sin nginx de home)

`docker-compose.local.yaml` — front en **:8088**, API en **:8080**. Ver `docs/LOCAL.md`.
