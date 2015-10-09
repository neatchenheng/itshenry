基于GIT的SCM(软件配制管理)
=====

# 写在前面的话

考虑到通常情况下都需要团队协作,我们将再使用gerrit来做为中心版本库.

# 主要包含两类分支,即主要分支和辅助分支.

## 1) 主要分支
包括master分支和develop分支

### 1.1) master分支
主分支(master)获得的都是处于可发布状态的代码.

### 1.2) develop分支
开发分支(develop)应该总能够获得最新开发进展的代码.

## 2) 辅助分支
可选,但如果是多团队协作时,推荐使用.主要包括Feature分支, Release分支,
Hotfix分支

### 2.1) Feature分支
用于开发一个独立的新功能.
起源于develop分支.
```
git checkout -b feature-001 develop
```
最终也会归于develop分支(也可能会丢弃)
```
git checkout devleop
git merge --no-ff feature-001
git branch -d feature-001
git review origin develop #git push origin develop
```

### 2.2) Release分支
用于负责短期的发布前准备工作,小bug的修复工作,版本号等元信息的准备工作.产生分支的最好时机是“develop”分支已经基本到达预期的状态.

起源于develop分支.
```
git checkout -b release-1.0 develop
```
最终,需合并回develop分支或master分支.

如需要合并回develop分支
```
git checkout develop
git merge --no-ff release-1.0
```
合并回master并加版本标签
```
git checkout master
git merge --no-ff release-1.0
git tag -a 1.0
git branch -d release-1.0
```

### 2.3) Hotfix分支
类似于“Release branch”，但产生此分支是为修复非预期的关键BUG.

源于master分支
```
git checkout -b hotfix-1.0.1 master
```
修复bug后,需要合并回master分支和develop分支
```
git checkout master
git merge --no-ff hotfix-1.0.1
git tag -a 1.0.1
git checkout develop
git merge --no-ff hotfix-1.0.1
git branch -d hotfix-1.0.1
```

### 2.4) 提交tag到中心库
```
e.g.:
git push ssh://{username}@{gerrit.host}:29418/{project} tag v0.2

or

git push origin HEAD:refs/tags/v0.1
```

# 本地版本库

## 1) 远程版本库信息
```
git remote show [origin|gerrit]
```

## 2) 删除不一致的分支
```
git fetch -p

or

git remote prune [origin|gerrit]
```

## 3) 缓存用户名密码
```
git config credential.helper store

**此时再调用相应的git命令,会再提示输入用户名或密码,但同时也会在local以明文的形式记录在主目录下(~/.git-credentials)**
```
