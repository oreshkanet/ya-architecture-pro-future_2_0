name             = "vm-prod"
cores            = 4
ram              = 8
disk_size        = 100
disk_type        = "network-ssd"
nat              = false

folder_id        = "b1g7ac2sm6p1t8s4jnmj"
zone_id          = "ru-central1-a"
subnet_id        = "e9bfnhd9h375eejhsof1"
image_id         = "fd8ccfejmpaipf677j5c"
ssh_public_key   = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJzhpPIdMXfUzNm/zcQfJUfWPH4/u29gynFWK5ELbBVa d.i.saygin@yandex.ru"

labels = {
  env  = "prod"
  role = "production"
}
