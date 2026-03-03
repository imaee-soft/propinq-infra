# Certificados SSL (Certbot) y renovación automática

## Comprobar si ya tienes certificados

```bash
cd /srv/apps/propinq/infra

# Ver si existen certificados
ls -la certbot/conf/live/
```

- Si ves una carpeta con tu dominio (ej. `www.propinq.online`), **ya obtuviste el certificado**.
- Si `certbot/conf/` está vacío o no existe `live/`, **aún no** has ejecutado Certbot.

## Pasos para obtener el certificado (solo la primera vez)

1. **Dominio**: El DNS de tu dominio (ej. `www.propinq.online`) debe apuntar a la IP del EC2.

2. **Puerto 80 abierto**: En AWS Security Group del EC2, Inbound: HTTP (80) desde `0.0.0.0/0`.

3. **Nginx solo HTTP (temporal)**  
   Sustituye el contenido de `nginx/prod.conf` por un solo bloque que escuche en 80 y sirva `/.well-known/acme-challenge/`:
   ```nginx
   server {
       listen 80;
       server_name www.propinq.online propinq.online;
       location /.well-known/acme-challenge/ { root /var/www/certbot; }
       location / { return 301 https://$host$request_uri; }
   }
   ```
   (Sin bloque `server { listen 443 ... }` hasta tener los .pem.)

4. **Levantar servicios**:
   ```bash
   cd /srv/apps/propinq/infra
   docker compose -f docker-compose.prod.yaml up -d nginx
   ```

5. **Pedir certificado**:
   ```bash
   docker compose -f docker-compose.prod.yaml run --rm certbot certonly \
     --webroot --webroot-path /var/www/certbot/ \
     -d www.propinq.online
   ```
   Cuando diga **"Successfully received certificate"**, sigue al paso 6.

6. **Poner la config HTTPS completa** en `nginx/prod.conf` (bloque 443 con `ssl_certificate` y `ssl_certificate_key` apuntando a `certbot/conf/live/www.propinq.online/`).

7. **Reiniciar nginx**:
   ```bash
   docker compose -f docker-compose.prod.yaml restart nginx
   ```

8. **Abrir puerto 443** en el Security Group (HTTPS, 443, `0.0.0.0/0`).

## Renovación automática (cron)

El script `renew_certs.sh` ya está en esta carpeta. **El cron no se instala automáticamente**; tú lo añades:

```bash
crontab -e
```

Añade esta línea (ajusta la ruta si tu `infra` está en otro sitio):

```
0 3 * * * /srv/apps/propinq/infra/renew_certs.sh
```

Así se ejecutará todos los días a las 03:00.

### Comprobar que el cron está instalado

```bash
crontab -l
```

Debe aparecer la línea de `renew_certs.sh`.

### Probar el script de renovación a mano

```bash
cd /srv/apps/propinq/infra
./renew_certs.sh
```

Si los certificados no tocan a renovación, Certbot dirá que no hace falta; si tocan, renovará y nginx recargará.
