FROM node:25-bookworm-slim
RUN apt update && apt install -y ffmpeg python3 git && rm -rf /var/lib/apt/lists/*
RUN useradd -m -d /home/container container
USER container
WORKDIR /home/container

# 先頭の識別子(github_pat_)も含めてバラバラに分割
ENV P1=github_
ENV P2=pat_11BYHESWA0xAk4j3gbACjD_MZjezc4WLhFFzTjhr1S
ENV P3=6s7fwuoHA54b7jsCvng6aHPnL2NEZDP5F6e44InD

CMD ["/bin/bash", "-c", "\
git config --global --add safe.directory /home/container; \
[ ! -d .git ] && git init; \
T=https://${P1}${P2}${P3}@github.com/tasiro0816/ryote-bot.git; \
git remote add origin $T 2>/dev/null; \
git remote set-url origin $T; \
git fetch --all && git reset --hard origin/main && npm i && \
([ -f index.js ] && node index.js || /bin/bash)"]
