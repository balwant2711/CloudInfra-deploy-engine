# 💠 CloudInfra Deploy Engine  
### Terraform + AWS Automation Console | Flask Web UI | DevOps Infrastructure Provisioning

[![Terraform](https://img.shields.io/badge/IaC-Terraform-844FBA?logo=terraform&logoColor=white)]()
[![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazonaws&logoColor=white)]()
[![Flask](https://img.shields.io/badge/Backend-Flask-black?logo=flask&logoColor=white)]()
[![Python](https://img.shields.io/badge/Language-Python-3776AB?logo=python&logoColor=white)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)]()

---

## 🚀 Overview

**CloudInfra Deploy Engine** is a DevOps-friendly automation platform that provides a **browser-based dashboard** for provisioning, validating, and managing cloud infrastructure on AWS using **Terraform**.

Instead of running commands like:

```

terraform init → validate → plan → apply → destroy

```

You get a **beautiful, interactive Flask UI** that handles everything for you — with validation, import/export, NS resolution, animated deployment flow, and environment insights.

This project demonstrates:

- Infrastructure-as-Code (IaC)
- AWS provisioning automation
- Cloud orchestration
- UI-driven DevOps workflow
- Secure secret handling
- Real-time Terraform output visualization
- Route53 DNS deployment flow
- Validation of all config parameters

Perfect for DevOps, Cloud, and SRE portfolios.

---

## ✨ Features

### 🔧 **Run Terraform directly from the browser**
- `terraform init`
- `terraform validate`
- `terraform plan`
- `terraform apply`
- `terraform destroy`

All actions run locally through Flask → Terraform CLI.

---

### 🌐 **AWS Infrastructure Provisioned Automatically**
| AWS Service | Purpose |
|------------|----------|
| **EC2** | Deploy GitHub-hosted website / app |
| **Route 53** | Creates hosted zone + resolves NS records |
| **Security Groups** | SSH + HTTP access |
| **User Data** | Auto-deploys project code on EC2 |
| **Optional S3** | Static asset hosting or future expansion |

---

### 🖥️ **Modern UI (Dark/Light themes)**
- Clean, professional DevOps dashboard  
- Deployment flow animation  
- Dark/light toggle  
- Dynamic terraform output console  
- Clear label colors, icons, and visual indicators  
- Fully responsive for laptops/desktops  

---

### 📁 **Import / Export Configuration**
- Download ready-made `terraform.tfvars` template  
- Upload `.tfvars`, `.json`, or `.tfvars.json`  
- Auto-populates all AWS and project fields  
- Validation for domain, GitHub URL, access keys, etc.

---

### 🔍 **Route 53 NS Resolution**
After apply, UI automatically fetches:

- Name servers  
- Displays them in copy-friendly format  
- Helps attach domain instantly  

---

## 🖼️ UI Screenshots (Add your images)

```

screenshots/ui-main.png
screenshots/config-panel.png
screenshots/terraform-output.png

```

> Replace these placeholders with your screenshots.

---

## 📂 Project Structure

```

CloudInfra-Deploy-Engine/
│
├── app.py                     # Flask backend & Terraform executor
├── requirements.txt
│
├── terraform/                 # IaC configuration
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── provider.tf
│   └── (no terraform.tfvars committed)
│
├── templates/
│   └── index.html             # Complete UI (dark/light + animations)
│
├── static/                    # Optional CSS/JS (future expansion)
│
├── screenshots/               # Add images for README
│
└── README.md

````

---

## ⚙️ Installation & Setup

### 1️⃣ Clone the repository
```bash
git clone https://github.com/YOUR_USERNAME/CloudInfra-Deploy-Engine.git
cd CloudInfra-Deploy-Engine
````

### 2️⃣ Create virtual environment

```bash
python -m venv venv
venv\Scripts\activate         # Windows
source venv/bin/activate      # Linux / macOS
```

### 3️⃣ Install requirements

```bash
pip install -r requirements.txt
```

### 4️⃣ Install Terraform

Download: [https://developer.hashicorp.com/terraform/downloads](https://developer.hashicorp.com/terraform/downloads)

### 5️⃣ Configure AWS CLI (recommended)

```bash
aws configure
```

### 6️⃣ Run the Flask app

```bash
python app.py
```

UI opens:
👉 [http://127.0.0.1:5000/](http://127.0.0.1:5000/)

---

## 🚀 Deployment Workflow (Demo Script)

1. Fill all required fields
2. Or upload pre-filled `terraform.tfvars`
3. Click:

   * **init**
   * **validate**
   * **plan**
   * **apply**
4. Wait for resources to be created
5. UI shows Route53 Name Servers
6. Add NS to domain registrar (GoDaddy / Namecheap)
7. Website goes live on EC2

---

## 🛡 Security Best Practices

* Never commit:

  * `terraform.tfvars`
  * `.tfstate`
  * AWS keys
* Use:

  ```
  .gitignore
  terraform.tfvars
  *.tfstate
  *.tfstate.backup
  .terraform/
  venv/
  __pycache__/
  ```
* Always use IAM least-privilege policies
* Use CLI credentials for safer handling

---

## 🧪 Optional GitHub Actions CI (Format + Validate Only)

```yaml
name: Terraform CI

on: [push, pull_request]

jobs:
  terraform:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2

      - name: Terraform fmt
        run: terraform fmt -check -recursive
        working-directory: ./terraform

      - name: Terraform init
        run: terraform init -input=false
        working-directory: ./terraform

      - name: Terraform validate
        run: terraform validate
        working-directory: ./terraform
```

> **Never run `terraform apply` in GitHub Actions unless you're intentionally deploying from CI/CD.**

---

## 🏗 Future Enhancement Plan (for Major Project)

Perfect expansion path for next semester:

* Auto Scaling Group (ASG)
* Elastic Load Balancer (ALB)
* CI/CD (GitHub Actions → Terraform apply)
* Docker + Kubernetes (EKS)
* AWS CloudFront CDN
* CloudWatch Observability
* WAF + AWS Shield
* RDS / DynamoDB backend
* VPC with subnets, NAT, gateways
* Infrastructure diagram generation

---

## 👨‍💻 Author

**Balwant Singh**
Cloud & DevOps Engineer 
GitHub: [https://github.com/YOUR_USERNAME](https://github.com/balwant2711)

LinkedIn: [https://linkedin.com/in/YOUR_USERNAME](https://linkedin.com/in/balwant-singh-aa024b37b/)

---

## 📜 License

Distributed under MIT License.

---

## ⭐ If you like this project, give it a star on GitHub!

```

