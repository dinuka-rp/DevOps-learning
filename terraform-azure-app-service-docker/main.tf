# ref: https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/app-service/docker-basic
terraform {
  required_version = ">= 1.7.1"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.92.0"
    }
  }
  
#   only to store remote state
    # backend "remote" {
    #     organization =  "shapeable"
    #     workspaces {
    #         name = "adsw-dev-tf-ws"
    #     }
    # }
# to store state in cloud and run the workflow in cloud
  cloud {
    # Specify the name of the organization in Terraform Cloud
    organization = "shapeable"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_service_plan" "sp" {
  name                = "${var.prefix}-sp"  # use the same sp for all environments
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "gpt_app" {
  name                = "${var.prefix}${var.environment != "" ? "-${var.environment}" : ""}-gpt-server"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.sp.id

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_ENABLE_CI" = "true"
  }

  site_config {
    always_on = true

    application_stack {
      docker_image_name   = "shapeableai/llm-playground:${var.prefix}${var.environment != "" ? "-${var.environment}" : ""}"
      docker_registry_url = "https://index.docker.io"
      docker_registry_username="shapeableai"
      docker_registry_password="${var.docker_registry_password}"
    }
  }
}

#  key vault to store secrets
resource "azurerm_key_vault" "key_vault" {
    name = "${var.prefix}"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    sku_name = "standard"
    tenant_id = data.azurerm_client_config.current.tenant_id
    enable_rbac_authorization = true

    # access_policy {
    #     tenant_id = data.azurerm_client_config.current.tenant_id
    #     object_id = data.azurerm_client_config.current.object_id

    #     secret_permissions = [
    #         "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"
    #     ]
    #     key_permissions = [
    #         "Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"
    #     ]

    #     certificate_permissions = [
    #         "Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "Purge"
    #     ]
    # }
}

# TODO: keyvault roles - grant access to github actions service principal & dev.ops account
# variable "user_access_policies" {
#   description = "Map of user object IDs and their key vault access permissions"
#   type = map(object({
#     key_permissions          = list(string)
#     secret_permissions       = list(string)
#     certificate_permissions  = list(string)
#   }))
#   default = {
#     # GitHub Actions Service Principal
#     "5d15d68d-64ae-4c49-ba35-5f848707ec2a" = {
#       key_permissions         = []
#       secret_permissions      = ["Get", "List"]
#       certificate_permissions = []
#       },
#     # DevOps Account
#     "1228da19-8b01-4d35-94c1-58c45467a49a" = {
#       key_permissions         =  ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
#       secret_permissions      = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
#       certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "Purge"]
#       },
#     # Dinuka's MacBook CLI Service Principal
#     "e2b7dd24-c160-4337-a42c-cd2f24afae3e" = {
#       key_permissions         =  ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
#       secret_permissions      = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
#       certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "Purge"]
#       }
#     // Add more users as needed
#   }
# }

# resource "azurerm_key_vault_access_policy" "all_users" {
#   for_each     = var.user_access_policies
#   key_vault_id = azurerm_key_vault.key_vault.id
#   tenant_id    = data.azurerm_client_config.current.tenant_id
#   object_id    = each.key

#   key_permissions         = each.value.key_permissions
#   secret_permissions      = each.value.secret_permissions
#   certificate_permissions = each.value.certificate_permissions
# }