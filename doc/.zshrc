실습 환경 중 .zshrc
--------------------------

기본 shell을 zsh로 변경했고
omyzsh 을 설치했습니다.

```
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerline2"
POWERLINE_HIDE_HOST_NAME="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=/usr/local/bin:$HOME/bin:$PATH
LANG=ko_KR.UTF-8;export LANG

alias god='cd /Users/doortts/Dropbox'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs="git status"
alias gc="git commit"
alias gca="git commit --amend"
alias gm="git commit -a -m"
alias grc="git rebase --continue"
alias grs="git rebase --skip"
alias gra="git rebase --abort"
alias gsp="git stash pop"
alias act="/Users/doortts/dev/play2/activator"
alias http='python -m SimpleHTTPServer 8888 &'

export TERM="xterm-256color"
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# play settings
export PATH=/usr/local/bin:$PATH:~/bin:~/dev/play2:~/dev/play-2.1.0

# npm global location
export PATH=~/npm-global/bin:$PATH

alias dif='/Applications/WebStorm.app/Contents/MacOS/webstorm diff'
```