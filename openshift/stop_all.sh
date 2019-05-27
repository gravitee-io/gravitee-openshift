#!/bin/bash

oc login -u developer -p developer
oc project gravitee

# stop instance
oc scale dc/gateway --replicas=0
oc scale dc/managementui --replicas=0
oc scale dc/managementapi --replicas=0
oc scale dc/elasticsearch --replicas=0
oc scale dc/mongodb --replicas=0
