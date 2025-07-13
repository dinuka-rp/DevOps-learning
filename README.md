# DevOps Learning

This repository contains my learning journey with DevOps tools and technologies, focusing on Terraform, Azure infrastructure as code, and Kubernetes container orchestration.

## Projects

### 1. learn-terraform-azure

Basic Terraform configuration for learning Azure resource provisioning.

### 2. learn-terraform-docker-container

Terraform configuration for managing Docker containers.

### 3. terraform-azure-app-service-docker

Terraform configuration for deploying Docker containers to Azure App Service, including:

- Linux Web App with Docker container deployment
- Azure Key Vault for secrets management
- Service Plan configuration

### 4. tfc-getting-started

Getting started with Terraform Cloud configuration and remote state management.

### 5. kubernetes-learning

Kubernetes configuration and orchestration learning, including:

- Pod, Service, and Deployment configurations
- ConfigMaps and Secrets management
- Ingress controllers and networking
- Helm charts for package management
- kubectl commands and cluster management

## Technologies Used

- **Terraform** - Infrastructure as Code
- **Azure** - Cloud platform
- **Docker** - Containerization
- **Kubernetes** - Container orchestration
- **Helm** - Kubernetes package manager
- **kubectl** - Kubernetes command-line tool
- **Terraform Cloud** - Remote state management and CI/CD

## Getting Started

1. Clone this repository
2. Navigate to the specific project directory
3. Initialize Terraform: `terraform init`
4. Plan your deployment: `terraform plan`
5. Apply changes: `terraform apply`

## Prerequisites

- Terraform installed
- Azure CLI configured
- Docker (for container projects)
- kubectl installed (for Kubernetes projects)
- Access to a Kubernetes cluster (local with minikube/kind or cloud-based)
- Helm installed (for Kubernetes package management)
- Access to Terraform Cloud (for remote state projects)

## Notes

This repository is for learning purposes and contains various configurations at different stages of completion:

- Terraform configurations for infrastructure provisioning
- Kubernetes manifests for container orchestration
- Docker configurations for containerization
- Integration examples between different technologies
