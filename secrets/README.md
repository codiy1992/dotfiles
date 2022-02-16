---
title: 使用 Gnupg 管理私密信息
date: 2020-11-18 15:20:27
---

## [gnupg 简介](https://wiki.archlinux.org/index.php/GnuPG_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
* 采用**主密码 + 非对称密钥对**的形式进行信息的加解密
* 只有**主密码**或者只有**密钥对**均不能正常加解密, 得配合起来用.
* 私钥的导入和导出,都需要验证主密码
* 应用一(A,B双方文件加密传输): A用B的公钥对文档进行加密后传送给B, B拿到加密文档后用B的私钥进行解密得到原文档.
* 应用二(A,B双方进行文件加密并签名): A用B的公钥对文档进行加密,并用A自己的私钥进行签名(签章), B拿到后用B的私钥进行解密,并用A的公钥进行验签.

## gnupg 使用

* 创建新密钥对

```
gpg --full-gen-key
```

* 导入私钥(公钥可由私钥生成，无需导入)

```
// 导入公钥或私钥
gpg --import xxx.pub.key
gpg --import xxx.sec.key
```

* 信任密钥

```
// 方式1
cat 'trusted-key B2980F3D615692897D3F344FAC8E655219F3ABB3' >> ~/.gnupg/gpg.conf
// 方式2, 选5 I trust ultimately
gpg --edit-key <user-id> trust
```

* 列出公钥私钥

```
gpg --list-keys
gpg --list-secret-keys
```

* 加密，解密，签名

```
// 加密文档, 使用对方公钥进行加密
gpg --recipient <user-id> --encrypt doc
// 解密文档
gpg --decrypt doc.gpg --output doc
// 对文档进行加密并签名
gpg --sign --recipient <user-id> --encrypt doc
```

* 导出

```
// 导出公钥
gpg --export <user-id> > xxx.pub.key
// 导出公钥(以纯 ASCII 文本形式)
gpg --armor --export <user-id> > xxx.pub.asc
// 导出私钥
gpg --export-secret-keys <user-id> > xxx.sec.key
```

* 管理已有密钥对

```
gpg --edit-key <user-id>
// 改密码
gpg --edit-key <user-id> passwd
// 改过期时间
gpg --edit-key <user-id> expire
```

* 移除

```
gpg --delete-keys xxxx
gpg --delete-secret-keys xxxx
```

* 公钥服务器的使用

```
gpg --send-keys <key-id>
gpg --search-keys <key-id>
gpg --recv-keys <key-id>
```
