# 命令别名 - OSX
alias sm='emacs -nw'
alias smq='emacs -nw -Q'
alias sed='gsed'
alias grep='ggrep'
alias rc='vim ~/.scripts/.zshrc.osx.sh; source ~/.zshrc.sh'
alias @='_func() { code ~/.workspaces/"$1".code-workspace; }; _func'

# 命令别名 - 工作
alias ops='_func() {cd ~/Works/wn-devops && make bash PROFILE=${1:-default}}; _func'
alias deploy='ssh -t deploy "cd /devops; make bash"'
alias work='_func() {cd ~/Works/.wlive; if [ -n "$1" ]; then make "$@"; else make; fi; popd}; _func'

# 命令别名 - 机器操作
alias fk.cron='ssh -i ~/.ssh/wlive.pem ec2-user@18.197.217.42'
alias fk.goim='ssh -i ~/.ssh/wlive.pem ec2-user@52.59.193.153'
alias fk.exec='ssh -i ~/.ssh/wlive.pem ec2-user@3.122.150.42'
alias fk.logs='DATE=$(date +%Y-%m-%d);ssh fk.logs -t "cd /data/${DATE}; /bin/bash --login;"'
alias fk.logs.web='ssh fk.logs -N -L 8080:127.0.0.1:80 &'
alias hk.01='ssh hk.01 -t "sudo su; /bin/bash --login;"'
alias hk.03='ssh hk.03 -t "sudo su; /bin/bash --login;"'
alias hk.db='ssh hk.db -t "sudo su; /bin/bash --login;"'
alias fk.logs.api='_func() {
    DATE=$(date +%Y-%m-%d);
    multitail -c -l "ssh fk.logs tail -f /data/${DATE}/api/$1-${DATE}.log"
}; _func'
alias fk.logs.act='_func() {
    DATE=$(date +%Y-%m-%d);
    multitail -c -l "ssh fk.logs tail -f /data/${DATE}/activity/logs/$1-${DATE}.log"
}; _func'
alias fk.logs.nginx='_func() {
    DATE=$(date +%Y-%m-%d);
    multitail -c -l "ssh fk.logs tail -f /data/${DATE}/$1/logs/access.log"
}; _func'

