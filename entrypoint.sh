#!/bin/bash

export KETTLE_USER=$1 KETTLE_GROUP=$2

if [ ! -n "$KETTLE_USER" ]||[ ! -n "$KETTLE_GROUP" ] ;then
    KETTLE_USER="kettle"
    KETTLE_GROUP="kettle"
fi

if [ ! -d "/opt/pdi-ce/account" ]; then
    addgroup -S $KETTLE_GROUP && adduser -h /home/$KETTLE_USER -s /bin/ash -G $KETTLE_GROUP $KETTLE_USER && \
        echo "$KETTLE_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
        chown -R $KETTLE_USER:$KETTLE_GROUP $PDI_HOME/data-integration \
        chown -R $KETTLE_USER:$KETTLE_GROUP $PDI_HOME/datas && \
        chown -R $KETTLE_USER:$KETTLE_GROUP $PDI_HOME/jobs && touch /opt/pdi-ce/account
fi

