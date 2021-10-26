---
title: 归档
date: 2021-02-05 14:00:22
---

## CodeCommit仓库设定 > [Details](https://docs.aws.amazon.com/zh_cn/codecommit/latest/userguide/setting-up-ssh-unixes.html)

**[2021-02-09 更新]: 试了几个区域的 push 及 pull 操作, 发现 push 速度尚可, 但 pull 的速度不忍直视, 看来海外区域的 CodeCommit 在国内还是没法用, 暂且留着存个档吧**

> github 仓库限制单文件最大为 100M, 超过 100M 的文件无法上传, 大文件仓库可以使用 AWS 的 CodeCommit

> CodeCommit 每个月有免费 50G 流量, 10000 次 git 请求, 自己用是够够的了 > [Details](https://aws.amazon.com/cn/codecommit/pricing/)

> [CodeCommit 配额](https://docs.aws.amazon.com/zh_cn/codecommit/latest/userguide/limits.html)
* 添加用于 CodeCommit 的 IAM 账户(根账户无法使用SSH协议,需要使用IAM账户)
* 为 IAM 账户授予权限, 并在 "安全证书" 一栏中上传自己的公钥文本到 "AWS CodeCommit 的 SSH 密钥"
* 得到SSH密钥ID: `APKASEIY3LEHMCT243GP`
* 在本地机器添加以下文本到 `~/.ssh/config`
    ```shell
    Host git-codecommit.*.amazonaws.com
        User APKASEIY3LEHMCT243GP
        IdentityFile ~/.ssh/id_rsa
    ```
* 复制 CodeCommit 仓库的 SSH 协议地址, 即可正常进行相关 git 操作