# 🚀 Fully Automated Infrastructure & Configuration Deployment  
### Terraform Modules + Ansible Roles + Jenkins + AWS SSM

Production-grade **Infrastructure as Code (IaC)** and **Configuration Management** project demonstrating **secure, SSH-less automation** using **AWS Systems Manager (SSM)**, **Terraform modules**, **Ansible roles**, and **Jenkins pipelines**.

**From Git commit → provisioned infrastructure → configured servers (NO SSH)**

---

## 👀 Recruiter Summary (30-Second Read)

✔ Modular Terraform infrastructure provisioning  
✔ Role-based Ansible configuration management  
✔ Jenkins-driven automation pipeline  
✔ Secure access via AWS Systems Manager (SSM)  
✔ Zero SSH keys, zero manual server access  
✔ Fully reproducible, production-ready setup  

This project reflects **how modern DevOps teams automate infrastructure securely**.

---

## 🧑‍💻 What I Built

A **fully automated DevOps pipeline** that:

- Provisions AWS infrastructure using **Terraform modules**
- Configures servers using **Ansible roles**
- Uses **AWS SSM instead of SSH** for access and command execution
- Orchestrates everything via **Jenkins CI/CD**
- Eliminates manual intervention completely

---

## 🔄 Automation Flow (Actual Implementation)

```text
GitHub Commit
   ↓
Jenkins Pipeline
   ├─ Terraform Init
   ├─ Terraform Plan
   ├─ Terraform Apply (Provision Infrastructure)
   ├─ Register EC2 with AWS SSM
   ├─ Ansible Configuration via SSM
   │    ├─ Install Packages
   │    ├─ Configure Services
   │    ├─ Apply Security Hardening
   │    └─ Validate Configuration
   └─ Deployment Complete (No SSH Used)
```

## 🏗️ Infrastructure as Code (Terraform)
## Terraform Highlights

Modular Terraform design
Reusable & environment-agnostic modules
State management with best practices
Clear separation of concerns
Example Resources Provisioned
EC2 Instances
IAM Roles for SSM
Security Groups
VPC (Virtual Private Cloud)
S3 Bucket

## ⚙️ Configuration Management (Ansible)
## Ansible Highlights

Role-based folder structure
Idempotent playbooks
Environment-agnostic configurations
Executed securely via AWS SSM
Example Roles
Common system setup
Docker installation
Application dependencies
Nginx configuration

## 🔐 Secure Access with AWS SSM (No SSH)

✔ No SSH keys stored or shared
✔ No open port 22
✔ IAM-based access control
✔ Fully auditable session logs

This setup follows cloud security best practices used in production.

## 🛠️ Tech Stack (ATS-Optimized)
DevOps & Cloud
Terraform (Modules)
Ansible (Roles)
Jenkins (CI/CD Pipeline)
AWS EC2
VPC
S3 Bucket
AWS Systems Manager (SSM)
IAM
Linux
Git & GitHub


## 📈 Why This Project Stands Out

❌ No SSH access
❌ No manual provisioning
❌ No single-file Terraform
❌ No ad-hoc Ansible scripts

✅ Modular Terraform
✅ Role-based Ansible
✅ Secure SSM access
✅ Enterprise CI/CD automation

This is how real DevOps teams build infrastructure.

## 🧠 Key Learnings

Designing reusable Terraform modules
Implementing Ansible roles at scale
Secure infrastructure access using AWS SSM
Jenkins pipeline orchestration for IaC
IAM-based security & least privilege
Eliminating manual ops with automation

## 👤 Author

Sahil Mahesh Saykar
DevOps Engineer

GitHub: https://github.com/sahilll24

LinkedIn: https://www.linkedin.com/in/sahil-saykar-9a11a3264/

## 💬 Recruiter Note
This repository demonstrates secure, scalable, and production-ready DevOps automation, not basic scripting.