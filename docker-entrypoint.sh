#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- crond "$@"
fi

if [ "$1" = 'crond' ]; then
	whenever --update-crontab
	set -- crond "$@"
fi

if [ "$1" = 'backup' ]; then
	set -- backup "$@"
fi

exec "$@"
