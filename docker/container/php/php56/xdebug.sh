#!/usr/bin/env bash

if [ "$1" = "off" ]; then
	mv /usr/local/etc/php/conf.d/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini.off;
	echo "xdebug disabled";
else
	mv /usr/local/etc/php/conf.d/xdebug.ini.off /usr/local/etc/php/conf.d/xdebug.ini;
	echo "xdebug enabled";
fi

service apache2 reload
