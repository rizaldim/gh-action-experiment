terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }

  backend "s3" {
    endpoints = {
      s3 = "https://fsn1.your-objectstorage.com"
    }
    bucket = "hachyderm-infra-dev"
    key    = "atlantis-take-1.tfstate"

    # Deactivate a few AWS-specific checks
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
    region                      = "fsn1"
  }
}


# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option
variable "hcloud_token" {
  sensitive = true
}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_network" "privNet" {
  name     = "my-net"
  ip_range = "10.0.1.0/24"
}

resource "hcloud_network" "privNet_2" {
  name     = "my-net-2"
  ip_range = "10.0.2.0/24"
}

resource "null_resource" "example" {}
