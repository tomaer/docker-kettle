#!/bin/bash


if [ ! -d "/opt/pdi-ce/account" ]; then
    addgroup -S hadoop && adduser -h /home/hive -s /bin/ash -D -G hadoop hive && \
        echo "$KETTLE_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
        chown -R $KETTLE_USER:$KETTLE_GROUP $PDI_HOME/data-integration \
        chown -R $KETTLE_USER:$KETTLE_GROUP $PDI_HOME/datas && \
        chown -R $KETTLE_USER:$KETTLE_GROUP $PDI_HOME/jobs && touch /opt/pdi-ce/account
fi

