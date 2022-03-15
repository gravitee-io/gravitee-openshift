#!/bin/bash

oc login -u admin
oc delete pv pv0001 pv0002

oc create -f persistentvolumes/pv0001.yaml
oc create -f persistentvolumes/pv0002.yaml
