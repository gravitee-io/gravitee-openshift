oc login -u system:admin
oc delete pv pv0001 pv0002

oc create -f pv0001.yaml
oc create -f pv0002.yaml