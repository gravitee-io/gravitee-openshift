#-------------------------------------------------------------------------------
# Copyright (C) 2015 The Gravitee team (http://gravitee.io)
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#            http://www.apache.org/licenses/LICENSE-2.0
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#-------------------------------------------------------------------------------
FROM graviteeio/java:8

ARG GRAVITEEIO_VERSION=0

LABEL name="gateway:${GRAVITEEIO_VERSION}" \
      authors="Gravitee Team <http://gravitee.io>"

ENV GRAVITEEIO_MONGODB_HOST="mongodb" \
    GRAVITEEIO_MONGODB_PORT="27017" \
    GRAVITEEIO_ELASTIC_HOST="elasticsearch" \
    GRAVITEEIO_ELASTIC_PORT="9200" \
    GRAVITEEIO_HOME="/opt/graviteeio-management-api" \
    GRAVITEEIO_PORTAL_URL="http://localhost:80" \
    GIO_MIN_MEM="1g" \
    GIO_MAX_MEM="2g"

RUN set -eux; \
    echo "===> Installing OS Utility"; \
    apk add --update zip unzip netcat-openbsd wget

RUN set -eux; \
    echo "===> Installing the Gravitee Management API ${GRAVITEEIO_VERSION}"; \
    wget https://download.gravitee.io/graviteeio-apim/distributions/graviteeio-full-${GRAVITEEIO_VERSION}.zip --no-check-certificate -P /tmp/; \
    unzip /tmp/graviteeio-full-${GRAVITEEIO_VERSION}.zip -d /tmp/; \
    mv /tmp/graviteeio-full-${GRAVITEEIO_VERSION}/graviteeio-management-api* ${GRAVITEEIO_HOME}; \
    rm -rf /tmp/*; \
    chown -R 1001:0 ${GRAVITEEIO_HOME}; \
    chmod -R ug+rwX ${GRAVITEEIO_HOME}

WORKDIR ${GRAVITEEIO_HOME}

COPY config/gravitee.yml ${GRAVITEEIO_HOME}/config/
COPY bin/gravitee ${GRAVITEEIO_HOME}/bin/

RUN set -eux; \
    chmod ug+x ${GRAVITEEIO_HOME}/bin/gravitee; \
    chown -R 1001:0 ${GRAVITEEIO_HOME}/bin/gravitee

EXPOSE 8083
VOLUME ["${GRAVITEEIO_HOME}/logs"]
CMD ["./bin/gravitee"]
