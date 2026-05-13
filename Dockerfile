FROM node:20-bookworm-slim

RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/container

COPY package.json ./
RUN npm install
COPY . .

CMD ["/bin/bash", "-c", "node ${STARTUP_FILE:-index.js} || /bin/bash"]
