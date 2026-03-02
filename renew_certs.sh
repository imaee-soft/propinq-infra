#!/bin/bash
set -e

cd -- "$(dirname "$0")"

# Renew certificates using certbot container
docker compose -f docker-compose.prod.yaml run --rm certbot renew

# Reload nginx to pick up renewed certificates
docker compose -f docker-compose.prod.yaml exec nginx nginx -s reload
