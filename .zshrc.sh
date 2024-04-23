# 本地化
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH="${HOME}/bin:${HOME}/go/bin:${PATH}"

OS_TYPE=$(uname)

# 导入函数
source ${HOME}/scripts/functions.sh

if [[ "${OS_TYPE}" == "Darwin" ]]; then
    # source ${HOME}/scripts/.zshrc.osx.sh
else
    DISTRO=$(lsb_release -i | cut -f 2-)
    if [[ ! "${DISTRO}" == "Ubuntu" ]]; then
        source ${HOME}/scripts/.zshrc.linux.wsl.sh
    fi
fi

# 命令行代理
alias proxy.on='proxy_on 127.0.0.1:7890'
alias proxy.off='proxy_off'

alias restic='. ~/.config/restic/env; restic'

function backup {
    restic backup --quiet --tag canada /Users/codiy/Documents/canada/*
    # 最近10年每年保留1条, 最近6个月每个月保留1条, 最近4周每周保留1条, 保留最近5条
    restic forget --quiet --cleanup-cache --host mbp.local \
        --tag canada \
        --keep-weekly 4 \
        --keep-monthly 6 \
        --keep-yearly 10 \
        --keep-last 5 \
        --prune
}

function restore {
    restic restore latest --host mbp.local --path /Users/codiy/Documents/canada/$1 --target ${2:-/}
}

# 命令别名 - 通用
alias vim='nvim'
alias copyssh="pbcopy < ${HOME}/.ssh/id_rsa.pub"
alias rmkh='_func() { sed -i "" "$1"d  ${HOME}/.ssh/known_hosts;}; _func'
alias ascii2hex='_func(){echo "$1" | hexdump -vC |  awk '\''BEGIN {IFS="\t"} {$1=""; print }'\'' | awk '\''{sub(/\|.*/,"")}1'\'' | tr -d '\''\n'\''|sed '\''s/  / /g'\'' |sed '\''s/ /\\x/g'\''|rev|cut -c 3- |rev }; _func'
alias ipinfo='_func(){curl "http://ip-api.com/line/$1?lang=zh-CN"}; _func'
alias git.branch.rm='_func(){git branch -d "$1"; git push origin --delete "$1"}; _func'
alias got='git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}'
alias got.encrypt='${HOME}/secrets/encrypt'
alias got.decrypt='${HOME}/secrets/decrypt'
alias tmd='_func() {tmux new -s ${1:-codiy}}; _func'
alias tma='_func() {tmux attach-session -t ${1:-codiy}}; _func'

# 命令别名 - 系统管理
alias tcp='lsof -i -n -P | grep TCP'

# 命令别名 - 项目管理
alias repo='_func() {cd "${HOME}/Repos/dockers/compose"; if [ -n "$1" ]; then make "$@"; else make; fi; popd}; _func'
alias ops='_func() {cd ~/Repos/aws && make bash PROFILE=${1:-default}}; _func'

# 命令别名 - docker
alias docker.clean='docker stop $(docker ps -a -q); docker rm $(docker ps -a -q); docker rmi $(docker images -q -f dangling=true);'
alias docker.rm.all='docker rm $(docker ps -a -q)'
alias docker.stop.all='docker stop $(docker ps -a -q)'
alias docker.rmi.dangling='docker rmi $(docker images -q -f dangling=true)'
alias docker.rmi.all='docker rmi -f $(docker images -aq)'
alias docker.system.prune='docker system prune'
alias docker.volume.prune='docker volume prune'
alias docker.exec='docker exec -it'

# 命令别名 - ansible
alias play='ansible-playbook'
alias vault='ansible-vault'
alias encrypt='ansible-vault encrypt '

# brew
alias brew.bundle="brew bundle --file=${HOME}/Brewfile --force --cleanup"
alias brew.dump="brew bundle dump --file=${HOME}/Brewfile --force"
alias brew.cu="brew cu"
alias brew.zap="brew cask zap "

