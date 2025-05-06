#!/bin/bash

# get all parameters
args=("$@")

# create cluster
if [[ " ${args[*]} " == *" create "* ]]; then
kind create cluster \
    --config=cluster/kind-config.yaml
fi
# cluster multi-region
if [[ " ${args[*]} " == *" create-multi-region "* ]]; then
kind create cluster \
    --config=cluster/multi-region.yaml
fi
# cluster custom networks
if [[ " ${args[*]} " == *" create-custom-networks "* ]]; then
kind create cluster \
    --config=cluster/custom-networks.yaml
fi
# delete cluster
if [[ " ${args[*]} " == *" delete "* ]]; then
kind delete cluster --name book
fi
# restart cluster
if [[ " ${args[*]} " == *" restart "* ]]; then
./bash/cluster.sh delete
./bash/cluster.sh create
fi
# restart cluster multi-region
if [[ " ${args[*]} " == *" restart-multi-region "* ]]; then
./bash/cluster.sh delete
./bash/cluster.sh create-multi-region
fi
# restart cluster custom networks
if [[ " ${args[*]} " == *" restart-custom-networks "* ]]; then
./bash/cluster.sh delete
./bash/cluster.sh create-custom-networks
fi
# clean cluster
if [[ " ${args[*]} " == *" clean "* ]]; then
./bash/clean-cluster.sh
fi
# simulate node rotation
if [[ " ${args[*]} " == *" simulate-node-rotation "* ]]; then
kubectl drain book-worker --ignore-daemonsets --delete-emptydir-data
kubectl uncordon book-worker
kubectl drain book-worker2 --ignore-daemonsets --delete-emptydir-data
kubectl uncordon book-worker2
fi
