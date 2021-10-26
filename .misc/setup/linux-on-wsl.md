---
title: linux 开发环境配置指引(WSL)
date: 2020-11-20 15:15:27
---

## 1. 更新软件包, 安装基础软件

```shell
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install gcc
sudo apt-get install g++
sudo apt-get install powerline
sudo apt-get install autojump
sudo apt-get install zsh
chsh -s $(which zsh)
```

* 建立新的会话
* 导入 id_rsa 密钥对
* 拉取本仓库代码
```
mkdir ~/Repos
git clone git@github.com:codiy1992/setup.git
cd ~/Repos/setup
bash setup.sh
```

* 设置vim

```shell
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
// vim 执行下面命令
:PluginInstall
```

* 安装oh-my-zsh

```shell
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

* 设置zsh

```shell
ZSH_THEME="agnoster"
plugins=(
        git
        autojump
)
# User configuration
source ~/.zshrc.linux.wsl
```


* 安装 homebrew

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

* python & node & ansible

```shell
// 安装 python2.7
sudo apt-get install python
ln -s /usr/bin/python2.7 /usr/bin/python
// 安装 python3
brew install python
brew install yarn
brew install ansible
brew install frpc
```

* 安装gnupg,gopass(在linux子系统中可不装, 子系统内使用windows的gopass.exe) > [Ubuntu需自行下载amd64包进行安装](https://github.com/gopasspw/gopass/releases)

```shell
apt-get install gnupg2 git rng-tools
wget [the URL of the latest .deb release]
sudo dpkg -i gopass-<version>-linux-amd64.deb
gopass clone git@github.com:codiy1992/secrets.git
```

## 2. Java 开发环境

* 安装 sdkman > [官方文档](https://sdkman.io/install)

```shell
curl -s "https://get.sdkman.io" | bash
```

* 安装 AdoptOpenJDK (方式一)

```shell
sdk list java
sdk install java 11.0.9.hs-adpt
```

* 安装 AdoptOpenJDK (方式二) > [官方文档](https://adoptopenjdk.net/installation.html#linux-pkg)

```shell
CODE_NAME=$(cat /etc/os-release | grep UBUNTU_CODENAME | cut -d = -f 2)
sudo apt-get install wget apt-transport-https gnupg
echo "deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb ${CODE_NAME} main" | sudo tee /etc/apt/sources.list.d/adoptopenjdk.list
sudo apt-get update
sudo apt-cache search adoptopenjdk
sudo apt-get install adoptopenjdk-11-hotspot
```

## 3. 为运行桌面程序安装语言包,字体库,输入法 [参考 archlinux 中文配置](https://wiki.archlinux.org/index.php/Localization_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)/Simplified_Chinese_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))

### 1. locale 设置(安装中文语言包)

* 编辑 `/etc/locale.gen` 后运行 `locale-gen` 或运行下面命令

```shell
locale-gen zh_CN.utf8 // 安装中文语言包,以支持显示中文字符
update-locale LANG=en_US.UTF-8 // 此处保持用英文,不然 terminal 也会变成中文, 甚至可能导致意外的乱码
```

### 2. 安装字体库, 并设置中文字体配置

* 系统字体位置 `/usr/share/fonts`
* 用户字体安装位置 `~/.local/share/fonts`
* 安装字体后用命令 `fc-cache -f -v` 刷新字体库缓存
* 例如安装 cascadia-code 字体 [Releases](https://github.com/microsoft/cascadia-code/releases)

```shell
wget https://github.com/microsoft/cascadia-code/releases/download/v2009.22/CascadiaCode-2009.22.zip
unzip CascadiaCode-2009.22.zip
mv ./tff ~/.local/share/fonts/cascadia-code
fc-cache -f -v
```

* 列出汉字字体 `fc-list :lang=zh`
* 中文字体配置(虽然安装了语言包和字体库,但仍需定义这些中文字体在什么情况下如何被使用) [配置参考](https://wiki.archlinux.org/index.php/Font_Configuration_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)/Chinese_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))

### 3. 安装输入法

* [linux 常见输入法介绍](https://wiki.archlinux.org/index.php/Category:Input_methods_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
* 安装 CJK 字体和 fcitx 核心 `sudo apt install fcitx fonts-noto-cjk fonts-noto-color-emoji dbus-x11`
* 安装 fcitx 输入法 `sudo apt install fcitx-googlepinyin`
* 若 /var/lib/dbus/machine-id 已存在则不执行, 否则执行 `dbus-uuidgen > /var/lib/dbus/machine-id`
* 因 wsl 子系统无法开机执行用户脚本, 这里暂时放在 .zshrc.linux.wsl 中来开启 fcitx
* 运行 `fcitx-config-gtk3` 对输入法进行配置
* [参考博文](https://patrickwu.space/2019/10/28/wsl-fcitx-setup-cn/)

## 4. 安装 GUI 应用程序

* 导出 `$DISPLAY` 变量供 GUI 程序找到显示位置

```shell
// 三选一, 将 DISPLAY 定位到 windows 系统中的 xlaunch 服务
export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"
export DISPLAY="`sed -n 's/nameserver //p' /etc/resolv.conf`:0"
export DISPLAY=$(ip route|awk '/^default/{print $3}'):0

```

* 安装 google-chrome

```shell
sudo apt install gdebi-core wget
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi google-chrome-stable_current_amd64.deb
google-chrome
```

* 安装 IDEA > [官方地址](https://www.jetbrains.com/idea/download/#section=linux)

```
cd ~/Applications
wget https://download-cf.jetbrains.com/idea/ideaIU-2020.3.tar.gz
tar zxf ideaIU-2020.3.tar.gz
cd idea-IU-203.5981.155/bin/
./idea.sh

// 破解参考 > https://tech.souyunku.com/?p=18946
```


## 5. [Optional] 在 wsl2 中启用 snap [参考文档](https://discourse.ubuntu.com/t/using-snapd-in-wsl2/12113)

> snap 依赖 systemd 而 ubuntu on wsl2 使用 init 而不是 systemd, 因此 snap 无法在 wsl2 中正常工作, 虽然有启用 systemd 的方法但感觉违背了wsl的模式

```shell
// 安装
sudo apt-get update && sudo apt-get install -yqq daemonize dbus-user-session fontconfig
// 创建一个容器让 systemd 的 pid 为 1
sudo daemonize /usr/bin/unshare --fork --pid --mount-proc /lib/systemd/systemd --system-unit=basic.target
// 登陆到容器, 然后在容器内操作 snap
exec sudo nsenter -t $(pidof systemd) -a su - $LOGNAME
```
