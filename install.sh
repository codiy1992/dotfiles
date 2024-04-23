#!/bin/bash

export GPG_TTY=$(tty)

REPO_DOMAIN=github.com
REPO_NAME=codiy1992/dotfiles
REPOSITORY=${HOME}/.dotfiles
BACKUP_DIR=${HOME}/.dotfiles-backup

function err() { echo -e "\033[49;31m${1+Error: }$1\033[0m"; exit 1;}
function ok() { echo -e "\033[49;32m$1\033[0m";}
function info() { echo -e "\033[49;34m$1\033[0m";}
function warn() { echo -e "\033[49;31m$1\033[0m";}

find ~/.gnupg -type f -exec chmod 600 {} \; # Set 600 for files
find ~/.gnupg -type d -exec chmod 700 {} \; # Set 700 for directories

if [ ! -f ~/.gnupg/main.sec.key ]; then
    err "File ~/.gnupg/main.sec.key does not exist!"
fi

if [ ! -f ~/.gnupg/main.id_rsa.gpg ]; then
    err "File ~/.gnupg/main.id_rsa.gpg does not exist!"
fi

if [ -f ~/.gnupg/main.sec.key ]; then
    gpg --quiet --import ~/.gnupg/main.sec.key
fi

if [ -f ~/.gnupg/main.id_rsa.gpg ] && [ ! -f ~/.ssh/id_rsa ]; then
    mkdir -p ~/.ssh
    gpg --quiet --yes -o ~/.ssh/id_rsa -d ~/.gnupg/main.id_rsa.gpg
    chmod 0400 ~/.ssh/id_rsa
fi

if [ ! -f ~/.ssh/config ]; then
    echo '-----BEGIN PGP MESSAGE-----

hF4DDOSn+M5KjE8SAQdAVzkgHw/3vNXpOqySjbWh59CDbQf2D2uJkD4tH1R9FzIw
I28//oEy6hHHjimOuPKiKthPqm9ojchFAUoERJUeJ5gcaSeUw0rp/Tty7iXdtHdp
1KcBCQIQbTU26fJSRX6/ur0Ksxt/2OXTTDZCCyuRbI4wxBnLitwpM25JW8Ga27fb
10K1jum+Nwx93uXcwySb/TXadEe5kFTLSW5BDm+K1/HNHXNZ71n/q8SHMixDQN5J
YOutw7sj/Bgpt6f7uZLtVpLYcjEWEn9lmATvjnclP/YdSA6N96fICAVtgYEkb5X7
X9NyciDQ4rV6d1ayzrZrOk2Bh0qOrWQ82g==
=Y3X7
-----END PGP MESSAGE-----' > /tmp/ssh_config
    gpg --quiet --yes -o ~/.ssh/config -d /tmp/ssh_config
fi

(ssh-keygen -F github.com 1> /dev/null || ssh-keyscan github.com) 2> /dev/null >> ~/.ssh/known_hosts
(ssh-keygen -F git-codecommit.us-east-1.amazonaws.com 1> /dev/null || ssh-keyscan git-codecommit.us-east-1.amazonaws.com) 2> /dev/null >> ~/.ssh/known_hosts

cd ${HOME}

if [ ! -d ${REPOSITORY} ] || [ "$(ls -A ${REPOSITORY})" = "" ]; then
    # Clone Repository
    git clone --bare https://${REPO_DOMAIN}/${REPO_NAME}.git ${REPOSITORY}
    # Backup conflict files
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

if [ ! -d ~/secrets/data ]; then
    git clone ssh://git-codecommit.us-east-1.amazonaws.com/v1/repos/dotfiles ~/secrets/data
fi

if [ -d ~/secrets/data ]; then
    cd ~/secrets/
    . decrypt
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
