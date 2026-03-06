# Параметры вычислительных ресурсов
variable "cores" {
  description = "Количество ядер процессора"
  type        = number
}

variable "ram" {
  description = "Объём оперативной памяти (ГБ)"
  type        = number
}

# Подключаемый диск
variable "disk_size" {
  description = "Размер подключаемого диска (ГБ)"
  type        = number
}

variable "disk_type" {
  description = "Тип подключаемого диска (network-hdd, network-ssd и т.д.)"
  type        = string
  default     = "network-hdd"
}

# Сеть
variable "subnet_id" {
  description = "Идентификатор подсети"
  type        = string
}

variable "nat" {
  description = "Назначать ли публичный IP-адрес"
  type        = bool
  default     = false
}

# SSH-доступ
variable "ssh_public_key" {
  description = "Публичный SSH-ключ для доступа к ВМ"
  type        = string
}

# Идентификация и размещение
variable "name" {
  description = "Имя виртуальной машины"
  type        = string
}

variable "zone_id" {
  description = "Зона доступности"
  type        = string
}

variable "folder_id" {
  description = "Идентификатор каталога в Yandex Cloud"
  type        = string
}

variable "image_id" {
  description = "Идентификатор образа ОС для загрузочного диска"
  type        = string
}

variable "platform_id" {
  description = "Платформа (тип виртуальной машины)"
  type        = string
  default     = "standard-v3"
}

variable "labels" {
  description = "Метки ресурса"
  type        = map(string)
  default     = {}
}
