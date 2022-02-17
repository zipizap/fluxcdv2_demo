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
  GOGS_IP_INSIDE_DOCKER="$(${__dir}/gogs/1.gogs_ip_inside_docker.sh)"

  
  # Clone git-repo fleet-infra, to easily navigate review its files
  cd "${__dir}"/git-repos
  if [[ ! -d fleet-infra ]]
  then 
    mkdir -p fleet-infra
    # assure the ssh-server-hostkeys are known (to avoid host-key errors on git-clone and flux-bootstrap-git)
    shw_info "Answer yes in next command, to assure ssh-server-host-key is known (will be implicitly used latter during flux-bootstrap)"
    ssh git@${GOGS_IP_INSIDE_DOCKER} || true
    GIT_SSH_COMMAND="ssh -F $PWD/user1.ssh.config/config" git clone ssh://git@${GOGS_IP_INSIDE_DOCKER}/user1/fleet-infra.git
    cd fleet-infra
    git config core.sshCommand "ssh -F $PWD/../user1.ssh.config/config" || true
    cd ..
  else
    cd fleet-infra
    git pull
    cd ..
  fi

  shw_info ">> Completed successfully"
}
main "${@}"
