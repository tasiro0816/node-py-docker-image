FROM node:20-bookworm-slim

RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/container

RUN git init && \
    git remote add origin https://tasiro0816:Github_pat_11BYHESWA0W6fVE8kHma5r_wKBG29BWHuuNQ3SKsV0vN6lFk6AruCdvw2Al8P4K0FjXYSMXLWLk77I9FUV@github.com/tasiro0816/ryote-bot.git

CMD ["/bin/bash", "-c", "git fetch --all && git reset --hard origin/main && npm install && node ${STARTUP_FILE:-index.js} || /bin/bash"]
