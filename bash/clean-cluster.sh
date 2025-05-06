#!/bin/bash

# general values
BASEDIR=$(pwd)
FLAGS='--ignore-not-found=true'

printf 'Iniciando el proceso de limpieza en el cluster ... \n'

# clean environment values
unset KUBECONFIG

# clean objets from chapter pods
kubectl --namespace default delete -f $BASEDIR/pods/ $FLAGS
kubectl --namespace default delete -f $BASEDIR/labels/ $FLAGS
kubectl --namespace default delete -f $BASEDIR/replicasets/ $FLAGS
kubectl --namespace default delete -f $BASEDIR/deployments/ $FLAGS
kubectl --namespace default delete -f $BASEDIR/services/ $FLAGS
kubectl delete -f $BASEDIR/ingress/nginx $FLAGS
kubectl --namespace default delete -f $BASEDIR/ingress/ $FLAGS
kubectl delete namespace ingress-nginx $FLAGS
kubectl delete -f $BASEDIR/namespaces/ $FLAGS
kubectl delete -f $BASEDIR/volumes/ $FLAGS
kubectl --namespace default delete -f $BASEDIR/configmaps/ $FLAGS
kubectl --namespace default delete -f $BASEDIR/secrets/ $FLAGS
rm -f $BASEDIR/secrets/tls.*
kubectl delete -f $BASEDIR/rbac/ $FLAGS
rm -f $BASEDIR/rbac/mmorejon*
rm -f $BASEDIR/rbac/ca*
kubectl --namespace default delete -f $BASEDIR/hpa/ $FLAGS
kubectl delete -f $BASEDIR/metrics-server/ $FLAGS

printf '\nHa terminado el proceso de limpieza en el cluster.\n'
