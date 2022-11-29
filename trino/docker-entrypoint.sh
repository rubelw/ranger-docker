#!/bin/bash
RANGER_VERSION=3.0.0
cd /root && \
curl https://github.com/aakashnand/trino-ranger-demo/releases/download/trino-ranger-demo-v1.0/ranger-${RANGER_VERSION}-SNAPSHOT-trino-plugin.tar.gz --output ranger-${RANGER_VERSION}-SNAPSHOT-trino-plugin.tar.gz -L &&
ls -latr && \
tar xvf ranger-${RANGER_VERSION}-SNAPSHOT-trino-plugin.tar.gz && \
yes | cp -rf /root/install.properties /root/ranger-${RANGER_VERSION}-SNAPSHOT-trino-plugin/ && \
chown root:root -R /root/ranger-${RANGER_VERSION}-SNAPSHOT-trino-plugin/* && \
/root/ranger-${RANGER_VERSION}-SNAPSHOT-trino-plugin/enable-trino-plugin.sh && \
ls -latr /usr/lib/trino/plugin && \
ls -latr /usr/lib/trino/etc && \
/usr/lib/trino/bin/run-trino