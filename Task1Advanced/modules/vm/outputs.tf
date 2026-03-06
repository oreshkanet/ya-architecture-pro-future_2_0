output "vm_id" {
  description = "Идентификатор виртуальной машины"
  value       = yandex_compute_instance.vm.id
}

output "vm_name" {
  description = "Имя виртуальной машины"
  value       = yandex_compute_instance.vm.name
}

output "vm_private_ip" {
  description = "Приватный IP-адрес ВМ"
  value       = yandex_compute_instance.vm.network_interface[0].ip_address
}

output "vm_nat_ip" {
  description = "Публичный IP-адрес ВМ (если включён NAT)"
  value       = try(yandex_compute_instance.vm.network_interface[0].nat_ip_address, null)
}

output "disk_id" {
  description = "Идентификатор подключаемого диска"
  value       = yandex_compute_disk.attached.id
}

output "disk_name" {
  description = "Имя подключаемого диска"
  value       = yandex_compute_disk.attached.name
}

output "zone" {
  description = "Зона доступности ВМ"
  value       = yandex_compute_instance.vm.zone
}
