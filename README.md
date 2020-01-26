filefrog/webdav Docker Image
==========================

This Docker image runs a WebDAV server, powered by nginx, to
enable "glue" for mass file management needs in larger Kubernetes
deployments and service architectures.

To run it:

    docker run --rm -it filefrog/webdav [options]

In most cases, you will want to bind-mount in something external
to the container at `/davroot`, since this is where nginx will
expect to find files to serve up.


User Permissions and Uploaded Files
-----------------------------------

The nginx  in this container runs as the custom user `www:www`,
which defaults to a UID of 65500, and the same for a GID.  Because
nginx has some sever issues running (out of the gate) as a
non-root account -- specifically, `load_module` will always fail
-- we drop privileges to this account for normal operations.

If you need to specify an alternate UID / GID to better match up
to file ownership and access control lists, you can use the
following environment variables:

  - `NGINX_UID` - The numeric user ID for the `www` nginx user.
  - `NGINX_GID` - The numberic group ID for the `www` nginx group.


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
