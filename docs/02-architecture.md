# Reference architecture

## Logical flow
Developer -> GitHub -> CI pipeline -> tests and security scans -> container registry -> Kubernetes deployment.

## Platform capabilities
- AWS networking and managed Kubernetes (planned)
- Four workload namespaces: payments-cde, ledger, identity, customer
- Default-deny network policies with explicit allow rules added after traffic requirements are known
- Least-privilege Kubernetes RBAC
- Vault-based secrets management (planned)
- Falco runtime threat detection (planned)
- Prometheus, Grafana, and Alertmanager (planned)
- HPA and node autoscaling (planned)

## Security note
Namespaces are organizational boundaries, not a sufficient PCI CDE segmentation control by themselves. Design and validate network, identity, workload, and data-flow boundaries separately.
