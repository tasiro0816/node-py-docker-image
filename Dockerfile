FROM debian:bookworm-slim

RUN apt update && apt install -y \
    ca-certificates curl gnupg \
    ffmpeg tini \
    python3 python3-pip python3-venv \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt update && apt install -y nodejs \
    && apt clean && rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /home/container container
USER container
WORKDIR /home/container

COPY --chown=container:container . .

RUN npm ci --only=production

ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD ["node", "index.js"]
