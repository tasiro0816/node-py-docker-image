FROM node:25-bookworm-slim
RUN apt update && apt install -y ffmpeg python3 git ssh && rm -rf /var/lib/apt/lists/*
RUN useradd -m -d /home/container container

USER container
WORKDIR /home/container
RUN mkdir -p /home/container/.ssh && chmod 700 /home/container/.ssh

# 送信されたファイル名「id_ed25519」をコピーし、コンテナ内では標準的な「id_rsa」として扱う
COPY --chown=container:container id_ed25519 /home/container/.ssh/id_rsa
RUN chmod 600 /home/container/.ssh/id_rsa

# GitHubを信頼できるホストとして登録
RUN ssh-keyscan -t ed25519 github.com >> /home/container/.ssh/known_hosts

CMD ["/bin/bash", "-c", "\
    git config --global --add safe.directory /home/container; \
    [ ! -d .git ] && git init; \
    git remote add origin git@github.com:tasiro0816/ryote-bot.git 2>/dev/null; \
    git remote set-url origin git@github.com:tasiro0816/ryote-bot.git; \
    git fetch --all && git reset --hard origin/main && npm i && \
    ([ -f index.js ] && node index.js || /bin/bash)"]
