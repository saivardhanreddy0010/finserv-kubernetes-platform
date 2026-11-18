# FinServ Digital - Secure Kubernetes Platform

A secure Kubernetes platform reference implementation for a fictional fintech company, built using AWS EKS, Terraform, Kubernetes, Docker, GitHub Actions and DevSecOps tools.

The project demonstrates infrastructure automation, container orchestration, network security, secrets management, runtime security, monitoring, autoscaling and secure CI/CD practices.

> **Project status:** Core infrastructure, security controls, CI/CD and sample application deployment implemented. Final documentation and validation in progress.

---

## 1. Project Overview

FinServ Digital is a fictional financial technology platform designed around the following reference requirements:

- 2.4 million registered users.
- 180,000 transactions per day.
- 20 planned microservices.
- 5x peak traffic design objective.
- Security controls inspired by regulated financial environments.

This project demonstrates how a secure Kubernetes platform can be designed and operated on AWS.

**Important:** This is a learning/reference implementation, not a production deployment or PCI DSS/RBI compliance certification. Use synthetic data only.

## 2. Technology Stack

| Category | Technologies |
|---|---|
| Cloud | AWS |
| Infrastructure as Code | Terraform |
| Container Orchestration | Kubernetes, AWS EKS |
| Containerization | Docker |
| Container Registry | Amazon ECR |
| CI/CD | GitHub Actions |
| Authentication | AWS IAM, GitHub OIDC |
| Image Security | Trivy, Cosign |
| Secrets Management | HashiCorp Vault |
| Runtime Security | Falco |
| Monitoring | Prometheus |
| Autoscaling | HPA, Cluster Autoscaler |
| Package Management | Helm |
| Scripting | Python, PowerShell |
| Version Control | Git, GitHub |

## 3. Architecture

```text
                  Developer
                      |
                      v
                 GitHub Repo
                      |
                      v
               GitHub Actions
                      |
             +--------+--------+
             |                 |
             v                 v
        Docker Build       Trivy Scan
             |
             v
          Amazon ECR
             |
        Cosign Signing
             |
        Signature Verify
             |
             v
          AWS EKS
             |
     +-------+--------+
     |                |
     v                v
 Worker Node 1    Worker Node 2
     |                |
     +--------+-------+
              |
       Customer API
        (2 replicas)
              |
       Kubernetes Service
              |
       Internal ClusterIP

 Security and Operations:
 - Kubernetes RBAC
 - NetworkPolicies
 - Pod Security Standards
 - HashiCorp Vault
 - Falco
 - Prometheus
 - HPA
 - Cluster Autoscaler
```

## 4. AWS Infrastructure

The Kubernetes platform runs on Amazon EKS in the AWS Mumbai region (`ap-south-1`).

Implemented infrastructure includes:

- Amazon EKS cluster.
- Managed worker node group.
- VPC and subnet architecture.
- IAM roles and policies.
- EKS OIDC identity provider.
- Cluster Autoscaler IAM integration.
- GitHub Actions OIDC integration.
- Amazon ECR repository.

## 5. Kubernetes Security

### Namespace Isolation

Four application namespaces:

- `payments-cde`
- `ledger`
- `identity`
- `customer`

Pod Security Admission labels enforce the Restricted security profile.

### NetworkPolicies

Implemented:

- Default-deny ingress.
- Default-deny egress.
- DNS access rules.
- Vault access rules.

Verified:
- DNS resolution succeeds.
- Vault access on TCP 8200 succeeds.
- External egress is restricted.
- Cross-namespace access to the Customer API is restricted.

### RBAC

Implemented namespace-scoped read-only access for the customer developer role.

Permissions are limited to selected Kubernetes resources.

Secret access and destructive operations are not granted.

### Container Security

The Customer API deployment uses:

- Non-root container execution.
- Read-only root filesystem.
- RuntimeDefault seccomp profile.
- Privilege escalation disabled.
- All Linux capabilities dropped.
- CPU and memory requests and limits.
- Startup, readiness and liveness probes.

## 6. Secrets Management â€“ HashiCorp Vault

Vault is deployed in a dedicated namespace.

Implemented:

- KV v2 secrets engine.
- Kubernetes authentication.
- ServiceAccount-based authentication.
- Namespace-bound Vault role.
- Read-only access policy.
- Secret retrieval testing.

**Learning environment limitation:** The current Vault configuration uses development/in-memory storage and is not production-ready.

Production deployment requires persistent HA storage, TLS, audit logging, backup and appropriate auto-unseal configuration.

## 7. Runtime Security â€“ Falco

Falco is deployed to monitor Kubernetes runtime activity.

Implemented:
- Falco installation.
- eBPF-based runtime monitoring.
- Resource configuration.
- Runtime event testing.

A test shell activity was detected by Falco.

## 8. Monitoring â€“ Prometheus

Prometheus is deployed in the monitoring namespace.

Monitoring includes:
- Kubernetes API servers.
- Worker nodes.
- Container metrics.
- Node Exporter.
- kube-state-metrics.

Configured alert rules:

1. HighNodeCPUUsage.
2. HighNodeMemoryUsage.
3. ExcessivePodRestarts.

