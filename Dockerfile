FROM node:25-bookworm-slim
RUN apt update && apt install -y git ssh && rm -rf /var/lib/apt/lists/*
RUN useradd -m -d /home/container container

# ユーザー権限で実行
USER container
WORKDIR /home/container

# SSH設定フォルダを作成
RUN mkdir -p /home/container/.ssh && chmod 700 /home/container/.ssh

# GitHubのホストキーを事前に登録（画像5枚目のエラーを消す魔法）
RUN ssh-keyscan github.com >> /home/container/.ssh/known_hosts

# 鍵をコピー
COPY --chown=container:container id_ed25519 /home/container/.ssh/id_rsa
RUN chmod 600 /home/container/.ssh/id_rsa

CMD ["/bin/bash", "-c", "\
    git config --global --add safe.directory /home/container; \
    [ ! -d .git ] && git init; \
    git remote add origin git@github.com:tasiro0816/ryote-bot.git 2>/dev/null; \
    git remote set-url origin git@github.com:tasiro0816/ryote-bot.git; \
    git fetch --all && git reset --hard origin/main && npm i && \
    node index.js || /bin/bash"]
