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
GOGS_DOMAIN=gogs.docker

cat <<EOT

GOGS_IP_InsideDockerNet=$GOGS_IP_InsideDockerNet
GOGS_DOMAIN=$GOGS_DOMAIN

In docker-host add to /etc/hosts the entry:
$GOGS_IP_InsideDockerNet $GOGS_DOMAIN

From inside kind (control-node or pods), connect via direct-docker-container-ip:<container-port>
   http://${GOGS_DOMAIN}:3000
   git clone ssh://git@${GOGS_DOMAIN}/username/myrepo.git

EOT

# NOTE: possible but not recommended:
#   From docker-host, connect via host-ip:
#      http://172.17.0.1:10880
#      git clone ssh://git@172.17.0.1:10022/username/myrepo.git
