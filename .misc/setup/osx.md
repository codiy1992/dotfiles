---
title: 我的Mac装机步骤
date: 2020-03-09 14:07:18
---

## 1. 安装基础软件和设定

- 安装 [iterm2](https://iterm2.com/)
- 安装 [homebrew](https://brew.sh/)
- 安装输入法
- 设置键盘映射 `System Preferences > Keyboard > Modifier Keys... `
- 设置滚轮 `System Preferences > Trackpad > Scroll & Zoom > Scroll direction: Natural`
- 设置允许重复按键 `defaults write -g ApplePressAndHoldEnabled -bool false`, 需重启机器

## 2. 安装0h-my-zsh

- 2.1 安装oh-my-zsh

    ```shell
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```

- 2.2 [安装powerline字体](https://github.com/ryanoasis/nerd-fonts)

    ```shell
    brew tap homebrew/cask-fonts
    // Microsoft Cascadia Code
    brew install --cask  font-caskaydia-cove-nerd-font
    // Meslo LG
    brew install --cask font-meslo-lg-nerd-font
    ```

- 2.3 设置item2配色方案和字体

    > Perferences—->Profiles—->Colors—->Color Presets 选择 Solarized Dark
    >
    > Perferences—->Profiles—->Text-->Font 选择任意 Powerline 字体
    >
    > Perferences-->Profiles-->Window-->Transparency

- 2.4 安装zsh插件

    > brew install autojump
    >
    > 在.zshrc中指定插件 plugins=(git autojump)

- 2.5 修改zsh主题

    ```shell
    vi .zshrc
    // 修改ZSH_THEME
    ZSH_THEME="agnoster"
    ```

## 3. 文件拷贝,配置ssh及vim

```shell
# 从原Mac拷贝以下文件到新Mac
~/.ssh/id_rsa
~/.ssh/id_rsa.pub
~/.ssh/config
~/.ssh/各类ssh的rsa密钥

# 安装macvim
brew install --cask macvim
# 从原Mac拷贝以下文件到新Mac
~/.vim/
~/.vimrc
~/.gvimrc

# 工作代码
~/Works

# 自己代码
~/Repos

# 其他有用的文件
~/.aws/
~/.gvimrc
~/.config
~/.ssh/
~/.vim/
~/.vimrc
~/.zshrc
~/.zshrc.osx.sh
~/.workspaces
~/Works
~/Repos
```

## 4. 安装各类软件

```shell
# 必备
brew install --cask item2
brew install --cask alfred
brew install --cask docker
brew install --cask clashx
brew install --cask google-chrome

# gpg2
brew insall gpg2
brew install --cask gpg-suite
# pinentry for gpg
brew install pinentry-mac
echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
killall gpg-agent

# 数据库工具
brew install --cask sequel-ace

# Nodejs
brew install yarn

# Java
brew tap AdoptOpenJDK/openjdk
brew install --cask adoptopenjdk8
brew install maven
brew install gradle

# DevOps
brew install aws-cdk
brew install --cask docker

# Others
brew install --cask kindle
brew install svn
brew install --cask shadowsocksx-ng
brew install --cask postman

##
brew install aria2
brew install youtube-dl
brew install ffmpeg
brew install mitmproxy
```

## 5. 开启mac支持windows的ntfs格式移动硬盘

```shell
sudo nano /etc/fstab
LABEL=移动硬盘名称 none ntfs rw,auto,nobrowse
然后ctrl + o，回车，ctrl + x 回车，保存并退出
```

## 6. 使用 gnu-sed 代替 mac 版的 sed

```shell
brew install gnu-sed
brew install grep
echo 'export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"' >> ~/.zshrc
echo 'export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"' >> ~/.zshrc
```
