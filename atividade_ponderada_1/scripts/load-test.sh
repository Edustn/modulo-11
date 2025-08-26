#!/usr/bin/env bash
set -euo pipefail

# ============================
# Load test com "hey" via Docker
# - DURAÇÃO e CONCORRÊNCIA configuráveis por env:
#     DURATION=2m CONCURRENCY=100 ./scripts/load-test.sh
# - URL padrão aponta para a porta do LB do k3d (8080).
# ============================

URL="${URL:-http://localhost:8080/}"
DURATION="${DURATION:-2m}"
CONCURRENCY="${CONCURRENCY:-100}"

OS="$(uname -s)"

echo "[+] Generating load with hey: ${URL} for ${DURATION} with -c ${CONCURRENCY}"

if [[ "$OS" == "Linux" ]]; then
  # Em Linux, --network host permite atingir localhost do host
  docker run --rm --network host williamyeh/hey -z "${DURATION}" -c "${CONCURRENCY}" "${URL}"
else
  # Em macOS/Windows, --network host não funciona no Docker Desktop.
  # Se o seu cluster mapeia a porta do LB para o host (8080), acessar localhost funciona.
  # Caso contrário, use host.docker.internal (ex.: http://host.docker.internal:8080/)
  docker run --rm williamyeh/hey -z "${DURATION}" -c "${CONCURRENCY}" "${URL}"
fi

echo "[i] Acompanhe o HPA em outro terminal:"
echo "    watch -n 5 kubectl -n autoscale-demo get hpa,pods"