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
shopt -s inherit_errexit
set -o xtrace

main() {
  # flux bootstrap with gitrepo fleet-infra
  GOGS_IP_INSIDE_DOCKER="$(${__dir}/gogs/1.gogs_ip_inside_docker.sh)"
  cd "${__dir}"
  shw_info "Answer [y] in next command, to allow write-access to gitrepo with the supplied priv-key"
  flux bootstrap git \
    --url=ssh://git@${GOGS_IP_INSIDE_DOCKER}/user1/fleet-infra.git \
    --branch=master \
    --path=clusters/my-cluster \
    --private-key-file=git-repos/user1.ssh.config/id_ed25519 --password='' 

  flux reconcile source git flux-system

  flux check
  shw_info ">> Completed successfully"
}
main "${@}"
