FROM node:25-bookworm-slim
RUN apt update && apt install -y ffmpeg python3 git && rm -rf /var/lib/apt/lists/*
RUN useradd -m -d /home/container container
USER container
WORKDIR /home/container
CMD ["/bin/bash", "-c", "git config --global --add safe.directory /home/container; [ ! -d .git ] && git init; T=https://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@github.com/tasiro0816/ryote-bot.git; git remote add origin $T 2>/dev/null; git remote set-url origin $T; git fetch --all && git reset --hard origin/main && npm i && ([ -f index.js ] && node index.js || /bin/bash)"]
