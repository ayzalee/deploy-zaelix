FROM golang:1.23-bookworm

RUN apt-get update && apt-get install -y --no-install-recommends \
        ffmpeg imagemagick python3-pip curl unzip git ca-certificates \
    && pip install --break-system-packages --no-cache-dir -U yt-dlp \
    && curl -fsSL https://deno.land/install.sh | DENO_INSTALL=/usr/local sh \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/local/bin:${PATH}"

RUN git clone --depth 1 https://github.com/ayzalee/whatsapp-bot.git /app
WORKDIR /app

RUN go mod download && go build -ldflags "-s -w -X main.sourceDir=/app" -o zaelix .

CMD ["./zaelix"]
