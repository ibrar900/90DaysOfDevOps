FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y --fix-missing -o Acquire::Retries=3 curl \
    && rm -rf /var/lib/apt/lists/*

CMD ["echo", "Hello from my custom image!"]
