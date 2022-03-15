# gravitee-OpenShift

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

## gateway
Import the images on openshift registry:
  - `docker.io/graviteeio/gateway:latest`
  - `oc import-image graviteeio/gateway:latest --confirm`

before proceed to create all the openshift objects it sets the properties by ENV section of Deployment Config on Openshift template: ""

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

remember to update the url `10.5.18.122.nip.io` to reach from outside the cluster on the following files:
  * images/management-ui/html/constants.json
  * images/management-ui/Dockerfile

# Setup on OpenShift

 * the script: `openshift/create_all.sh` creates all objects
 * the script: `openshift/template-graviteeapim.yaml` as openshift system:admin user is automatically used to create all needed openshift objects

#### issue to fix:
 - oc tag images...
 - extract in ENV the version of packages (java, nginx, others)
