# Scope and assumptions

## Fictional business context
FinServ Digital is a fictional fintech with 2.4 million active users, 180,000 daily transactions, 20 microservices, and potential 5x traffic spikes.

## Project objectives
- Build repeatable cloud infrastructure with Terraform.
- Deploy containerized workloads to Kubernetes.
- Apply namespace isolation, least-privilege RBAC, and network policies.
- Integrate secrets management, runtime detection, CI/CD security, and observability.
- Document security controls and map them to relevant PCI DSS and RBI considerations.

## Assumptions and guardrails
- Use synthetic data only.
- No real cardholder data or CVV is permitted in this learning environment.
- Daily transaction average is not a reliable peak-capacity target; load testing and measured peak rates are required.
- Compliance applicability and scope must be determined by qualified compliance/legal stakeholders.
- This project does not certify PCI DSS or RBI compliance.
- All cloud resources are subject to charges. Review pricing, budgets, and cleanup steps before deployment.
