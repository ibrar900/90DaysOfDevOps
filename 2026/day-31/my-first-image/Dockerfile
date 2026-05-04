FROM ubuntu:latest

RUN apt-get update \
    && for i in 1 2 3 4 5; do \
        apt-get install -y --fix-missing -o Acquire::Retries=3 curl && break; \
        apt-get -f install -y || true; \
        if [ "$i" -eq 5 ]; then exit 1; fi; \
      done \
    && rm -rf /var/lib/apt/lists/*

CMD ["echo", "Hello from my custom image!"]
