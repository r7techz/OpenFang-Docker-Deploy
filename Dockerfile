FROM marsel7/openfang:latest
USER root
ENV PORT=4200
ENV OPENFANG_LISTEN=0.0.0.0:4200

# Browser Hand dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    python3 \
    python3-pip \
    wget \
    gnupg \
    libglib2.0-0 \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libpangocairo-1.0-0 \
    libgtk-3-0 \
    fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN pip3 install --break-system-packages playwright \
    && python3 -m playwright install chromium

COPY skills/ /root/.openfang/skills/

# Config inject karo
COPY config.toml /root/.openfang/config.toml

WORKDIR /app
EXPOSE 4200
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["openfang start"
