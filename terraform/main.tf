terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.75.0"

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "zlobniy-shurik-terraform-storage"
    region     = "ru-central1"
    key        = "myterraform.tfstate"
    access_key = "YCAJExo1efKl47MoZ2MK0DQBu"
    secret_key = "YCNs1J-aIBklaRQOQDyC7S6JYlCF6Emt9CUjFjvb"

    skip_region_validation      = true
    skip_credentials_validation = true
}

}

provider "yandex" {
  token     = "AQAAAABa7AAAAATuwUw-hNWCZEangXG2yzDnLCQ"
  cloud_id  = "b1gm2esngl1st6t66102"
  folder_id = "b1g5mgpdiul101t5akk0"
  zone      = "ru-central1-a"
}

