#!/usr/bin/env bash
set -o nounset # Treat unset variables as an error
exec su -l kibana -s /bin/bash -c "/usr/local/kibana/bin/kibana -c /etc/kibana/kibana.yml"