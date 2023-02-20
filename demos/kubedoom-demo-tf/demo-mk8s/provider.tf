// =============================================
// define provider
// =============================================

variable "my_api_key_file" { type = string }
variable "my_cloud_id" { type = string }
variable "my_folder_id" { type = string }
variable "my_zone" { type = string }

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  endpoint                 = "api.cloudil.com:443"
  storage_endpoint         = "storage.cloudil.com:443"
  service_account_key_file = var.my_api_key_file
  cloud_id                 = var.my_cloud_id
  folder_id                = var.my_folder_id
  zone                     = var.my_zone
}