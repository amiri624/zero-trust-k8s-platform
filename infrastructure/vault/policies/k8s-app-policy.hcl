path "secret/data/apps/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
HCL

13.2 init script (dev): infrastructure/vault/init-scripts/init-vault.sh

mkdir -p infrastructure/vault/init-scripts
cat > infrastructure/vault/init-scripts/init-vault.sh <<'SH'
#!/usr/bin/env bash
set -euo pipefail
echo "DEV helper: initialize Vault (manual steps required in prod)."
echo "This script is a placeholder. Use Vault docs for secure init/unseal."
# Example (commented):
# vault operator init -key-shares=1 -key-threshold=1 -format=json > /tmp/vault-init.json
# vault operator unseal $(jq -r '.unseal_keys_b64[0]' /tmp/vault-init.json)
# vault login $(jq -r '.root_token' /tmp/vault-init.json)
# vault policy write k8s-app infrastructure/vault/policies/k8s-app-policy.hcl
SH
chmod +x infrastructure/vault/init-scripts/init-vault.sh

13.3 K8s side: example ServiceAccount + annotation for Vault Agent Injector
