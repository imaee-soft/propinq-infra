## PROPINQ-114: Alinear infra de producción con DigitalOcean

Sincroniza `docker-compose.prod.yaml` y configuración Nginx SSL con el stack desplegado en `propinq.online`, para que un `git pull` + `docker compose up` reproduzca producción sin parches locales.

### Arquitectura

- Nginx termina TLS y enruta `/api/` al backend Spring Boot y el resto al contenedor Angular.
- Certbot queda bajo `profiles: ["tools"]` para no levantarse en cada `docker compose up`.
- Build del frontend usa contexto padre (`..`) porque `Dockerfile.prod` copia `propinq-frontend/`.

### Cambios en docker-compose

- API expone `127.0.0.1:8080` para diagnóstico local en el servidor.
- Frontend: `context: ..`, `dockerfile: propinq-frontend/Dockerfile.prod`.
- Nginx monta `nginx.conf` (límites de conexión) y `prod.ssl.conf` (HTTPS + proxy).
- Red `app-network` con subnet fija `172.20.0.0/16`.

### Nginx

- `prod.ssl.conf`: redirect HTTP→HTTPS, ACME challenge, proxy `/api/` → `api:8080`, SPA en `/`.
- `nginx.conf`: `worker_connections 8192`, `worker_rlimit_nofile 65535`.

### Errores solucionados

- Deploy manual con archivos untracked en el servidor (`prod.ssl.conf`, `nginx.conf`).
- Build de frontend fallaba con contexto incorrecto en compose.
- Certbot arrancaba innecesariamente en cada deploy.

### Validación

- Producción activa en `www.propinq.online` con esta configuración.
- Endpoints `/api/v1/parameters/max-price`, `/properties`, `/neighborhoods` → HTTP 200.
