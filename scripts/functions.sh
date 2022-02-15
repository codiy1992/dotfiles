# zsh config
prompt_context() {
    if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
        prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
    fi
}

# 输出颜色
function err() { if [ -z "$1" ]; then echo "params can't be null"; exit; fi; echo -e "\033[49;31m$1\033[0m"; exit;}
function ok() { if [ -z "$1" ]; then echo "params can't be null"; exit; fi; echo -e "\033[49;32m$1\033[0m";}
function warn() { if [ -z "$1" ]; then echo "params can't be null"; exit; fi; echo -e "\033[49;33m$1\033[0m";}
function info() { if [ -z "$1" ]; then echo "params can't be null"; exit; fi; echo -e "\033[49;34m$1\033[0m";}

# 确认
confirm() {
    echo "${1-Do you want to continue}?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) break;;
            No ) return;;
        esac
    done
    return 1
}

# URL编码
urlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER)
  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}

# base64_encode
en_base64() {
    echo -n "${1}" |base64 |tr -d '\n';
}

keep() {
    curl --upload-file "${1}" https://free.keep.sh
}

function proxy_on() {

    if (( $# > 0 )); then
        valid=$(echo $@ | sed -n 's/\([0-9]\{1,3\}.\?\)\{4\}:\([0-9]\+\)/&/p')
        if [[ $valid != $@ ]]; then
            >&2 echo "Invalid address"
            return 1
        fi
        local proxy=$1
    else
        echo -n "username: "; read username
        if [[ $username != "" ]]; then
            echo -n "password: "
            read -es password
            local pre="$username:$password@"
        fi

        echo -n "server: "; read server
        echo -n "port: "; read port
        local proxy=$pre$server:$port
    fi

    export http_proxy="$proxy" \
           https_proxy=$proxy \
           ftp_proxy=$proxy \
           rsync_proxy=$proxy \
           all_proxy=socks5://$proxy \
           HTTP_PROXY=$proxy \
           HTTPS_PROXY=$proxy \
           FTP_PROXY=$proxy \
           RSYNC_PROXY=$proxy \
           ALL_PROXY=socks5://$proxy \
           no_proxy="localhost,127.0.0.1,0.0.0.0,192.168.0.0/16"
    echo "Proxy environment variable set."
    return 0
}

function proxy_off(){
    unset http_proxy https_proxy ftp_proxy rsync_proxy all_proxy \
          HTTP_PROXY HTTPS_PROXY FTP_PROXY RSYNC_PROXY ALL_PROXY
    echo -e "Proxy environment variable removed."
}

