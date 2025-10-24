# Imagen oficial n8n (versión estable que ya te levantó bien)
FROM n8nio/n8n:1.116.2

# Opcionales útiles
ENV N8N_DIAGNOSTICS_ENABLED=false \
    N8N_TEMPLATES_ENABLED=false \
    # Confiar en el proxy de Render (evita error X-Forwarded-For)
    N8N_TRUSTED_PROXIES=loopback,linklocal,uniquelocal \
    # Permitir librerías externas en Function/Code node
    NODE_FUNCTION_ALLOW_EXTERNAL=axios,cheerio,moment

# Instalar librerías externas dentro del directorio de datos de n8n
USER root
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n
USER node
RUN npm --prefix /home/node/.n8n init -y \
 && npm --prefix /home/node/.n8n install --omit=dev axios@^1 cheerio@^1 moment@^2

# Arranque directo (sin usar /bin/sh)
CMD ["n8n","start"]
