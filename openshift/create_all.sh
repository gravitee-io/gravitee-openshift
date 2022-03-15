#!/bin/bash

# create pv
persistentvolumes/create_pv.sh

# create project
oc login -u developer -p developer
oc new-project gravitee

# add service account for host path
oc create serviceaccount gravitee -n gravitee

# affect policy
oc login -u admin
oc project gravitee
oc adm policy add-scc-to-user anyuid -z gravitee

oc login -u developer -p developer
#oc project gravitee

# get images
#oc import-image nginx:1.10.2-alpine --confirm
#oc import-image graviteeio/java:8 --confirm

# set GRAVITEEIO_VERSION=1.10.4
export GRAVITEEIO_VERSION=1.26.0


add_secret_opt () {
  export GIT_SECRET_OPT="--source-secret=git-secret"

  # create secret to gravitee project
  oc create -f secret/create_secret.yml -n gravitee
  # link secret to build service
  for i in default deployer builder gravitee; do oc secret link $i git-secret --for=pull -n gravitee;done
}

# 1. definie build
# 2. start building
# 3. tag this version

# disable for secret creation
#add_secret_opt

# gateway
oc new-build --name=gateway --binary --strategy=docker $GIT_SECRET_OPT --build-arg=GRAVITEEIO_VERSION=$GRAVITEEIO_VERSION
oc start-build gateway --wait --from-dir=gateway
sleep 5
oc tag gateway:latest gateway:$GRAVITEEIO_VERSION


# management-api
oc new-build --name=management-api --binary --strategy=docker $GIT_SECRET_OPT --build-arg=GRAVITEEIO_VERSION=$GRAVITEEIO_VERSION
oc start-build management-api --wait --from-dir=management-api
sleep 5
oc tag management-api:latest management-api:$GRAVITEEIO_VERSION

# management-ui
oc new-build --name=management-ui --binary --strategy=docker $GIT_SECRET_OPT --build-arg=GRAVITEEIO_VERSION=$GRAVITEEIO_VERSION
oc start-build management-ui --wait --from-dir=management-ui
sleep 5
oc tag management-ui:latest management-ui:$GRAVITEEIO_VERSION

# import OpenShift Template
oc process -f ./template-graviteeapim.yaml | oc create -f -
