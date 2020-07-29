#!/bin/bash
set -e

# DEV:

oc process -f ../openshift/templates/deployment.yml \
-p=APPLICATION_NAME=api-verisoning-service \
-p=APP_NAMESPACE=api-versioning-service \
-p=BUILD_NAMESPACE=api-versioning-service \
-p=SA_NAMESPACE=api-versioning-service \
-p=READINESS_PATH="/health" \
-p=READINESS_RESPONSE=“\”status\”:\”UP\”” | oc apply -f -

# BUILD:

#oc process -f ../openshift/templates/build.yml \
#-p=APPLICATION_NAME=api-verisoning-service \
#-p=APP_NAMESPACE=api-versioning-service \
#-p=BUILD_NAMESPACE=api-versioning-service \
#-p=SOURCE_REPOSITORY_URL="https://github.com/nauticalmike/api-versioning-service.git" \
#-p=SOURCE_REPOSITORY_REF="master" \
#-p=APPLICATION_SOURCE_REPO="https://github.com/nauticalmike/api-versioning-service.git" | oc apply -f -

oc new-build --binary=true --name=api-verisoning-service --image-stream=fuse7-java-openshift:1.6
oc start-build api-verisoning-service --from-file=target/api-versioning-service-1.0-SNAPSHOT.jar