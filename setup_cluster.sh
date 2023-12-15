#!/bin/bash

kind create cluster --config=k8s/config.yaml
kubectl apply -f k8s/kind-nginx.yaml

echo "================================================"
echo "Waiting for Nginx ingress controller to spin up."
echo "================================================"

for ((i=11; i>0; i--)); do
    echo "Waiting for $((i * 10)) seconds..."
    sleep 10
done

echo "================================================"
echo "Deploying sample application."
echo "================================================"

kubectl apply -f k8s/app.yaml
