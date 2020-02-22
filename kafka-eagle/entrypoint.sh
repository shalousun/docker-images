#!/bin/bash

chmod +x /opt/kafka-eagle/bin/ke.sh
mkdir -p //opt/kafka-eagle/db/
sh /opt/kafka-eagle/bin/ke.sh start
tail -f /opt/kafka-eagle/logs/log.log