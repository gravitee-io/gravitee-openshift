#!/bin/bash

oc login -u developer -p developer
oc project gravitee

# Start all
oc scale dc/elasticsearch --replicas=1
oc scale dc/mongodb --replicas=1
oc scale dc/gateway --replicas=1
oc scale dc/managementui --replicas=1
oc scale dc/managementapi --replicas=1
