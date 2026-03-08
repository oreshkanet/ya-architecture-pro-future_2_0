# Задание 2. Интеграция с CI/CD и удалённым хранением состояния

## 1. Подготовка облака

Создан сервисный пользователь svc-devops с правами управления ресурсами:

![cloud_1](./asset/cloud_1.png)

Статические ключи для доступа к S3: 

![cloud_2](./asset/cloud_2.png)

Бакет в S3:

![cloud_3](./asset/cloud_3.png)

---

## 2. Структура

```
Task2Advanced/
├── modules/
│   └── vm/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── envs/
    ├── dev/
    │   ├── backend.tf
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │   └── dev.tfvars
    ├── stage/
    │   └── ...
    └── prod/
        └── ...
```

---

## 3. Backend: S3 удалённое хранение

В каждом окружении есть `backend.tf`:

```hcl
terraform {
  backend "s3" {}
}
```

Все параметры backend’а подаются при `terraform init` через `-backend-config=...`, чтобы:

- **не хранить секреты** (access_key/secret_key) в репозитории;
- легко переключать MinIO/Yandex Object Storage/AWS S3.

---

## 4. Аутентификация Yandex Cloud

Для провайдера `yandex-cloud/yandex` нужен IAM-токен (или key-файл сервисного аккаунта). Самый простой вариант — токен:

```bash
export YC_TOKEN="$(yc iam create-token)"
```

Используется сервисный аккаунт:

```bash
export YC_TOKEN="$(yc iam create-token --impersonate-service-account-id aje5ipm4g7ue455enpnc)"
```

---

## 5. CI/CD (GitHub Actions)

Workflow: `.github/workflows/task2-terraform.yml`

### Что делает pipeline

- **На PR и push** (изменения в `Task2Advanced/**`):
  - `terraform init` (S3 backend, параметры из секретов)
  - `terraform validate`
  - `terraform plan` для `dev`, `stage`, `prod`
- **Apply**:
  - запускается **вручную** через `workflow_dispatch`
  - параметр `environment` выбирается из `dev|stage|prod`
  - state ключ: `task2/<env>/terraform.tfstate`


### 5.1. Секреты/переменные, которые нужны в репозитории

В GitHub Secrets нужно добавить:

- `YC_TOKEN` — IAM token для Yandex Cloud
- `TF_STATE_BUCKET` — bucket для state
- `TF_STATE_REGION` — регион (для MinIO может быть любым, например `ru-central1`)
- `TF_STATE_ENDPOINT` — endpoint S3 (например `https://storage.yandexcloud.net` или `http://minio:9000`)
- `TF_STATE_ACCESS_KEY` — access key
- `TF_STATE_SECRET_KEY` — secret key

![github_1](./asset/github_1.png)

### 5.2. Workflow для plan

![actions_1](./asset/actions_1.png)

![actions_2](./asset/actions_2.png)

### 5.3. Workflow для apply

![workflow_1](./asset/workflow_1.png)

![workflow_2](./asset/workflow_2.png)

![workflow_3](./asset/workflow_3.png)

![workflow_4](./asset/workflow_4.png)

![workflow_5](./asset/workflow_5.png)

> https://github.com/oreshkanet/ya-architecture-pro-future_2_0/actions/runs/22771691033

---