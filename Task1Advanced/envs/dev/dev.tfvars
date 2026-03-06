name           = "vm-dev"
cores          = 2
ram            = 2
disk_size      = 20
disk_type      = "network-hdd"
nat            = true

folder_id      = "b1g0a23pg0uiohgur5ke"
zone_id        = "ru-central1-a"
subnet_id      = "e9bb7i0cq9fq74quevv6"
image_id       = "fd8ccfejmpaipf677j5c"
ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJzhpPIdMXfUzNm/zcQfJUfWPH4/u29gynFWK5ELbBVa d.i.saygin@yandex.ru"

labels = {
  env  = "dev"
  role = "development"
}
