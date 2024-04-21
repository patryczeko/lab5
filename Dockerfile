FROM alpine:latest as builder

COPY alpine-minirootfs-3.17.3-aarch64.tar /
RUN mkdir -p /rootfs && tar -xf /alpine-minirootfs-3.17.3-aarch64.tar -C /rootfs


FROM scratch as base
COPY --from=builder /rootfs /
WORKDIR /app
COPY server.js .
COPY package.json .
ARG VERSION
ENV VERSION=${VERSION}

RUN apk add --no-cache nodejs npm

CMD [ "node", "server.js"]

FROM nginx:latest as server

COPY --from=base /app /usr/share/nginx/html
COPY default.conf /etc/nginx/nginx.conf
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:80/healthcheck || exit 1

EXPOSE 80


