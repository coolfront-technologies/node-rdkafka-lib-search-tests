#!/bin/bash
#clean out images. Added this for safety due to some perceived issues with --no-cache
docker image rm mike-coolfront/librdkafka-no-lib-issue
docker image rm mike-coolfront/librdkafka-wrong-lib-issue

#build images we'll be using
docker build --no-cache -t mike-coolfront/librdkafka-no-lib-issue -f ./ub18Clean .
docker build --no-cache -t mike-coolfront/librdkafka-wrong-lib-issue -f ./ub18SystemLevelLibs .
