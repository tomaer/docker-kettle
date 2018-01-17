FROM anapsix/alpine-java:8_jdk
MAINTAINER tomaer Ma <i@tomaer.com>

ARG PDI_RELEASE=7.0
ARG PDI_VERSION=7.0.0.0-25
ARG KETTLE_USER=hive
ARG KETTLE_GROUP=hadoop
ENV PDI_HOME=/opt/pdi-ce

WORKDIR $PDI_HOME

ADD pdi.log /opt/pdi-ce/pdi.log

RUN apk update && apk upgrade && apk add --no-cache --update curl && \
    curl -L -o /tmp/pdi-ce-${PDI_VERSION}.zip \
    https://ncu.dl.sourceforge.net/project/pentaho/Data%20Integration/${PDI_RELEASE}/pdi-ce-${PDI_VERSION}.zip && \
    unzip -q /tmp/pdi-ce-${PDI_VERSION}.zip -d ${PDI_HOME} && \
    rm -rf $PDI_HOME/data-integration/samples $PDI_HOME/data-integration/docs /tmp/pdi-ce-${PDI_VERSION}.zip && \
    mkdir -p /opt/pdi-ce/datas /opt/pdi-ce/jobs && chmod +x /opt/pdi-ce/datas && chmod +x /opt/pdi-ce/jobs && \
    addgroup -S hadoop && adduser -h /home/hive -s /bin/ash -D -G hadoop hive && \
    echo "$KETTLE_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    chown -R $KETTLE_USER:$KETTLE_GROUP $PDI_HOME/data-integration && \
    chown -R $KETTLE_USER:$KETTLE_GROUP $PDI_HOME/datas && \
    chown -R $KETTLE_USER:$KETTLE_GROUP $PDI_HOME/jobs

ENV PATH=$PDI_HOME/data-integration:$PATH
VOLUME ["/home/${KETTLE_USER}","/opt/pdi-ce/datas","/opt/pdi-ce/jobs"]
USER $KETTLE_USER
ENTRYPOINT ["tail -lf /opt/pdi-ce/pdi.log"]