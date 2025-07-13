# Kubernetes Learning

This directory contains Kubernetes configurations and learning materials.

## Structure

- `basics/` - Basic Kubernetes objects (Pods, Services, Deployments)
- `advanced/` - Advanced concepts (ConfigMaps, Secrets, Ingress)
- `helm-charts/` - Helm chart examples
- `examples/` - Complete application examples

## Quick Start

1. Ensure you have a Kubernetes cluster running (minikube, kind, or cloud cluster)
2. Verify kubectl is configured: `kubectl cluster-info`
3. Apply configurations: `kubectl apply -f <filename>.yaml`
4. Check resources: `kubectl get pods,services,deployments`

## Useful Commands

```bash
# Get cluster info
kubectl cluster-info

# Get all resources
kubectl get all

# Describe a resource
kubectl describe <resource-type> <resource-name>

# Get logs from a pod
kubectl logs <pod-name>

# Execute commands in a pod
kubectl exec -it <pod-name> -- /bin/bash

# Port forward to access services locally
kubectl port-forward service/<service-name> <local-port>:<service-port>
```

## Learning Path

1. **Basics**: Pods, Services, Deployments
2. **Configuration**: ConfigMaps, Secrets
3. **Networking**: Ingress, Network Policies
4. **Storage**: Persistent Volumes, Persistent Volume Claims
5. **Package Management**: Helm charts
6. **Monitoring**: Resource monitoring and logging
