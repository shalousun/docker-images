#!/usr/bin/env bash
set -o nounset # Treat unset variables as an error
exec su -l root -s /bin/bash -c "/usr/local/kibana/bin/kibana -c /etc/kibana/kibana.yml"