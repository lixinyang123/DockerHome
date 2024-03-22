#!/bin/bash

currentDir="$(cd "$(dirname $0)";pwd)"

kubectl apply -f $currentDir/../k8s/corehome-database.yml
kubectl apply -f $currentDir/../k8s/corehome-appsettings.yml
kubectl apply -f $currentDir/../k8s/corehome-yarpsettings.yml
kubectl apply -f $currentDir/../k8s/corehome-admin.yml
kubectl apply -f $currentDir/../k8s/corehome-homepage.yml
kubectl apply -f $currentDir/../k8s/corehome-reverseproxy.yml