The alert rules were loaded and verified in Prometheus.

**Limitation:** Alertmanager notifications and persistent Prometheus storage are not configured.

## 9. Autoscaling

### Horizontal Pod Autoscaler

Implemented CPU-based HPA testing.

- Minimum replicas: 2.
- Maximum replicas: 5.
- CPU utilization target: 70%.

Scale-up from 2 to 5 replicas was verified under CPU load.

Scale-down has not yet been fully verified.

### Cluster Autoscaler

Cluster Autoscaler is configured with an EKS managed node group.

- Minimum nodes: 2.
- Maximum nodes: 4.

Scale-up was verified by scheduling CPU-intensive test workloads.

Scale-down has not yet been verified.

## 10. Customer API Application

A sample Python Flask application demonstrates customer service deployment.

Endpoints:

| Endpoint | Description |
|---|---|
| `/` | Application information |
| `/health` | Health check |
| `/customers` | Synthetic customer records |

Application container image is stored in Amazon ECR.

Kubernetes deployment:
- Two replicas.
- ClusterIP service.
- Separate worker nodes.
- Resource limits.
- Security contexts.
- Health probes.

Application endpoints were successfully tested through Kubernetes port-forwarding.

## 11. CI/CD and DevSecOps

GitHub Actions automates the application image pipeline.

Pipeline stages:

1. Checkout source code.
2. Build Docker image.
3. Scan image using Trivy.
4. Authenticate to AWS using GitHub OIDC.
5. Push image to Amazon ECR.
6. Sign image using Cosign.
7. Verify image signature.

The GitHub Actions workflow completed successfully, including image signing and signature verification.

AWS credentials are not stored as long-lived GitHub repository secrets for this authentication flow.

**Note:** The current Trivy workflow reports HIGH and CRITICAL findings without failing the pipeline. A successful pipeline does not necessarily mean the image has zero vulnerabilities.

## 12. Validation Summary

| Component | Validation |
|---|---|
| EKS cluster | Successful |
| Worker nodes | Ready |
| Pod Security | Restricted enforcement |
| RBAC | Read-only permission testing |
| NetworkPolicies | DNS, Vault and ingress/egress testing |
| Vault | Kubernetes authentication and secret retrieval |
| Falco | Runtime event detection |
| Prometheus | Targets and alert rules |
| HPA | Scale-up verified |
| Cluster Autoscaler | Scale-up verified |
| Docker | Application image built and tested |
| Trivy | Image scanning integrated |
| GitHub Actions | Successful pipeline |
| Cosign | Image signing and verification |
| Customer API | Two replicas running |
| Kubernetes Service | ClusterIP operational |

## 13. Repository Structure

```text
finserv-kubernetes-platform/
â”‚
â”œâ”€â”€ apps/
â”‚   â””â”€â”€ customer-api/
â”‚
â”œâ”€â”€ docs/
â”‚
â”œâ”€â”€ infrastructure/
â”‚   â””â”€â”€ terraform/
â”‚
â”œâ”€â”€ platform/
â”‚   â”œâ”€â”€ namespaces/
â”‚   â”œâ”€â”€ network-policies/
â”‚   â”œâ”€â”€ rbac/
â”‚   â”œâ”€â”€ vault/
â”‚   â”œâ”€â”€ monitoring/
â”‚   â”œâ”€â”€ autoscaling/
â”‚   â”œâ”€â”€ cluster-autoscaler/
â”‚   â”œâ”€â”€ customer-api/
â”‚   â””â”€â”€ ci-cd/
â”‚
â”œâ”€â”€ .github/
â”‚   â””â”€â”€ workflows/
â”‚       â””â”€â”€ ci-cd.yaml
â”‚
â”œâ”€â”€ .gitignore
â”œâ”€â”€ README.md
â””â”€â”€ terraform.tfvars.example
```

## 14. Important Limitations

This project is intended for learning and portfolio demonstration.

The following production capabilities are not fully implemented or validated:

- Production-grade highly available Vault.
- Persistent Prometheus storage.
- Alertmanager notification integration.
- Complete HPA and Cluster Autoscaler scale-down validation.
- Full production ingress and TLS configuration.
- Comprehensive application-level payment security.
- Formal PCI DSS/RBI compliance assessment.
- Production disaster recovery and backup validation.

Kubernetes namespaces alone do not establish PCI DSS network segmentation.

## 15. Cost Management

AWS resources may incur charges, including:

- EKS cluster.
- EC2 worker nodes.
- NAT Gateway.
- EBS volumes.
- Monitoring and logging services.

Review AWS billing and resource usage regularly.

Do not destroy infrastructure without reviewing Terraform state, dependencies and data-retention requirements.

## 16. Project Objective

The objective is to demonstrate practical junior DevOps and cloud engineering skills through a hands-on Kubernetes platform project.

Key learning areas:

- Infrastructure as Code.
- AWS cloud infrastructure.
- Kubernetes administration.
- Container security.
- CI/CD automation.
- DevSecOps practices.
- Secrets management.
- Monitoring and observability.
- Autoscaling and troubleshooting.

---

**Author:** Sai Vardhan
**Repository:** finserv-kubernetes-platform
