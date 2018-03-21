FROM node:8.10.0-alpine

EXPOSE 8080

RUN cd /tmp && npm install -g http-server \
    && apk add --no-cache git \
    && git clone https://github.com/migh/places.git \
    && cd places \
    && npm install \
    && npx gatsby build \
    && cp -r public /opt/site \
    && npm cache clean --force \
    && rm -r /tmp/* \
    && apk del git

WORKDIR /opt/site
ENTRYPOINT ["http-server"]
