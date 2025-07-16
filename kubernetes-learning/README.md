# Kubernetes Learning

This directory contains Kubernetes configurations and learning materials.

## Structure

- `basics/` - Basic Kubernetes objects (Pods, Services, Deployments)
- `advanced/` - Advanced concepts (ConfigMaps, Secrets, Ingress)
- `helm-charts/` - Helm chart examples
- `examples/` - Complete application examples

## Quick Start

1. Start your Kubernetes cluster:
   - For Minikube: `minikube start`
   - For kind or cloud clusters, ensure they are running
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

## Helm Charts

Helm is the package manager for Kubernetes, often referred to as "the Kubernetes package manager." It helps you manage Kubernetes applications through Helm charts.

### What are Helm Charts?

Helm charts are packages of pre-configured Kubernetes resources that can be easily deployed, upgraded, and managed. A chart is a collection of files that describe a related set of Kubernetes resources.

### Advantages of Helm Charts

1. **Templating**: Use variables and templates to create reusable configurations
2. **Dependency Management**: Manage complex applications with multiple dependencies
3. **Version Control**: Track releases and easily rollback to previous versions
4. **Configuration Management**: Override default values for different environments
5. **Simplified Deployment**: Deploy complex applications with a single command
6. **Release Management**: Manage application lifecycle with install, upgrade, and uninstall
7. **Community Charts**: Access thousands of pre-built charts from the Helm Hub

### Getting Started with Helm

```bash
# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Add a chart repository
helm repo add bitnami https://charts.bitnami.com/bitnami

# Search for charts
helm search repo nginx

# Install a chart
helm install my-release bitnami/nginx

# List installed releases
helm list

# Upgrade a release
helm upgrade my-release bitnami/nginx

# Uninstall a release
helm uninstall my-release
```

### Creating Your Own Helm Chart

```bash
# Create a new chart
helm create my-app

# Validate the chart
helm lint my-app

# Package the chart
helm package my-app

# Install from local chart
helm install my-app ./my-app
```

### Resources

- [Helm Documentation](https://helm.sh/docs/)
- [Azure AKS Helm Quickstart](https://learn.microsoft.com/en-us/azure/aks/quickstart-helm?tabs=azure-cli)
- [Helm Hub](https://artifacthub.io/)
- [Helm Best Practices](https://helm.sh/docs/chart_best_practices/)

## Terraform with Kubernetes

Terraform can be used to provision and manage Kubernetes clusters, particularly Azure Kubernetes Service (AKS). This approach treats your Kubernetes infrastructure as code.

### Terraform + AKS Benefits

1. **Infrastructure as Code**: Version control your cluster configuration
2. **Reproducible Deployments**: Create identical clusters across environments
3. **Automated Provisioning**: Provision clusters programmatically
4. **Integration**: Combine with Helm for complete infrastructure and application management

### Terraform + Helm Integration

Terraform and Helm work well together:

- **Terraform**: Manages cluster infrastructure (nodes, networking, RBAC)
- **Helm**: Manages application deployments on the cluster

```hcl
# Example: Terraform provisions AKS, then deploys via Helm
resource "azurerm_kubernetes_cluster" "main" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "myaks"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_D2_v2"
  }
}

resource "helm_release" "my_app" {
  name       = "my-app"
  chart      = "./helm-charts/my-app"
  depends_on = [azurerm_kubernetes_cluster.main]
}
```

### Resources

- [Deploy AKS with Terraform](https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-terraform?pivots=development-environment-azure-cli)
- [Terraform AKS Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster)
- [Terraform Helm Provider](https://registry.terraform.io/providers/hashicorp/helm/latest/docs)
