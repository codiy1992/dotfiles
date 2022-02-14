#!/bin/bash

REPO_DOMAIN=github.com
REPO_NAME=codiy1992/dotfiles
REPOSITORY=${HOME}/.dotfiles
BACKUP_DIR=${HOME}/.dotfiles-backup

cd ${HOME}

if [ ! -d ${REPOSITORY} ] || [ "$(ls -A ${REPOSITORY})" = "" ]; then
    # Clone Repository
    git clone --bare https://${REPO_DOMAIN}/${REPO_NAME}.git ${REPOSITORY}
    # Backup old files
    mkdir -p ${BACKUP_DIR}
    git --git-dir=${REPOSITORY} --work-tree=${HOME} checkout 2>&1 \
        | egrep '^[[:space:]]+.*' \
        | awk '{print $1}' \
        | xargs -I{} dirname {} \
        | xargs -I{} mkdir -p ${BACKUP_DIR}/{}
    git --git-dir=${REPOSITORY} --work-tree=${HOME} checkout 2>&1 \
        | egrep '^[[:space:]]+.*' \
        | awk '{print $1}' \
        | xargs -I{} mv {} ${BACKUP_DIR}/{}
    # Checkout Repository to your ${HOME}
    git --git-dir=${REPOSITORY} --work-tree=${HOME} checkout
    # Replace config
    if [ "$(uname)" = "Darwin" ]; then
        sed -i '' "s/^\turl = http.*/\turl = git@${REPO_DOMAIN}:${REPO_NAME//\//\\\/}.git/" ${REPOSITORY}/config
    else
        sed -i "s/^\turl = http.*/\turl = git@${REPO_DOMAIN}:${REPO_NAME//\//\\\/}.git/" ${REPOSITORY}/config
    fi
fi

echo -e "\033[49;32mSuccessfully!
The \033[49;34mconflict dotfiles \033[49;32mhas been moved to \033[49;34m~/.dotfiles-backup\033[0m\033[49;32m.

Now you need to add aliases showed below and \033[49;34msource your .zshrc or .bashrc file \033[49;32mmanually
\033[49;34m
alias got='git --git-dir=\${HOME}/.dotfiles --work-tree=${HOME}'
alias got.encrypt='\${HOME}/secrets/encrypt'
alias got.decrypt='\${HOME}/secrets/decrypt'
\033[49;32m
and then you can use \033[49;34m\`got\`\033[49;32m command to manage your dotfiles.\033[0m"
