---
title: rhaphp 安全问题
date: 2021-02-27 09:16:52
---

## RhaPHP介绍

* 一款半开源的微信第三方管理平台, 部分扩展功能插件是收费的.
* 项目地址:[https://github.com/geesondog/rhaphp](https://github.com/geesondog/rhaphp)

## 1.5.8版本存在的安全问题

* 默认开启 info 级别日志, 日志可通过 http 请求直接下载, 下载路径 `/runtime/log/202102/27.log`, info 级别日志将会包含后台登陆账号的 cookie 信息. **真香!!!**
* 存在**ssrf漏洞**路由 `mp/mp/addKeyword` POST 参数 `keyword=abc&type=image&reply_image=dict://redis:6379/flushall&image_staus_type=0`
* 可利用ssrf漏洞**上传任意格式文件**,但无法确定保存的文件名
* RhaPHP1.5.8 版本使用的是 ThinkPHP5.1.35 框架, **存在反序列化利用链**, 但还没找到合适的利用入口.
* 图片上传仅检查后缀, 可通过 phar 文件绕过上传限制, 再配合反序列化入口函数进行爆破(但目前没有找到入口)
* 上传文件直接使用的是文件md5作为文件名和路径, 可再本地模拟后获得上传后的最终路径
* 低版本存在另一个ssrf漏洞, `/mp/show/image?url=file:///etc/passwd`