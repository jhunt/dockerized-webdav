FROM nginx:mainline

ARG BUILD_DATE
ARG VCS_REF
LABEL maintainer="James Hunt <images@huntprod.com>" \
      summary="nginx-backed WebDAV server" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/jhunt/dockerized-webdav.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0"

RUN mkdir -p /davroot
COPY nginx.conf /etc/nginx/nginx.conf
ENTRYPOINT ["nginx", "-g", "daemon off;"]
