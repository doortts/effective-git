
git config -l --global                                                                                                       
---

```
user.name=Suwon Chae
user.email=doortts@gmail.com
alias.co=checkout
alias.edit=!f() { git diff --name-status --diff-filter=U | cut -f2 ; }; vi `f`
alias.add-unmerged=!f() { git diff --name-status --diff-filter=U | cut -f2 ; }; git add `f`
pager.log=diff-highlight | less -F -X
pager.show=diff-highlight | less -F -X
pager.diff=diff-highlight | less -F -X
push.default=simple
core.editor=/usr/bin/vim
core.excludesfile=/Users/doortts/.gitignore_global
rerere.enabled=true
pull.rebase=true
```

참고로 diff-highlight 설치는 http://theunixtoolbox.com/git-diff-highlight/ 를 참고해주세요.