# asciinema
alias rec.start='asciinema rec '
alias rec.upload='asciinema upload '
alias rec.auth='asciinema auth'

# 命令别名 - rclone
function a() {
    assetRoot=~/Assets
    s3Bucket="kfcs3:s3.codiy.net"
    X=$#
    ARR=("$@")
    if [ "$#" -ge 2 ]; then
        RC_OPTIONS="${ARR[@]:0:$((X-1))}"
        RC_LOCATION="${ARR[X]}"
    else
        RC_OPTIONS="$@"
    fi

    rclone "$RC_OPTIONS" "$s3Bucket${RC_LOCATION+/}$RC_LOCATION"
}

function a.pull() {
    assetRoot=~/Assets
    s3Bucket="kfcs3:s3.codiy.net"

    rclone sync --dry-run --exclude ".DS_Store" "$s3Bucket/$@" "$assetRoot/$@"
    confirm || {
        rclone sync --exclude ".DS_Store" "$s3Bucket/$@" "$assetRoot/$@"
    }
}

function a.push() {
    assetRoot=~/Assets
    s3Bucket="kfcs3:s3.codiy.net"

    rclone sync --dry-run --exclude ".DS_Store" "$assetRoot/$@" "$s3Bucket/$@"
    confirm || {
        rclone sync --exclude ".DS_Store" "$assetRoot/$@" "$s3Bucket/$@"
    }
}

function git.fresh() {
    git checkout --orphan tmp_fresh
    git add -A
    git commit -am 'first commit'
    git branch -D master
    git branch -m master
    git push -f origin master
    git gc --aggressive --prune=all
}

# 比较两个文本行的不同(找出在 $2 里但不在 $1 中的行)
function gdiff() {
    grep -vxFf <(grep -o '^[^#]*' $1 | sort|uniq) <(grep -o '^[^#]*' $2 |sort|uniq)
}
function cdiff() {
    comm ${3--13} <(grep -o '^[^#]*' $1 | sort|uniq) <(grep -o '^[^#]*' $2 |sort|uniq)
}
function normal() {
   grep -o '^[^#]*' </dev/stdin|sort|uniq
}
function intersect() {
    comm ${3--12} <(grep -o '^[^#]*' $1 | sort|uniq) <(grep -o '^[^#]*' $2 |sort|uniq)
}

# terraform auto-complete
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# -- 根据私钥生成公钥
# ssh-keygen -y -f ~/.ssh/privateKey

# -- SSH 本地端口转发 通过ssh访问目标机器能访问的资源
# @link https://www.cnblogs.com/f-ck-need-u/p/10482832.html
# -f 放入后台
# -g 允许局域网其他机器通过本地建立的端口转发链接到目标机器
# -N 指明建立的链接不用于执行命令，只用来端口转发
# -L 指定端口映射
# ssh ${TARGET_HOST} -f -g -N -L ${LOCAL_PORT}:${TARGET_HOST}:${TARGET_PORT}

# -- SSH 远程端口转发 将本地局域网内端口通过ssh暴露给目标机器
# ssh ${TARGET_PORT} -fgN -R ${TARGET_PORT}:${LAN_HOST}:${LAN_PORT}

# -- SSH SOCKS5 代理
# ssh ${TARGET_HOST} -fgN -D [bind_addr:]port

# -- Auto Add keyfinger to known_hosts
# ssh-keygen -F git.wangle.ltd || ssh-keyscan git.wangle.ltd >> ~/.ssh/known_hosts

# https://github.com/driesvints/dotfiles/blob/main/Brewfile
# brew bundle dump
# brew bundle [install]

# Git remove a submodule
# git submodule deinit
# rm -fr .gitmodules
# git add .gitmodules
# git rm --cached path_to_submodule
# rm -fr .git/modules/path_to_submodule
# git commit -m 'Removed submodule xxx'
# rm -fr path_to_submodule

# Subscriable Clash Container
# docker run -d --name=clash --net=host --log-opt max-size=10m -e CLASH_SUBSCRIBE_URL=http://xxxxxx/config/docker codiy/clash
