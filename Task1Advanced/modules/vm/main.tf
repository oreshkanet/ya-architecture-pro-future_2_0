terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.13"
    }
  }
}

# Подключаемый диск (отдельный ресурс)
resource "yandex_compute_disk" "attached" {
  name      = "${var.name}-disk"
  type      = var.disk_type
  zone      = var.zone_id
  folder_id = var.folder_id
  size      = var.disk_size
  labels    = var.labels
}

# Виртуальная машина
resource "yandex_compute_instance" "vm" {
  name        = var.name
  folder_id   = var.folder_id
  zone        = var.zone_id
  platform_id = var.platform_id
  labels      = var.labels

  resources {
    cores         = var.cores
    memory        = var.ram
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 20
      type     = "network-hdd"
    }
  }

  # Подключаемый диск
  secondary_disk {
    disk_id     = yandex_compute_disk.attached.id
    auto_delete = false
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = var.nat
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}
