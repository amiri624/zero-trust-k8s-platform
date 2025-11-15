#
#!/usr/bin/env bash

set -e

APP=$1

if [ -z "$APP" ]; then
  echo "Usage: ./deploy.sh <demo-app>"
  exit 1
fi

echo "=== Deploying Application: $APP ==="

APP_PATH="k8s/${APP}"

if [ ! -d "$APP_PATH" ]; then
  echo "Error: Application directory '$APP_PATH' not found."
  exit 2
fi

echo "[+] Applying manifests..."
kubectl apply -f "$APP_PATH"

echo "[+] Notifying ArgoCD..."
if command -v argocd &> /dev/null; then
  argocd app sync "$APP" || true
fi

echo "✔️ Application deployed successfully."
