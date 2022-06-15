terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.75.0"
}

provider "yandex" {
  token     = "AQAAAABa7AAAAATuwUw-hNWCZEangXG2yzDnLCQ"
  cloud_id  = "b1gm2esngl1st6t66102"
  folder_id = "b1g5mgpdiul101t5akk0"
  zone      = "ru-central1-a"
}
