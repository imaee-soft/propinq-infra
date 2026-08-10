# Homelab deploy notes (Cloudflare Tunnel)
#
# 1. Dominio propinq.online en Cloudflare (nameservers desde Namecheap).
# 2. Túnel propio `propinq-tunnel` (NO reutilizar nacho-tunnel).
# 3. Published routes → http://nginx-propinq-prod:80 (apex + www).
# 4. Copiar .env.tunnel.example → .env.tunnel y pegar TUNNEL_TOKEN.
# 5. API: si el profile docker no trae bloque `arquiler`, definir en .env.api:
#      ARQUILER_CALCULATION_URL=...
#      ARQUILER_API_KEY=...
#      ARQUILER_API_HOST=...
# 6. Arranque:
#      docker compose -f docker-compose.home.yaml up -d --build
#
# LAN: http://192.168.1.21/  |  Público: https://www.propinq.online
