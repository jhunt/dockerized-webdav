filefrog/webdav Docker Image
==========================

This Docker image runs a WebDAV server, powered by nginx, to
enable "glue" for mass file management needs in larger Kubernetes
deployments and service architectures.

To run it:

    docker run --rm -it filefrog/webdav [options]

The baked-in nginx configuration will include `/conf/*.conf` at
the default `server` level, allowing you some modicum of control
over the behavior of nginx / WebDAV; I use this to inject
HTTP Basic Authentication requirements to protect WebDAV hosts.
