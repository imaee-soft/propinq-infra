# Local (Docker Desktop) — sin nginx-propinq ni Cloudflare

Respaldo para exponer PropInq en la PC si cae el LXC `servidor-propinq`.

| URL | Qué es |
|-----|--------|
| http://localhost:8088 | App (frontend + `/api/v1` proxied al backend) |
| http://localhost:8080 | API directa |
| http://localhost:3030 | Metabase |

No se levanta el reverse proxy de producción ni el túnel. **No arranques** `cloudflared_propinq` en esta máquina mientras el homeserver esté arriba: el mismo token parte el dominio público.

## Arranque (después del primer restore)

```powershell
cd propinq\propinq-infra
docker compose -f docker-compose.local.yaml up -d
```

Parar:

```powershell
docker compose -f docker-compose.local.yaml down
```

## Primera vez / refrescar datos del homeserver

Desde esta carpeta, con LAN o Tailscale y `ssh servidor-propinq` funcionando:

```powershell
powershell -File scripts\pull-homeserver-backup.ps1
powershell -File scripts\restore-local.ps1
```

`restore-local.ps1` también levanta el stack.

## Imágenes

El compose usa `infra-api:latest` e `infra-frontend:latest` (las mismas que en el CT102). Si no están:

```powershell
# En el servidor (ya puede existir): docker save -o /tmp/propinq-images.tar infra-api:latest infra-frontend:latest metabase/metabase:latest
scp servidor-propinq:/tmp/propinq-images.tar .\local-data\
docker load -i .\local-data\propinq-images.tar
```

O construir localmente (más lento):

```powershell
docker compose -f docker-compose.local.yaml up -d --build
```
