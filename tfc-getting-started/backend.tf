# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# The block below configures Terraform to use the 'remote' backend with Terraform Cloud.
# For more information, see https://www.terraform.io/docs/backends/types/remote.html
terraform {
  cloud {
    organization = "example-org-5f4514"

    workspaces {
      name = "getting-started"
    }
  }

  required_version = ">= 1.1.2"
}
