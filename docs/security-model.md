#
# 🔐 Zero-Trust Security Model

This platform implements a full Zero-Trust Architecture (ZTA) for Kubernetes workloads.

Zero Trust Principles Applied:
- Never trust, always verify
- Identity-based authentication
- Policy-driven authorization
- Least privilege at all layers
- Continuous verification
- Runtime observability and anomaly detection

---

## 1. Identity & Secrets (Vault)
- Kubernetes Auth Method (JWT)
- Dynamic secrets with short TTL
- Automatic renewal via Vault Agent Injector
- Separate policies per namespace
- PKI engine for service certificates

Benefits:
- No hardcoded secrets  
- No long-lived tokens  
- Full audit log  

---
