
#!/usr/bin/env bash
set -euo pipefail

# Você pode acessar via porta 8080 mapeada no load balancer do k3d (mais simples):
echo "[i] Abra: http://localhost:8080"

# Alternativamente, fazer port-forward direto do Service:
# kubectl -n autoscale-demo port-forward svc/nginx 8080:80

# (macOS) Como --network host do Docker não funciona, usar a porta 8080 acima é a forma mais simples de atingir o Service através do LB.
