name           = "vm-stage"
cores          = 4
ram            = 4
disk_size      = 50
disk_type      = "network-ssd"
nat            = true

folder_id      = "b1gnrv39fgcls3phb000"
zone_id        = "ru-central1-a"
subnet_id      = "e9b7l3l1o5fvt9bo1lgb"
image_id       = "fd8ccfejmpaipf677j5c"
ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJzhpPIdMXfUzNm/zcQfJUfWPH4/u29gynFWK5ELbBVa d.i.saygin@yandex.ru"

labels = {
  env  = "stage"
  role = "staging"
}
