# 命令行代理, 需打开防火墙(设置 > 更新和安全 > windows安全中心 > 防火墙和网络保护 > 允许应用通过防火墙 > 勾选代理软件)
export https_proxy=http://$(ip route|awk '/^default/{print $3}'):7890
export http_proxy=http://$(ip route|awk '/^default/{print $3}'):7890
export all_proxy=socks5://$(ip route|awk '/^default/{print $3}'):7890

# alias
alias rc='vim ~/.scripts/.zshrc.linux.wsl.sh; source ~/.zshrc'

# apps
alias idea='/home/codiy/Applications/idea/bin/idea.sh'
alias chrome='google-chrome &'

# homebrew
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# 命令别名 /* shell在单引号中加单引号用成对的 '\'' */
export DONT_PROMPT_WSL_INSTALL="yes"
alias vs='_func() { /mnt/c/Users/codiy/scoop/shims/code '\''\\wsl$\Ubuntu\home\codiy\.workspaces\windows.code-workspace'\''; }; _func'
alias @='_func() { /usr/bin/code ~/.workspaces/"$1".code-workspace; }; _func'

# ----- 图形化程序 -----
# for VcXsrv 指定显示设备
export DISPLAY=$(ip route|awk '/^default/{print $3}'):0
# for fcitx 输入法
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export DefaultIMModule=fcitx
FCITX_PROCESS_COUNT=`ps -ef | grep fcitx | grep -v "grep" | wc -l`
if [ ${FCITX_PROCESS_COUNT} -lt 1 ]; then
  fcitx-autostart &>/dev/null
fi

# run commands
cd ~/Repos
