output "vm_id" {
  description = "Идентификатор ВМ"
  value       = module.vm.vm_id
}

output "vm_name" {
  description = "Имя ВМ"
  value       = module.vm.vm_name
}

output "vm_private_ip" {
  description = "Приватный IP ВМ"
  value       = module.vm.vm_private_ip
}

output "vm_nat_ip" {
  description = "Публичный IP ВМ"
  value       = module.vm.vm_nat_ip
}

output "disk_id" {
  description = "Идентификатор подключаемого диска"
  value       = module.vm.disk_id
}
