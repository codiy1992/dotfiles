# 命令别名 - OSX
alias sm='emacs -nw'
alias smq='emacs -nw -Q'
alias sed='gsed'
alias grep='ggrep'
alias rc='vim ~/.scripts/.zshrc.osx.sh; source ~/.zshrc.sh'

# 命令别名 - 机器操作
alias fk.cron='ssh -i ~/.ssh/wlive.pem ec2-user@18.197.217.42'
alias fk.goim='ssh -i ~/.ssh/wlive.pem ec2-user@52.59.193.153'
alias fk.exec='ssh -i ~/.ssh/wlive.pem ec2-user@3.122.150.42'
alias fk.logs='DATE=$(date +%Y-%m-%d);ssh fk.logs -t "cd /data/${DATE}; /bin/bash --login;"'
alias fk.logs.web='ssh fk.logs -N -L 8080:127.0.0.1:80 &'
alias hk.01='ssh hk.01 -t "sudo su; /bin/bash --login;"'
alias hk.03='ssh hk.03 -t "sudo su; /bin/bash --login;"'
alias hk.db='ssh hk.db -t "sudo su; /bin/bash --login;"'

function hk01() {
    declare -A CODE_PATHS
    CODE_PATHS['api']='/data/wn-api'
    CODE_PATHS['activity']='/data/wn-activity'
    CODE_PATHS['core']='/data/wn-core'
    CODE_PATHS['admin']='/data/wn-admin'
    CODE_PATHS['cntask']='/data/cn-task'
    ssh hk.01 sudo /data/dockers/compose/develop/deploy.sh "$1" "${CODE_PATHS['$1']}" "$2"
}

function hk03() {
    declare -A CODE_PATHS
    CODE_PATHS['api']='/data/wn-api'
    CODE_PATHS['activity']='/data/wn-activity'
    CODE_PATHS['core']='/data/wn-core'
    CODE_PATHS['admin']='/data/wn-admin'
    CODE_PATHS['meta']='/data/cn-meta'
    CODE_PATHS['ucenter']='/data/wn-ucenter'
    ssh hk.03 sudo /data/dockers/compose/develop/deploy.sh "$1" "${CODE_PATHS['$1']}" "$2"
}
