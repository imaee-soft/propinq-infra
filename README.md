# Infra: despliegue de Propinq en producción

Infraestructura Docker para desplegar Propinq (Spring Boot + Angular) en un servidor con Nginx como reverse proxy y HTTPS con Let's Encrypt.

---

## Arquitectura

```mermaid
flowchart LR

%% ========================
%% CLIENTE
%% ========================
subgraph cliente_ext [Internet / Cliente]
    Client[Cliente]
    Browser[Web Browser]
    Client --> Browser
end

%% ========================
%% AWS EC2
%% ========================
subgraph ec2 [AWS EC2 - Servidor Web]

    %% Reverse proxy
    Nginx[nginx :80/443]
    Certbot[certbot]

    %% Frontend
    subgraph frontend [Presentación Web]
        Front[propinq-frontend :80]
    end

    %% Backend
    subgraph backend [Lógica de Negocio]
        API[propinq-api :8080]
    end

    %% Persistencia
    subgraph persistencia [Persistencia]
        MySQL[MySQL :3306]
        Mongo[MongoDB :27017]
    end

    %% Analytics
    Metabase[Metabase :3000]

end

%% ========================
%% SERVICIOS EXTERNOS
%% ========================
Cloudinary[Cloudinary]
Gmail[Gmail API]
OpenLayers[OpenLayers API]

%% ========================
%% RELACIONES
%% ========================

Browser --> Nginx

Nginx --> Front
Nginx --> API

API --> MySQL
API --> Mongo

Metabase --> MySQL

Nginx -.-> Certbot

%% Integraciones externas (CORREGIDAS)
API -.-> Gmail
API -.-> Cloudinary
API -.-> OpenLayers
```

---

## Ficheros principales

