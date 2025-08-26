
#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="k3d-nginx-hpa"

echo "[+] Creating K3d cluster: ${CLUSTER_NAME}"
k3d cluster create "${CLUSTER_NAME}"   --agents 2   --servers 1   --api-port 6550   -p "8080:80@loadbalancer"   --k3s-arg "--disable=traefik@server:*"

echo "[+] Using context:"
kubectl config use-context "k3d-${CLUSTER_NAME}"

echo "[+] Cluster nodes:"
kubectl get nodes -o wide
