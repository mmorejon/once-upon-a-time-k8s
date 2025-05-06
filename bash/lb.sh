#!/bin/bash

# get all parameters
args=("$@")

# create load balancer
if [[ " ${args[*]} " == *" start "* ]]; then
    docker container run --rm --detach \
      --name cloud-provider-kind \
      --network kind \
      --volume /var/run/docker.sock:/var/run/docker.sock \
      registry.k8s.io/cloud-provider-kind/cloud-controller-manager:v0.6.0
fi
# stop load balancer
if [[ " ${args[*]} " == *" stop "* ]]; then
    docker container stop cloud-provider-kind
fi
# restart load balancer
if [[ " ${args[*]} " == *" restart "* ]]; then
    ./bash/lb.sh stop
    sleep 3
    ./bash/lb.sh start
fi
# check if load balancer is running
if [[ " ${args[*]} " == *" check "* ]]; then
    docker container ls --filter name=cloud-provider-kind --quiet
fi
# logs load balancer
if [[ " ${args[*]} " == *" logs "* ]]; then
    docker container logs cloud-provider-kind --follow
fi
