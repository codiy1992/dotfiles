#!/bin/bash

BARES_DIR=${HOME}/Bares
REPOSITORY=${BARES_DIR}/dotfiles.git
if [ ! -d ${REPOSITORY} ] || [ "`ls -A ${REPOSITORY}`" = "" ]; then
    # Clone Repository
    mkdir -p ${BARES_DIR}
    git clone --bare https://github.com/codiy1992/dotfiles.git ${REPOSITORY}
    # Backup dotfiles
    cd ${HOME}
    mkdir -p ${HOME}/dotfiles-backup
    git --git-dir=${REPOSITORY} --work-tree=${HOME} checkout 2>&1 |egrep "\s+\." | awk {'print $1'} | xargs -I{} dirname {} | xargs -I{} mkdir -p ${HOME}/dotfiles-backup/{}
    git --git-dir=${REPOSITORY} --work-tree=${HOME} checkout 2>&1 |egrep "\s+(\.|README\.md)" | awk {'print $1'} | xargs -I{} mv {} ${HOME}/dotfiles-backup/{}
    # Checkout Repository to your ${HOME}
    git --git-dir=${REPOSITORY} --work-tree=${HOME} checkout
fi

echo -e "\033[49;32mSuccessfully!
Your \033[49;34mold dotfiles \033[49;32mhas been moved to \033[49;34m~/dotfiles-backup\033[0m\033[49;32m.
Now you need to run \033[49;34m\`source .zshrc\` \033[49;32mmanually \\
and then you can use \033[49;34m\`dotf\`\033[49;32m command to manage your dotfiles.\033[0m"
