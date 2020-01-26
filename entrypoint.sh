#!/bin/sh

if [ "x$1" = "xdefaults" ]; then
	exec cat /etc/nginx/nginx.conf
fi

exec nginx -g 'daemon off;' "$@"
