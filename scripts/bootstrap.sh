#
#!/usr/bin/env bash

set -e

COMPONENT=$1

if [ -z "$COMPONENT" ]; then
  echo "Usage: ./bootstrap.sh <istio|monitoring|opa|falco|argocd>"
  exit 1
fi

echo "=== Zero-Trust Bootstrap: $COMPONENT ==="

case $COMPONENT in

  istio)
    echo "[+] Installing Istio Service Mesh..."
    istioctl install --set profile=demo -y
    kubectl label namespace default istio-injection=enabled --overwrite
  ;;

  monitoring)
    echo "[+] Installing Prometheus Operator + Loki + Tempo..."
    kubectl apply -f k8s/monitoring/prometheus/
    kubectl apply -f k8s/monitoring/loki/
    kubectl apply -f k8s/monitoring/tempo/
    kubectl apply -f k8s/monitoring/grafana/
  ;;

  opa)
    echo "[+] Installing OPA Gatekeeper..."
    kubectl apply -f k8s/opa/system/
    kubectl apply -f k8s/opa/templates/
    kubectl apply -f k8s/opa/constraints/
  ;;

  falco)
    echo "[+] Installing Falco Runtime Security..."
    helm repo add falcosecurity https://falcosecurity.github.io/charts
    helm upgrade --install falco falcosecurity/falco -n falco --create-namespace
  ;;

  argocd)
    echo "[+] Installing ArgoCD..."
    kubectl apply -n argocd -f gitops/argocd-install.yaml
  ;;

  *)
    echo "Unknown component: $COMPONENT"
    exit 2
  ;;
esac

echo "✔️ Done."
