# 命令别名 - OSX
alias sm='emacs -nw'
alias smq='emacs -nw -Q'
alias sed='gsed'
alias grep='ggrep'
alias rc='vim ~/scripts/.zshrc.osx.sh; source ~/.zshrc.sh'

# 命令别名 - 机器操作
alias fk.cron='ssh -i ~/.ssh/wlive.pem ec2-user@18.197.217.42'
alias fk.goim='ssh -i ~/.ssh/wlive.pem ec2-user@52.59.193.153'
alias fk.exec='ssh -i ~/.ssh/wlive.pem ec2-user@3.122.150.42'
alias fk.logs='DATE=$(date +%Y-%m-%d);ssh fk.logs -t "cd /data/${DATE}; /bin/bash --login;"'
alias fk.logs.web='ssh fk.logs -N -L 8080:127.0.0.1:80 &'

