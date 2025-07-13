variable "prefix" {
  type        = string
  description = "The prefix used for all resources in this terraform module"
}

variable "environment" {
  type        = string
  description = "The environment used for web apps in this terraform module"
}

variable "location" {
  type        = string
  description = "The Azure location where all resources in this example should be created"
  default = "westeurope"
}

variable "docker_registry_password" {
  type        = string
  description = "The password for the Docker registry"
}
