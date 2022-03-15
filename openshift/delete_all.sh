#!/bin/bash

#delete objects
oc delete dc mongodb -n gravitee
oc delete services mongodb -n gravitee
oc delete imagestream mongodb -n gravitee

oc delete dc elasticsearch -n gravitee
oc delete services elasticsearch -n gravitee
oc delete imagestream elasticsearch -n gravitee

oc delete dc managementui -n gravitee
oc delete services managementui -n gravitee
oc delete route managementui -n gravitee
oc delete imagestream management-ui -n gravitee
oc delete bc management-ui -n gravitee

oc delete dc managementapi -n gravitee
oc delete services managementapi -n gravitee
oc delete route managementapi -n gravitee
oc delete imagestream management-api -n gravitee
oc delete bc management-api -n gravitee

oc delete dc gateway -n gravitee
oc delete services gateway -n gravitee
oc delete route gateway -n gravitee
oc delete imagestream gateway -n gravitee
oc delete bc gateway -n gravitee

oc delete persistentvolumeclaim elasticdata -n gravitee
oc delete persistentvolumeclaim mongodata -n gravitee

