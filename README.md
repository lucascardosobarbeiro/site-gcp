# 🌐 Site Estático na GCP com Deploy Automático

Este projeto configura e automatiza o deploy de um site estático hospedado no **Google Cloud Storage**, utilizando **GitHub Actions** e **Terraform**.

---

## 🚀 Tecnologias Utilizadas

- **Google Cloud Platform (GCP)**
- **Terraform** (Infraestrutura como Código)
- **Google Cloud Storage** (Site estático)
- **Google Monitoring** (Uptime Check + Alert)
- **GitHub Actions** (CI/CD)

---

## 🛠️ Estrutura do Projeto

. ├── infra/ # Infraestrutura com Terraform │ ├── main.tf │ ├── monitoring.tf │ └── variables.tf ├── site/ # Conteúdo do site estático │ └── index.html └── .github/ └── workflows/ └── deploy.yml # Pipeline de deploy automático



---

## ⚙️ O Que Já Está Implementado

### ✅ Infraestrutura com Terraform
- Criação de bucket GCS com site estático
- Ativação de APIs (storage, monitoring)
- Criação de Uptime Check e alerta via Cloud Monitoring

### ✅ Deploy Automático com GitHub Actions
- A cada push na branch `main`, o conteúdo da pasta `site/` é enviado ao bucket GCS.
- Autenticação via Service Account (`GCLOUD_CREDENTIALS` salvo em Secrets)

---

## 🚧 Como Rodar Localmente

1. Crie o arquivo de credenciais JSON da Service Account
2. Configure as variáveis e rode:
```bash
cd infra
terraform init
terraform apply