- `docker-compose.prod.yaml`: stack de producción (api, frontend, mysql, mongodb, metabase, nginx, certbot).
Referencias: 
    - [Angular](https://angular.dev/tools/cli/deployment#manual-deployment-to-a-remote-server)
    - [Springboot](https://docs.spring.io/spring-boot/how-to/deployment/cloud.html)
    - [Metabase](https://www.metabase.com/docs/latest/installation-and-operation/running-metabase-on-docker#example-docker-compose-yaml-file)
    - [MySql](https://dev.mysql.com/doc/mysql-secure-deployment-guide/8.0/en/)


- `docker-compose.ssl.yaml`: stack mínimo para obtener el primer certificado (nginx + certbot).
- `.env.api`, `.env.mysql`, `.env.mongodb`, `.env.nginx`: variables de entorno por servicio.
- `nginx/prod.conf`: configuración definitiva de Nginx (HTTP + HTTPS + proxy).
- `nginx/ssl-bootstrap.conf`: config mínima solo HTTP para el bootstrap de Certbot.
- `renew_certs.sh`: script para renovar certificados y recargar nginx.

---

## 1. Preparar entorno

### 1.1. Docker compose
Guía de instalación:
- https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

### 1.2. Maven

#### 1.2.1. Instalación de maven
```
apt update
apt install maven -y
```

#### 1.2.2. creación de .mvn
```
mvn wrapper:wrapper
```

## 2. Preparar variables de entorno

### 2.1 Variables obligatorias para correr el proyecto

Estas variables deben tener siempre un valor válido en producción, agrupadas por fichero `.env`:

- **`.env.api`** (backend / seguridad / mail / Cloudinary):
    - `SPRING_PROFILES_ACTIVE`
    - `SECURITY_JWT_KEY`
    - `SECURITY_JWT_USER`
    - `MAIL_HOST`, `MAIL_USERNAME`, `MAIL_PASSWORD`
    - `CLOUD_NAME`, `CLOUD_API_KEY`, `CLOUD_API_SECRET`

- **`.env.mysql`**:
  - `MYSQL_DATABASE`, `MYSQL_USERNAME`, `MYSQL_PASSWORD`, `MYSQL_ROOT_PASSWORD`

- **`.env.mongodb`**:
  - `MONGO_DATABASE`, `MONGO_USER`, `MONGO_PASSWORD`

### 2.2 Ficheros `.env` por servicio

En esta carpeta debes crear/ajustar los siguientes ficheros:

- **`.env.api`** → configuración del backend (Spring Boot). Ejemplo base:

  ```env
  SPRING_PROFILES_ACTIVE=docker

  # Mail
  MAIL_HOST=smtp.gmail.com
  MAIL_PORT=587
  MAIL_USERNAME=propinq.enterprise@gmail.com
  MAIL_PASSWORD=...
  MAIL_SMTP_AUTH=true
  MAIL_STARTTLS_ENABLE=true
  MAIL_TIMEOUT=2000

  # Logging
  LOG_WEB_LEVEL=INFO
  LOG_HIBERNATE_SQL_LEVEL=WARN
  LOG_HIBERNATE_BINDER_LEVEL=WARN

  # CORS / frontend
  CORS_ALLOWED_ORIGINS=https://www.propinq.online
  FRONTEND_URL=https://www.propinq.online

  # Cloudinary
  CLOUD_NAME=...
  CLOUD_API_KEY=...
  CLOUD_API_SECRET=...

  # Swagger / OpenAPI
  SWAGGER_DISABLE_DEFAULT_URL=true
  SWAGGER_PATH=/docs
  OPENAPI_PATH=/api-docs

  # JWT
  SECURITY_JWT_KEY=...
  SECURITY_JWT_USER=AUTH0_USER

  # POI
  POI_SCHEDULER_ENABLED=false
  POI_SCHEDULER_CRON=0 30 3 * * *
  OSM_DOWNLOAD_THROTTLE_DAYS=7
  POI_RUN_ON_STARTUP=false
  POI_RUN_DOWNLOAD=true
  POI_RUN_EXTRACTION=true
  POI_REGION=south-america/argentina-latest
  POI_SCRIPTS_DIR=/app/scripts
  POI_DATA_DIR=/app/data
  POI_PBF_PATH=/app/data/argentina-latest.osm.pbf
  POI_OUT_DIR=/app/out
  POI_IMPORT_FILE=/app/out/pois.geojsonseq

  # Metabase embebido (reports)
  METABASE_SECRET_KEYL=...
  METABASE_SITE_URL=http://localhost:3000
  ```

- **`.env.mysql`** → credenciales de MySQL:

  ```env
  MYSQL_PORT=3306
  MYSQL_DATABASE=propinq
  MYSQL_USERNAME=root
  MYSQL_PASSWORD=password
  MYSQL_ROOT_PASSWORD=password
  ```

- **`.env.mongodb`** → credenciales de MongoDB:

  ```env
  MONGO_HOST=mongodb
  MONGO_PORT=27017
  MONGO_AUTH_SOURCE=admin
  MONGO_USER=mongo-user
  MONGO_PASSWORD=secret
  MONGO_DATABASE=propinq
  ```

- **`.env.nginx`** → URL pública del frontend y orígenes CORS:

  ```env
  FRONTEND_URL=https://www.propinq.online
  CORS_ALLOWED_ORIGINS=https://www.propinq.online
  ```

Ajusta los valores a tu entorno

---



## Solo la primera vez desplegando el proyecto obtener el primer certificado SSL (Let's Encrypt)
Seguir los pasos en [@infra/README-SSL.md](README-SSL.md)

## 3. Nginx con HTTPS y stack de producción

2. Levanta el stack completo:

   ```bash
   cd /srv/apps/propinq/infra
   docker compose -f docker-compose.prod.yaml up -d --build
   ```

Comprobaciones rápidas:

- `https://www.propinq.online/health` → endpoint de health servido por Nginx.
- `https://www.propinq.online/` → frontend Angular.
- `https://www.propinq.online/api/v1/...` → endpoints REST de la API de Spring Boot

---

## 4. Renovación automática de certificados

Script `renew_certs.sh` :

Para que se ejecute automáticamente cada noche:

Abrir el editor de cron
```bash
crontab -e
```

Copair y pegar:

```cron
0 3 * * * /srv/apps/propinq/infra/renew_certs.sh
```

