---
title: 私密信息管理
date: 2020-11-18 15:20:27
---

## 解决方案

* 专有的 [1password](https://1password.com/), 各端和web插件均有支持, 功能丰富, 操作便捷, 管理密码的利器
* 开源的 [keepass](https://keepass.info/download.html), 各端和web插件均有支持, 功能简单, 满足一般需求
* 开源的 [gnupg](https://github.com/gpg/gnupg),可加密成二进制文件, 也可加密成加密字符串, 配合 vscode 插件 [GnuPG-Tool](https://github.com/heilingbrunner/vscode-gnupg-tool.git) 直接对文档里的私密信息进行加密, 非常方便

## [gnupg 简单介绍](https://wiki.archlinux.org/index.php/GnuPG_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
* 采用**主密码 + 非对称密钥对**的形式进行信息的加解密, 只有**主密码**或者只有**密钥对**均不能正常加解密, 得配合起来用.
* 主密码应当只记在脑子里, 不应存储在任何介质上, 以保证安全.
* 在信任的机器上安装gpgpg软体, 并导入非对称密钥对的**私钥**.

## gnupg 使用
* 产生非对称密钥对
* 使用场景
  - A,B双方文件加密传输: A用B的公钥对文档进行加密后传送给B, B拿到加密文档后用B的私钥进行解密得到原文档.
  - A,B双方进行文件加密并签名: A用B的公钥对文档进行加密,并用A自己的私钥进行签名(签章), B拿到后用B的私钥进行解密,并用A的公钥进行验签.
  - 仅自己一方在多处终端使用: 同一份私钥放置在不同机器上, 用自己公钥对文档进行加密存储, 在其他地方在用自己私钥进行解密
* 常用指令

  ```shell
  // 创建密钥对
  gpg --full-gen-key
  // 列出公钥私钥
  gpg --list-keys
  gpg --list-secret-keys
  // 导出公钥
  gpg --export <user-id> > xxx.pub.key
  // 导出公钥(以纯 ASCII 文本形式)
  gpg --armor --export <user-id> > xxx.pub.asc
  // 导出私钥
  gpg --export-secret-keys <user-id> > xxx.sec.key
  // 导入公钥或私钥
  gpg --import xxx.pub.key
  gpg --import xxx.sec.key
  // 加密文档, 使用对方公钥进行加密
  gpg --recipient <user-id> --encrypt doc
  // 解密文档
  gpg --decrypt doc.gpg --output doc
  // 对文档进行加密并签名
  gpg --sign --recipient <user-id> --encrypt doc
  // 管理已有密钥对
  gpg --edit-key <user-id>
  // 公钥服务器的使用
  gpg --send-keys <key-id>
  gpg --search-keys <key-id>
  gpg --recv-keys <key-id>
  ```
* 私钥的导入和导出,都需要验证主密码
