FROM node:25-bookworm-slim
RUN apt update && apt install -y ffmpeg python3 git && rm -rf /var/lib/apt/lists/*
RUN useradd -m -d /home/container container
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

RUN git init && git remote add origin https://Github_pat_11BYHESWA0W6fVE8kHma5r_wKBG29BWHuuNQ3SKsV0vN6lFk6AruCdvw2Al8P4K0FjXYSMXLWLk77I9FUV@github.com/tasiro0816/ryote-bot.git

CMD ["/bin/bash", "-c", "git fetch --all && git reset --hard origin/main && npm i && [ -f index.js ] && node index.js || /bin/bash"]
