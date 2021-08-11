# 本地化
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

OS_TYPE=$(uname)

# 导入函数
source ${HOME}/.scripts/functions.sh

if [[ "${OS_TYPE}" == "Darwin" ]]; then
    source ${HOME}/.scripts/.zshrc.osx.sh
else
    DISTRO=$(lsb_release -i | cut -f 2-)
    if [[ ! "${DISTRO}" == "Ubuntu" ]]; then
        source ${HOME}/.scripts/.zshrc.linux.wsl.sh
    fi
fi

# 命令行代理
export https_proxy=http://127.0.0.1:7890
export http_proxy=http://127.0.0.1:7890
export all_proxy=socks5://127.0.0.1:7891
# export no_proxy=127.0.0.1,0.0.0.0,localhost

# JDK 版本
# JDK_VERSION="xxx"
# export JAVA_HOME=$(/usr/libexec/java_home -v"${JDK_VERSION}")

# 命令别名 - 通用
alias pd='popd'
alias ll='ls -al'
alias rmkh='_func() { sed -i "" "$1"d  ${HOME}/.ssh/known_hosts;}; _func'
alias ascii2hex='_func(){echo "$1" | hexdump -vC |  awk '\''BEGIN {IFS="\t"} {$1=""; print }'\'' | awk '\''{sub(/\|.*/,"")}1'\'' | tr -d '\''\n'\''|sed '\''s/  / /g'\'' |sed '\''s/ /\\x/g'\''|rev|cut -c 3- |rev }; _func'
alias ipinfo='_func(){curl "http://ip-api.com/line/$1?lang=zh-CN"}; _func'
alias git.branch.rm='_func(){git branch -d "$1"; git push origin --delete "$1"}; _func'
alias got='git --git-dir=${HOME}/Bares/dotfiles.git --work-tree=${HOME}'

# 命令别名 - 系统管理
alias tcp='lsof -i -n -P | grep TCP'

# 命令别名 - 私人项目管理
alias eb.pull='yes|rclone sync -i remote:/eblibs ~/Repos/rc-eblibs 2> /dev/null; cd ~/Repos/eblibs; git checkout .; git pull; popd > /dev/null;'
alias eb.push='cd ~/Repos/eblibs; git add . && git commit -a --allow-empty-message -m "" && git push; yes|rclone sync -i ~/Repos/rc-eblibs remote:/eblibs 2> /dev/null';
alias book.pull='yes|rclone sync -i remote:/books ~/Repos/books 2> /dev/null;'
alias book.push='yes|rclone sync -i ~/Repos/books remote:/books 2> /dev/null'
alias af.push='yes|rclone sync -i ~/Repos/Alfred remote:Alfred > /dev/null 2>&1'
alias af.pull='yes|rclone sync -i remote:Alfred ~/Repos/Alfred > /dev/null 2>&1'
alias todo='cd "${HOME}/Repos/todos";make;popd'
alias repo='_func() {cd "${HOME}/Repos/mp-backend/.docker"; if [ -n "$1" ]; then make "$1"; else make; fi; popd}; _func'

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

# 命令别名 - youtube-dl
# --proxy "socks5://127.0.0.1:7891" \
alias ydl='
    youtube-dl \
    --hls-prefer-ffmpeg \
    --merge-output-format mp4 \
    --external-downloader aria2c \
    --external-downloader-args "-c -x 6 -k 1M --all-proxy=127.0.0.1:7890" \
    -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio/best" \
    -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s"'

# 命令别名 - wireshark
alias ws.get='
    _func () {
        echo "dns.qry.name contains \"$1\" || ip.addr == "`dig "$1" +short | grep -oP '\''((\d)+.){3}\d+'\''| sort | sed '\'':a;N;s/\n/ || ip.addr == /;t a;'\''`
    }; _func
'
alias ws.weixin='
    echo "dns.qry.name contains \"qq.com\" || dns.qry.name contains \"weixin\" || dns.qry.name contains \"tencent\" || dns.qry.name contains \"wechat\" || ip.addr == "`
    dig \
        dns.weixin.qq.com \
        minorshort.weixin.qq.com \
        safebrowsing.urlsec.qq.com \
    +short | grep -oP '\''((\d)+.){3}\d+'\''| sort | sed '\'':a;N;s/\n/ || ip.addr == /;t a;'\''`
'

# -- 根据私钥生成公钥
# ssh-keygen -y -f ~/.ssh/privateKey > ~/.ssh/PublicKey
# -- SSH 代理
# ssh ${PORXY_HOST} -N -L ${LOCAL_PORT}:${TARGET_HOST_DOMAIN}:${TARGET_PORT}
