# Задание 2. Интеграция с CI/CD и удалённым хранением состояния

В этой директории лежит Terraform-код с **удалённым состоянием** в S3-compatible хранилище (MinIO / Yandex Object Storage / AWS S3) и пример CI/CD через **GitHub Actions**:

- `terraform init` (c S3 backend)
- `terraform plan`
- `terraform apply` — **только вручную** (workflow_dispatch) + можно включить approvals через GitHub Environments

## Структура

```
Task2Advanced/
├── modules/
│   └── vm/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── README.md
└── envs/
    ├── dev/
    │   ├── backend.tf
    │   ├── backend.hcl.example
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │   └── dev.tfvars
    ├── stage/
    │   └── ...
    └── prod/
        └── ...
```

## Backend: S3-compatible remote state

В каждом окружении есть `backend.tf`:

```hcl
terraform {
  backend "s3" {}
}
```

Все параметры backend’а подаются при `terraform init` через `-backend-config=...`, чтобы:

- **не хранить секреты** (access_key/secret_key) в репозитории;
- легко переключать MinIO/Yandex Object Storage/AWS S3.

### Локальный запуск (пример)

1) Экспортируйте ключи доступа к S3-хранилищу (MinIO / Object Storage):

```bash
export AWS_ACCESS_KEY_ID="***"
export AWS_SECRET_ACCESS_KEY="***"
```

2) Инициализируйте backend в выбранном окружении, используя пример `backend.hcl.example`:

```bash
cd envs/dev
cp backend.hcl.example backend.hcl

terraform init -backend-config=backend.hcl
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

Файл `backend.hcl` **не коммитьте** (оставьте локально); в репозитории хранится только `backend.hcl.example`.

## Аутентификация Yandex Cloud

Для провайдера `yandex-cloud/yandex` нужен IAM-токен (или key-файл сервисного аккаунта). Самый простой вариант — токен:

```bash
export YC_TOKEN="$(yc iam create-token)"
```

Если используете сервисный аккаунт:

```bash
export YC_TOKEN="$(yc iam create-token --impersonate-service-account-id aje5ipm4g7ue455enpnc)"
```

## CI/CD (GitHub Actions)

Workflow: `.github/workflows/task2-terraform.yml`

### Что делает pipeline

- **На PR и push** (изменения в `Task2Advanced/**`):
  - `terraform fmt -check`
  - `terraform init` (S3 backend, параметры из секретов)
  - `terraform validate`
  - `terraform plan` для `dev`, `stage`, `prod`
- **Apply**:
  - запускается **вручную** через `workflow_dispatch`
  - параметр `environment` выбирается из `dev|stage|prod`
  - state ключ: `task2/<env>/terraform.tfstate`

### Секреты/переменные, которые нужны в репозитории

Добавьте в GitHub Secrets:

- `YC_TOKEN` — IAM token для Yandex Cloud
- `TF_STATE_BUCKET` — bucket для state
- `TF_STATE_REGION` — регион (для MinIO может быть любым, например `ru-central1`)
- `TF_STATE_ENDPOINT` — endpoint S3 (например `https://storage.yandexcloud.net` или `http://minio:9000`)
- `TF_STATE_ACCESS_KEY` — access key
- `TF_STATE_SECRET_KEY` — secret key

### Approvals для apply (рекомендовано)

Workflow использует `environment: task2-<env>`. В GitHub можно создать environments:

- `task2-dev`
- `task2-stage`
- `task2-prod`

и включить для них **Required reviewers** — тогда `apply` будет выполняться только после подтверждения.

## Требования безопасности (что проверяет ревьюер)

- **State не хранится локально**: используется `backend "s3"` и `terraform init` с удалённым хранилищем.
- **Секреты не в коде**: ключи S3 и `YC_TOKEN` передаются через secrets/переменные окружения.
- **Изоляция окружений**: раздельные ключи state (`task2/dev|stage|prod/...`) и раздельные `.tfvars`.

