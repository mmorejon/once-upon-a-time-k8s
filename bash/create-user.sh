#!/bin/bash

USERNAME=$1
GROUP=$2
FOLDER="rbac"

openssl genrsa -out ${FOLDER}/${USERNAME}.key 2048

openssl req -new \
-key ${FOLDER}/${USERNAME}.key -out ${FOLDER}/${USERNAME}.csr \
-subj "/CN=${USERNAME}/O=${GROUP}"

openssl x509 -req -days 365 \
  -in ${FOLDER}/${USERNAME}.csr \
  -CA rbac/ca.crt \
  -CAkey rbac/ca.key \
  -CAcreateserial \
  -out ${FOLDER}/${USERNAME}.crt

kubectl --kubeconfig=${FOLDER}/${USERNAME}-config \
  config set-cluster kubernetes \
  --server https://127.0.0.1:6443 \
  --certificate-authority=rbac/ca.crt \
  --embed-certs=true

kubectl --kubeconfig=${FOLDER}/${USERNAME}-config \
  config set-credentials ${USERNAME} \
  --client-certificate=${FOLDER}/${USERNAME}.crt \
  --client-key=${FOLDER}/${USERNAME}.key \
  --embed-certs=true

kubectl --kubeconfig=${FOLDER}/${USERNAME}-config \
  config set-context ${USERNAME}@kubernetes \
  --user=${USERNAME} \
  --cluster=kubernetes \
  --namespace=default

kubectl --kubeconfig=${FOLDER}/${USERNAME}-config \
  config use-context ${USERNAME}@kubernetes
