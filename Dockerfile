FROM n8nio/n8n:1.116.2

# Opcionales útiles
ENV N8N_DIAGNOSTICS_ENABLED=false \
    N8N_TEMPLATES_ENABLED=false \
    N8N_TRUSTED_PROXIES=loopback,linklocal,uniquelocal \
    NODE_FUNCTION_ALLOW_EXTERNAL=axios,cheerio,moment \
    N8N_PORT=5678

# Prepara carpeta de datos e instala libs para Function/Code node
USER root
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n
USER node
RUN npm --prefix /home/node/.n8n init -y \
 && npm --prefix /home/node/.n8n install --omit=dev axios@^1 cheerio@^1 moment@^2

# Importante: NO sobrescribas el CMD/ENTRYPOINT.
# La imagen oficial ya arranca n8n correctamente.
