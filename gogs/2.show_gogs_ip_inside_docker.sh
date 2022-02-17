#!/usr/bin/env bash
# Paulo Aleixo Campos
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
function shw_info { echo -e '\033[1;34m'"$1"'\033[0m'; }
function error { echo "ERROR in ${1}"; exit 99; }
trap 'error $LINENO' ERR
PS4='████████████████████████${BASH_SOURCE}@${FUNCNAME[0]:-}[${LINENO}]>  '
set -o errexit
set -o pipefail
set -o nounset
#set -o xtrace


GOGS_IP_InsideDockerNet=$("${__dir}"/1.gogs_ip_inside_docker.sh)
  # 172.26.0.5

cat <<EOT

GOGS_IP_InsideDockerNet=$GOGS_IP_InsideDockerNet

From docker-host, better connect via host-ip:
   http://172.17.0.1:10880
   git clone ssh://git@172.17.0.1:10022/username/myrepo.git

From inside kind (control-node or pods), connect via direct-docker-container-ip:<container-port>  (not docker-host ip/ports):
   http://${GOGS_IP_InsideDockerNet}:3000
   git clone ssh://git@${GOGS_IP_InsideDockerNet}/username/myrepo.git

EOT
