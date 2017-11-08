# create pv
persistentvolumes/create_pv.cmd

# create project
oc login -u developer -p developer
oc new-project gravitee

# add service account for host path
oc create serviceaccount gravitee -n gravitee

# affect policy
oc login -u system:admin
oc project gravitee
oc adm policy add-scc-to-user anyuid -z gravitee

oc login -u developer -p developer

set GRAVITEEIO_VERSION=1.10.4

# 1. definie build
# 2. start building
# 3. tag this version

# gateway
oc new-build ../ --name=gateway --context-dir=images/gateway/ --strategy=docker --build-arg=GRAVITEEIO_VERSION=%GRAVITEEIO_VERSION%
oc start-build gateway --from-dir ../images/gateway/ --build-arg=GRAVITEEIO_VERSION=%GRAVITEEIO_VERSION%
oc tag gateway:latest gateway:%GRAVITEEIO_VERSION%

# management-api
oc new-build ../ --name=management-api --context-dir=images/management-api/ --strategy=docker --build-arg=GRAVITEEIO_VERSION=%GRAVITEEIO_VERSION%
oc start-build management-api --from-dir ../images/management-api/ --build-arg=GRAVITEEIO_VERSION=%GRAVITEEIO_VERSION%
oc tag management-api:latest management-api:%GRAVITEEIO_VERSION%

# management-ui
oc new-build ../ --name=management-ui --context-dir=images/management-ui/ --strategy=docker --build-arg=GRAVITEEIO_VERSION=%GRAVITEEIO_VERSION%
oc start-build management-ui --from-dir ../images/management-ui/ --build-arg=GRAVITEEIO_VERSION=%GRAVITEEIO_VERSION%
oc tag management-ui:latest management-ui:%GRAVITEEIO_VERSION%

# import OpenShift Template
oc process -f .\template-graviteeapim.yaml | oc create -f -



