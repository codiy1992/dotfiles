# dotfiles

![](https://img.codiy.net/repo/dotfiles/2021-12-21-21-16-35.png)

## How to Setup

* `curl -fsSL https://raw.githubusercontent.com/codiy1992/dotfiles/master/.scripts/setup.sh | bash`
* or shorter `curl -fsSL https://git.io/JRK2L | bash`

## How to Use

* Use Command **`got`** Just like use **`git`**
* `got status`, `got diff`, `got pull`, `got push`

## How to Make Yours

* Create a Public Repository on Github.
* Then Copy [the content of this file](https://raw.githubusercontent.com/codiy1992/dotfiles/master/.scripts/setup.sh)
* Change Some Variables to Yours
* Push this this file to Your Github Repository
* set alias `alias got='git --git-dir=${HOME}/Bares/dotfiles.git --work-tree=${HOME}'` in Your `.zshrc` file
* `source ~/.zshrc` And Then You can use `got` to Manage Your **dotfiles**.

