# gravitee-OpenShift
https://github.com/cprato79/gravitee-openshift

Fork from official: https://github.com/gravitee-io/gravitee-openshift

## Description

Gravitee is composed by the following three components:
- gateway
- management-api
- management-ui

and the following dependecies:
- mongoDB
- elasticsearch limited to version:
  - 2.x
  - 5.x

### elastisearch:
  * 9200 => REST request
  * 9300 => HTTP request

### docker images:

commands shortcut:

```
oc rsync --exclude=* --include="gravitee.yml" gateway-1-86gfd:/opt/graviteeio-gateway/config/ ./config/
```

## gateway
Import the images on openshift registry:
  - `docker.io/graviteeio/gateway:latest`
  - `oc import-image graviteeio/gateway:latest --confirm`

before proceed to create all the openshift objects it sets the properties by ENV section of Deployment Config on Opneshift template: ""

```
- name: GRAVITEE_MANAGEMENT_MONGODB_URI
  value: "mongodb://mongodb:27017/gravitee?serverSelectionTimeoutMS=5000&connectTimeoutMS=5000&socketTimeoutMS=5000"
- name: GRAVITEE_RATELIMIT_MONGODB_URI
  value: "mongodb://mongodb:27017/gravitee?serverSelectionTimeoutMS=5000&connectTimeoutMS=5000&socketTimeoutMS=5000"
- name: GRAVITEE_REPORTERS_ELASTICSEARCH_ENDPOINTS_0
  value: "http://elasticsearch:9200"
- name: GRAVITEE_PLUGINS_PATH_0
  value: "$${gravitee.home}/plugins"
#  - name: GRAVITEE_PLUGINS_PATH_1
#    value: "$${gravitee.home}/plugins-ext"
```

## management-api
  - `docker.io/graviteeio/gateway:latest`
  - `oc import-image graviteeio/gateway:latest --confirm`

```
  - name: GRAVITEE_MANAGEMENT_MONGODB_URI
    value: "mongodb://mongodb:27017/gravitee?serverSelectionTimeoutMS=5000&connectTimeoutMS=5000&socketTimeoutMS=5000"
  - name: GRAVITEE_RATELIMIT_MONGODB_URI
    value: "mongodb://mongodb:27017/gravitee?serverSelectionTimeoutMS=5000&connectTimeoutMS=5000&socketTimeoutMS=5000"
  - name: GRAVITEE_ANALYTICS_ELASTICSEARCH_ENDPOINTS_0
    value: "http://elasticsearch:9200"
  - name: GRAVITEE_USER_LOGIN_DEFAULTAPPLICATION
    value: "false"
  - name: GRAVITEE_PLUGINS_PATH_0
    value: "$${gravitee.home}/plugins"
#  - name: GRAVITEE_PLUGINS_PATH_1
#    value: $${gravitee.home}/plugins-ext
```

## Web Interface for Gravitee
http://managementui-gravitee.10.5.18.122.nip.io/#!/
admin/admin


# Setup on OpenShift

- run the script: `openshift/template-graviteeapim.yaml` as openshift system:admin user
- issue to fix:
 - oc tag images...
 - java:8
 - nginx:latest
