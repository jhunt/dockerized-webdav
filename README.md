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

Custom nginx Configuration
--------------------------

Chances are that you are going to want something above and beyond
the baked-in configuration, and that's okay.  I initially toyed
with the idea of using `include ...` statements at various levels,
but apparently nginx gets angry when certain directives (like
`user`) are found more than once in a configuration.

So instead, I made it trivial to extract the default `nginx.conf`
from whatever version of this image you are going to use:

    docker run --rm filefrog/webdav:latest defaults

This will dump the nginx.conf to standard output, for you to
redirect to a file, edit to your heart's content, and then mount
back in (via a Kubernetes ConfigMap, or a Docker bind mount, or
whatever!)
