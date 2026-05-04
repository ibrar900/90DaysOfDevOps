FROM ubuntu:latest

RUN sed -i 's|http://|https://|g' /etc/apt/sources.list.d/ubuntu.sources \
    && apt-get update \
    && apt-get install -y --fix-missing -o Acquire::Retries=3 curl \
    && rm -rf /var/lib/apt/lists/*

CMD ["echo", "Hello from my custom image!"]
