# FinServ Digital — Secure Kubernetes Platform

A learning/reference implementation of a hardened Kubernetes platform for a fictional fintech.

## Important
- This repository is a learning project, not a production deployment or compliance certification.
- Use synthetic data only. Never put real payment-card data, secrets, passwords, or private keys in Git.
- Kubernetes namespaces alone do not establish PCI DSS network segmentation.
- Review AWS pricing and your budget before creating cloud resources.

## Structure
- `docs/`: scope, architecture, and build log
- `infrastructure/terraform/`: Terraform starter for AWS infrastructure
- `platform/namespaces/`: Kubernetes namespace definitions
- `platform/network-policies/`: default-deny network policies

## First steps
1. Verify Git, AWS CLI, Terraform, kubectl, Helm, eksctl, and Docker are installed.
2. Review `docs/01-scope-and-assumptions.md`.
3. Do not run `terraform apply` until the plan and expected costs have been reviewed.
