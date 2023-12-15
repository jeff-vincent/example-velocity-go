#!/bin/bash

kind create cluster --config=k8s/config.yaml
kubectl apply -f k8s/kind-nginx.yaml
echo "================================================"
echo "Waiting for Nginx ingress controller to spin up."
echo "================================================"
sleep 120
echo "================================================"
echo "Deploying sample application."
echo "================================================"
kubectl apply -f k8s/app.yaml
