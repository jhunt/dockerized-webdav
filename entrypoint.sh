#!/bin/sh

if [ "x$1" = "xdefaults" ]; then
	exec cat /etc/nginx/nginx.conf
fi

if [ "x$NGINX_UID" = "x" ]; then
	echo "webdav :: using (~default~) uid $NGINX_UID"
	NGINX_UID=65500
else
	echo "webdav :: using (specified) uid $NGINX_UID"
fi
if [ "x$NGINX_GID" = "x" ]; then
	echo "webdav :: using (~default~) gid $NGINX_GID"
	NGINX_UID=65500
else
	echo "webdav :: using (specified) gid $NGINX_GID"
fi

echo "webdav :: updating /etc/passwd and /etc/group"
sed -i -e "s|^www:.*|www:x:$NGINX_UID:$NGINX_GID:www:/var/www/html:/sbin/nologin|" /etc/passwd
sed -i -e "s|^www:.*|www:x:$NGINX_GID:www|"                                        /etc/group


echo "webdav :: changing ownership on temporary directories to www:www ($NGINX_UID:$NGINX_GID)"
chown -R www:www /var/lib/nginx/tmp

echo "webdav :: starting up nginx..."
exec nginx -g 'daemon off;' "$@"
