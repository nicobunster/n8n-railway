# Dockerfile para n8n en Render
FROM n8nio/n8n:1.116.2

# Desactiva telemetría/plantillas (opcional)
ENV N8N_DIAGNOSTICS_ENABLED=false \
    N8N_TEMPLATES_ENABLED=false \
    # Render pasa X-Forwarded-For; hay que confiar en el proxy
    N8N_TRUSTED_PROXIES=loopback,linklocal,uniquelocal \
    # Permitir librerías externas en Function/Code node
    NODE_FUNCTION_ALLOW_EXTERNAL=axios,cheerio,moment

# Prepara el directorio de datos de n8n y instala libs externas ahí
USER root
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n
USER node
RUN npm --prefix /home/node/.n8n init -y \
 && npm --prefix /home/node/.n8n install --omit=dev axios@^1 cheerio@^1 moment@^2

# Importante para Render: n8n debe escuchar el puerto que Render inyecta
# (si no existe PORT, usa 5678 para local)
CMD sh -lc 'export N8N_PORT="${PORT:-5678}"; n8n start'
