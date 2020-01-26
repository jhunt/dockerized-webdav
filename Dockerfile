# as of 3.11, mod-dav-ext is only in :edge...
FROM alpine:edge

ARG BUILD_DATE
ARG VCS_REF
LABEL maintainer="James Hunt <images@huntprod.com>" \
      summary="nginx-backed WebDAV server" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/jhunt/dockerized-webdav.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0"

RUN apk add nginx nginx-mod-http-dav-ext \
 && rm -rf /var/cache/apk/* \
 && mkdir -p /davroot

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY nginx.conf    /etc/nginx/nginx.conf
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
