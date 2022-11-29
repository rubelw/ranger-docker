#!/bin/bash

RANGER_VERSION=3.0.0

#wget https://github.com/aakashnand/trino-ranger-demo/releases/download/trino-ranger-demo-v1.0/ranger-${RANGER_VERSION}-admin.tar.gz && \
#tar xvf ranger-${RANGER_VERSION}-admin.tar.gz && \
cd /opt/ranger-${RANGER_VERSION}-SNAPSHOT-admin/ && \
cp /opt/install.properties /opt/ranger-${RANGER_VERSION}-SNAPSHOT-admin/ && \
./setup.sh && \
ranger-admin start && \
tail -f /opy/ranger-${RANGER_VERSION}-SNAPSHOT-admin/ews/logs/ranger-admin-*-.log