variable "name" {
  description = "Имя виртуальной машины"
  type        = string
}

variable "cores" {
  description = "Количество ядер процессора"
  type        = number
}

variable "ram" {
  description = "Объём оперативной памяти (ГБ)"
  type        = number
}

variable "disk_size" {
  description = "Размер подключаемого диска (ГБ)"
  type        = number
}

variable "disk_type" {
  description = "Тип подключаемого диска"
  type        = string
  default     = "network-hdd"
}

variable "subnet_id" {
  description = "Идентификатор подсети"
  type        = string
}

variable "ssh_public_key" {
  description = "Публичный SSH-ключ"
  type        = string
}

variable "zone_id" {
  description = "Зона доступности"
  type        = string
}

variable "folder_id" {
  description = "Идентификатор каталога Yandex Cloud"
  type        = string
}

variable "image_id" {
  description = "Идентификатор образа ОС"
  type        = string
}

variable "platform_id" {
  description = "Платформа ВМ"
  type        = string
  default     = "standard-v3"
}

variable "nat" {
  description = "Назначать публичный IP"
  type        = bool
  default     = false
}

variable "labels" {
  description = "Метки ресурса"
  type        = map(string)
  default     = {}
}
