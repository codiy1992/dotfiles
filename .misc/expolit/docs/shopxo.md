---
title: rhaphp 安全问题
date: 2021-02-27 09:16:52
---

## shopxo介绍

* 一款半开源的企业级B2C免费开源电商系统.
* 项目地址:[https://github.com/gongfuxiang/shopxo](https://github.com/gongfuxiang/shopxo)

## 存在的安全问题

* 存在**ssrf漏洞**和**反序列化利用链**, 入口: `index.php?s=/index/qrcode/download&url=$(echo -n 'file:///etc/passwd' | base64) | tr -d '\n'`
* 存在许多演示站点, 默认账号密码 `shopxo:shopxo`
