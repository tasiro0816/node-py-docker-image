FROM node:20-bookworm-slim

RUN apt-get update && apt-get install -y ffmpeg python3 git && rm -rf /var/lib/apt/lists/*

WORKDIR /home/container

RUN git init && \
    git remote add origin https://<ユーザー名>:<トークン>@github.com/tasiro0816/ryote-bot.git

COPY package.json ./
RUN npm install

CMD ["/bin/bash", "-c", "git fetch --all && git reset --hard origin/main && node ${STARTUP_FILE:-index.js} || /bin/bash"]
