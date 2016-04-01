
목차
----
- 프로젝트 상황별 개발 workflow 전략 
- 프로젝트에서 세팅하면 좋은 git 환경과 이유들 
- git bisect - git을 이용해서 버그 빨리 찾기 
- Merge or Rebase 
- Commit 잘하기 (Selective commit) 
- Git 내부 구조에 대한 이해와 응용방법들 
 -기타 꿀팁들

과정목적
--------
- GIT를 좀 더 잘 이해해서 불필요한 시간낭비를 막는다
- 잘 쓰면 좋은 이런저런 팁들을 통해 효과적인 개발 작업을 돕는다.


기본(BASIC)
============

매뉴얼읽기 원칙
---------------
- `-` 로 이어진 명령어로 찾는다.
- 예) git branch -> man git-branch


몇가지만 잘해도 됨
------------------
- git add . / git add -u .
- git commit
    - git commit --amend
- git reset --hard
- git stash / git stash pop
- git pull --rebase
    - 충돌?
        - git reset --hard
        - git pull
- git push origin next
    - git push origin mynext:next
- git clean -df

환경도 전략!
-----------
- 기본원칙과 최소 명령어만으로 움직인다.
- 검색하면 다 나온다! (귀찮을 뿐)
- 새로 배운 명령어는 환경변수에 alias로 넣는다. 머릿글자를 사용하는건 좋은 습관
    - shell 로 넣는것과 git alias로 넣는걸 잘 섞자
- 겁낼필요 없다.
    - git reflog

- 좋은 쉘을 갖는다.
    - zsh 추천
    - git remote <tab>
    - git branch --<tab>



**사실 검색해 보면 다 나온다!**
**그럼에도 불구하고...**


GIT 에 대한 몇 가지 유용한 기본 원칙들
--------------------------------------
git의 내부 기본 몇가지 원칙을 알면 여러가지로 편리하다

- git 은 모든걸 파일로 관리한다.
- 모든 것: 파일(파일그대로), 디렉터리(tree, 파일들 + 다른 트리들), 커밋(tree, commit 정보들)
- 이걸 흔히 git object 라고 부른다. 각자 파일이름이 자신의 이름이다.
- .git
- git object 중 commit 은 commit과 linked list 처럼 연결되어 있다.


이걸 알면 무엇을 할 수 있나?
------------------------------
- git clone의 정체를 이해하게 된다
- branch와 commit 간의 이동 이동의 의미를 알게 된다.



프로젝트 상황별 개발 workflow 전략
===================================

**BRANCH (그 모든건 다 브랜치 문제)**

BRANCH를 어떻게 볼 것인가?
--------------------------

- 메인터넌스 브랜치(maintenance branch)
- 개발브랜치 (development branch)
- 주제 브랜치 (topic branch: feature/hotfix)
그외 integration test및 experimental test용 브랜치

- 그냥 팀에 맞게 잘 하는게 중요하다!

그래도 기본 3개 있으면 좋다

- master (최신, 릴리즈및 버전은 여기에서 나간다, stable 브랜치라고도 하자.)
- dev 개발최신 브랜치. 개발자 개인의 테스트나 단위테스트 정도만 된 곳. 통합테스트가 안될 수도 있다. 코드리뷰는 된 상태라고 본다.
- topic branch 각자 작업자들의 작업용 브랜치. feature branch와 hotfix 브랜치로 나눠서 부르기도 한다.

사례들
-------

### 1. git.git
- integration branch of git.git (Graduation)
    - maint
    - master
    - next
    - pu: Throw-away integration

- Rule: Merge upwards
    - 해당 fix가 필요한 가장 오래된 branch에서부터 위쪽으로 적용해 나간다.
    - 정 못하겠으면 cherry-pick으로 downwards 한다

#### 참고
https://git-scm.com/docs/gitworkflows


### 2. 스프링
- 개발시작 기준은 master에서 브랜치를 만드는걸로.
- 브랜치 이름은 JIRA이슈와 일치시킨다. SPR-1234
- maint branch는 버전명으로 관리
    - 4.0.x
    - 4.1.x
- topic 브랜치 이름은 이슈번호를 권장
    - SPR-1231
- merge/cherry-pick 등으로 maintainer가 알아서 잘 끌어감
- commit에 area 를 표시하지 않음
- 이슈번호를 commit body에 기재함

#### 참고
- https://github.com/spring-projects/spring-framework/pull/927
- https://github.com/spring-projects/spring-framework/blob/master/CONTRIBUTING.md



### 3. nodejs
- master에서 진행
- branch로 버전을 관리
- topic 브랜치 제한 없음 (어디서오든 master로 보내면 메인테이너가 알아서잘)
- commit에 area를 표시함
- stability-index를 붙이는걸 권장 
    - https://github.com/nodejs/node/blob/master/doc/api/documentation.markdown#stability-index

- group 대신 - 를 권장되는 분위기 my-feature-branch
- commit은 The first line should be 50 characters or less 를 매우 권장
- Wrap all other lines at 72 columns (git log 표시때문에)

#### 참고
- https://github.com/nodejs/node/blob/v5.1.1/CHANGELOG.md
- https://github.com/nodejs/dev-policy

### 4.기타
- angularjs 
    - https://github.com/angular/angular.js/blob/master/CONTRIBUTING.md#-git-commit-guidelines

branch 접근방식
---------------
- maint 브랜치들은 안 만들면 안 만들수록 좋음
    - git log master..maint
    - git branch v4.1.x maint
- 예를 들면 app store app은 maintenance release를 하지 않음
- long term branch 주의!
    - 작업이 오래걸리는것 같으면 종종 rebase 해준다.


branch name 정하기
------------------
- fix-typo vs fix/typo

.git 확인하기



