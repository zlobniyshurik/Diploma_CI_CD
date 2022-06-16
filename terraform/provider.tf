terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.75.0"
}

provider "yandex" {
  token     = var.ya_token
  cloud_id  = var.ya_cloud_id
  folder_id = var.ya_folder_id
  zone      = var.ya_zone
}

