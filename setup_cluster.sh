#!/bin/bash

kind create cluster --config=k8s/config.yaml
kubectl apply -f k8s/kind-nginx.yaml

echo "================================================"
echo "Waiting for Nginx ingress controller to spin up."
echo "================================================"

# Wait for the "controller" pod to be in a "Running" state
pod_name=""
for ((i=11; i>0; i--)); do
    # Get the pod name containing "controller"
    pod_name=$(kubectl get pods -n ingress-nginx | grep controller | awk '{print $1}')

    # Check if the pod is running
    if [ -n "$pod_name" ]; then
        pod_status=$(kubectl get pod -n ingress-nginx "$pod_name" -o jsonpath='{.status.phase}')
        if [ "$pod_status" == "Running" ]; then
            echo "."
            sleep 25
            break
        fi
    fi

    echo "."
    sleep 10
done

if [ -z "$pod_name" ]; then
    echo "Failed to find a 'controller' pod in a 'Running' state within the timeout."
    exit 1
fi

echo "================================================"
echo "Deploying sample application."
echo "================================================"

kubectl apply -f k8s/app.yaml