COMMIT
=======

커밋 가이드라인 (Commit guideline)
-----------------------------------
- http://git-scm.com/book/en/v2/Distributed-Git-Contributing-to-a-Project#Commit-Guidelines
- https://github.com/spring-projects/spring-framework/blob/master/CONTRIBUTING.md#format-commit-messages

> do not check in commented out code or unneeded files


역사조작하기(Rewriting History)
------------
- 원칙: 절대. remote의 history는 조작하지 않기 위해 모든 노력을 기울인다!
- git commit --amend
- git rebase -i
    - word
    - squash
    - pick
    - fix
- git cherry-pick

- wip 커밋 만들기
- 커밋쪼개기 / 합치기
- FETCH_HEAD 잘 이용하기


Selective commit
----------------
- git add --edit

```
DEMO
```

REBASE vs MERGE
----------------

- 로컬에서는 열심히 rebase
- 리모트는 무조건 merge
- Documentatin 을 위한 git merge --no-ff 



Tip & Tricks
============
- 절대 언제로든 돌아갈 수 있으니 겁낼필요 없음 
    - .git만 지우지 말자
- stash 잘쓰자
- git init 만으로는 push 불가능
- 시작할때 README로 시작하는 건 좋은 습관
- 하지만 그것도 싫다면
```
    git commit --allow-empty
```
- Author email 정리하기
```
    git filter-branch -f --commit-filter '
            if [ "$GIT_AUTHOR_EMAIL" = "doortts@gmail.com" ];
            then
                    GIT_AUTHOR_NAME="Suwon Chae";
                    GIT_AUTHOR_EMAIL="sw.chae@navercorp.com";
                    git commit-tree "$@";
            else
                    git commit-tree "$@";
            fi' HEAD
```
    메일같은 경우에는 history를 바꾸는 대신 mailmap 을 사용해도 됨
    https://github.com/spring-projects/spring-framework/blob/master/.mailmap

- 특정 파일만 추가/삭제 하기
```
    git reset conf/*
    git co conf/\*.sql
```
- git reflog
    - 두 가지 이름이 있다. commit id와 HEAD{번호}
- mailmap
- 내 local 에서만 제외하기
```
.git/info/exclude
```
- untract를 제외한 나머지 모두 add (add only modified changes and ignore untracked files )
    git add -u
    혹은 git commit -a

- git에서 일정시간내에 암호 물어보지 않기
```
git config url."https://doortts@github.com".insteadOf "https://github.com"
git config credential.helper 'cache --timeout=604800'
```

- 부모없는 브랜치로 새로 시작하고 싶다
```
    git checkout --orphan
```
- rerere
    - reuse recorded resolution
    - git config --global rerere.enabled true
    - https://git-scm.com/blog/2010/03/08/rerere.html
- git log 등의 명령어를 사용했을때 more page로 나오지 않고 그대로 log로 나와서 터미널에서 보기 좋게 하기 (see following word diff tip)

- git word diff
```
    [pager]
        log = diff-highlight | less -F -X
        show = diff-highlight | less -F -X
        diff = diff-highlight | less -F -X
```
- git co -

- Reverting vs. Resetting
    - https://ru.atlassian.com/git/tutorials/undoing-changes/git-revert

- 특정 원격 브랜치 삭제
    - git push origin local:remote 넣기의 응용
    - git push origin :remote
- git bisect

```
git checkout master
git merge feature-x
git bisect start HEAD c2726cd
git bisect run bash test.sh

--test.sh--
diff a <(echo "Alright, go ahead") > /dev/null
```
- Bare / Non-bare
- Pumbling / porcelain
- 다 내려받기는 좀 그런데...
    - shallow clone
    - git arhive
        git archive master --format=zip --output=../website-12-10-2012.zip
- git clean -fd
- 전체 역사를 돌며 특정 작업을 수행하기
    - git filter-branch --tree-filter 'rm -f a' HEAD

정신세계를 괴롭히는 불필요한 현상과의 싸움
============================================
.gitignore
----------
- 이미 들어간 파일 .gitignore 
    - .gitignore 에만 넣으면 안됨
    - exclude commit을 만들어야 함
- .git/info/exclude
- 이상한 에러?
    - git fsck

불필요한 파일들 정리
--------------------
```
git clean -fd
git clean -n -fd
```
untracked 만 다루니까 겁내지 않아도 됨


생각해볼만한 부분
=================

- one/multiple project one repository?
    - 페이스북의 사례
    - https://code.facebook.com/posts/218678814984400/scaling-mercurial-at-facebook
    - 17 million lines of code and 44,000 files in 2013
- commit에 이슈번호를 남기는 것에 대해

참고
----
- https://github.com/nodejs/node
- https://github.com/git/git
- https://github.com/spring-projects/spring-framework



실습스크립트
=============

```
git init
echo "READ THIS" > README.md
ga .
gc -m "init: Add README.md"
echo "Alright, go ahead" > a
ga .
gc -m "init: Add a"
echo "Beleave your force" > b
ga .
gc -m "module: Add b"
echo "Command and conquer" > c
ga .
gc -m "module: Add c"
echo "Delta compression" > d
ga .
gc -m "module: Add d"

git co -b feature-x
echo "For the future" > f
ga .
gc -m "module: Add f"
echo "Guardians of galaxy" > g
ga .
gc -m "module: Add g"
echo "Heaven must be missing an angel" > h
echo "Alight, go ahead" > a
ga .
gc -m "module: Add h"
echo "I am your father" > i
ga .
gc -m "module: Add i"
echo "Joy to the world" > j
ga .
gc -m "module: Add j"
```

- pick에서 commit 제외하기
- fix 하다 실패한경우
- 다시 f
- 다시 예전으로 돌아가기

