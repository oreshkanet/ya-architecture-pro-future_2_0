terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.13"
    }
  }
}

provider "yandex" {
  folder_id = var.folder_id
  zone      = var.zone_id
}

module "vm" {
  source = "../../modules/vm"

  name          = var.name
  cores         = var.cores
  ram           = var.ram
  disk_size     = var.disk_size
  disk_type     = var.disk_type
  subnet_id     = var.subnet_id
  ssh_public_key = var.ssh_public_key
  zone_id       = var.zone_id
  folder_id     = var.folder_id
  image_id      = var.image_id
  platform_id   = var.platform_id
  nat           = var.nat
  labels        = var.labels
}
