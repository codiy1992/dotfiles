---
title: 设置代理环境变量
date: 2021-03-10 09:23:01
---

详细参考: [https://about.gitlab.com/blog/2021/01/27/we-need-to-talk-no-proxy/](https://about.gitlab.com/blog/2021/01/27/we-need-to-talk-no-proxy/)

## `http_proxy` and `https_proxy`

* **小写格式**总是被支持的, **大写格式**不一定被支持

## `no_proxy`

* 使用小写格式
* 可以使用 `hostname:port` 的格式
* 使用域名后缀匹配(e.g. `example.com` 会匹配 `test.example.com`)
* 要匹配顶级域名,需避免在域名前面有`.`号
* 避免使用**CIDR格式**, 因为只有 Go 和 Ruby 支持.
* 腾讯云需设置 `export no_proxy=mirrors.tencentyun.com` 否则无法使用 `yum`

## ssh 代理设置

* 安装依赖程序 `sudo yum install nmap` or `sudo apt-get install nmap`
* 编辑 `~/.ssh/config` 添加如下配置
```shell
Host github.com
   HostName github.com
   ProxyCommand /usr/bin/ncat --proxy 127.0.0.1:7091 --proxy-type socks5 %h %p
```