#!/bin/sh
set -e
PATH=$PATH":/usr/share/kibana/bin"
# Add kibana as command if needed
if [[ "$1" == -* ]]; then
	set -- kibana "$@"
fi

# Run as user "kibana" if the command is "kibana"
if [ "$1" = 'kibana' ]; then
	set -- su - root -s /bin/sh -c kibana -- "$@"
fi
exec "$@"