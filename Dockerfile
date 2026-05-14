FROM node:25-bookworm-slim
RUN apt update && apt install -y git ssh && rm -rf /var/lib/apt/lists/*
RUN useradd -m -d /home/container container
USER container
WORKDIR /home/container

# 秘密鍵をコピーして権限設定（これで認証が自動化される）
COPY --chown=container:container id_ed25519 /home/container/.ssh/id_rsa
RUN chmod 600 /home/container/.ssh/id_rsa && ssh-keyscan github.com >> /home/container/.ssh/known_hosts

CMD ["/bin/bash", "-c", "git config --global --add safe.directory /home/container; [ ! -d .git ] && git init; git remote add origin git@github.com:tasiro0816/ryote-bot.git 2>/dev/null; git fetch --all && git reset --hard origin/main && npm i && node index.js || /bin/bash"]
