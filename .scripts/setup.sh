#!/bin/bash

BARES_DIR=${HOME}/Bares
REPOSITORY=${BARES_DIR}/dotfiles.git
REPO_REMOTE=github.com/codiy1992/dotfiles.git
REPO_SSH=git@github.com:codiy1992/dotfiles.git

if [ ! -d ${REPOSITORY} ] || [ "`ls -A ${REPOSITORY}`" = "" ]; then
    # Clone Repository
    mkdir -p ${BARES_DIR}
    git clone --bare https://${REPO_REMOTE} ${REPOSITORY}
    # Backup dotfiles
    cd ${HOME}
    mkdir -p ${HOME}/dotfiles-backup
    git --git-dir=${REPOSITORY} --work-tree=${HOME} checkout 2>&1 |egrep "\s+\." | awk {'print $1'} | xargs -I{} dirname {} | xargs -I{} mkdir -p ${HOME}/dotfiles-backup/{}
    git --git-dir=${REPOSITORY} --work-tree=${HOME} checkout 2>&1 |egrep "\s+(\.|README\.md)" | awk {'print $1'} | xargs -I{} mv {} ${HOME}/dotfiles-backup/{}
    # Checkout Repository to your ${HOME}
    git --git-dir=${REPOSITORY} --work-tree=${HOME} checkout
    # Replace config
    REPO_SSH=${REPO_SSH//\//\\\/}
    CONFIG=`sed "s/^\turl = http.*/\turl = git@${REPO_REMOTE}/" ${REPOSITORY}/config`
    echo -e "${CONFIG}" > ${REPOSITORY}/config
fi

echo -e "\033[49;32mSuccessfully!
Your \033[49;34mold dotfiles \033[49;32mhas been moved to \033[49;34m~/dotfiles-backup\033[0m\033[49;32m.
Now you need to run \033[49;34m\`source .zshrc\` \033[49;32mmanually \\
and then you can use \033[49;34m\`got\`\033[49;32m command to manage your dotfiles.\033[0m"
