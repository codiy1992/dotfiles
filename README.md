# dotfiles

![](https://img.codiy.net/repo/dotfiles/2021-12/22220004.png)

## How to setup

```
curl -fsSL https://raw.githubusercontent.com/codiy1992/dotfiles/master/install.sh | bash
```

## How to use

* Use command **`got`** just like use **`git`**
* `got status`, `got diff`, `got pull`, `got push`

## How to make yours

* Create a **public repository** for your own dotfiles on Github.
* Then copy the content of [my installation script][1]
* Change variables to yours
* Commit and push it to your github repository
* Create alias `alias got='git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}'` in Your `.zshrc`  
or `.bashrc` file and **source** it.
* And then you can use `got` to manage your **dotfiles**.

[1]: https://raw.githubusercontent.com/codiy1992/dotfiles/master/install.sh
