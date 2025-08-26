
#!/usr/bin/env bash
set -euo pipefail

echo "[+] Installing metrics-server (manifests)"
# Oficial: https://github.com/kubernetes-sigs/metrics-server
# Em ambientes locais, é comum precisar ignorar verificação TLS do kubelet.
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

echo "[+] Patching deployment to allow insecure TLS (local clusters)"
kubectl -n kube-system patch deploy metrics-server --type='json' -p='[
  {"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"},
  {"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname"}
]'

echo "[+] Waiting for metrics-server rollout..."
kubectl -n kube-system rollout status deploy/metrics-server
