#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- crond "$@"
fi

if [ "$1" = 'crond' ]; then
	if [ ! -f config/schedule.rb ]; then
		if [ ! -d config ]; then
			mkdir config
		fi
		wheneverize
	fi
	whenever --update-crontab
	shift
	set -- crond "$@"
fi

if [ "$1" = 'backup' ]; then
	shift
	set -- backup "$@"
fi

exec "$@"
