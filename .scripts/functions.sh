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

# 待办仓库的初始化及更新
_func_todos() {
    REPO_PATH_TODO="${HOME}/Repos/todos"
    if [ ! -d ${REPO_PATH_TODO} ] || [ "`ls -A ${REPO_PATH_TODO}`" = "" ]; then
        git clone git@github.com:codiy1992/todos.git ${REPO_PATH_TODO}
    else
        cd ${REPO_PATH_TODO}; git pull > /dev/null; popd > /dev/null 2>&1;
    fi
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