FROM node:25-bookworm-slim
RUN apt update && apt install -y ffmpeg python3 git ssh && rm -rf /var/lib/apt/lists/*
RUN useradd -m -d /home/container container

# 鍵の配置と権限設定
USER container
WORKDIR /home/container
RUN mkdir -p /home/container/.ssh && chmod 700 /home/container/.ssh

# 事前に作成した秘密鍵をコピー（ファイル名は実際の鍵に合わせてください）
COPY --chown=container:container id_rsa /home/container/.ssh/id_ed25519
RUN chmod 600 /home/container/.ssh/id_ed25519

# 初回接続時の「Yes/No」確認をスキップする設定
RUN ssh-keyscan -t ed25519 github.com >> /home/container/.ssh/known_hosts

CMD ["/bin/bash", "-c", "\
    git config --global --add safe.directory /home/container; \
    [ ! -d .git ] && git init; \
    git remote add origin git@github.com:tasiro0816/ryote-bot.git 2>/dev/null; \
    git remote set-url origin git@github.com:tasiro0816/ryote-bot.git; \
    git fetch --all && git reset --hard origin/main && npm i && \
    ([ -f index.js ] && node index.js || /bin/bash)"]
