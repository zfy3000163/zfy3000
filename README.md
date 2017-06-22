vim plugin configure
===================

* 方法
    * mv vim ~/.vim
    * cp -a vimrc ~/.vimrc
    * cp -a gitignore ~/.gitignore
      git config --global core.excludesfile ~/.gitignore

* plugs
    * a_h
    * taglist
    * nerdtree
    * srcexpl
    * mark

* configure
    * 函数高亮     编辑/usr/share/vim/vim73/syntax/c.vim，下面三句话放到最后:

        syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
        syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
        hi cFunctions gui=NONE cterm=bold  ctermfg=blue

    * cscope 指定文件夹创建数据库       
    为了方便使用，编写了下面的脚本来更新cscope和ctags的索引文件：

        \#!/bin/sh
        find . -name "*.h" -o -name "*.c" -o -name "*.cc" > cscope.files
        cscope -bkq -i cscope.files
        ctags -R

        这个命令会生成三个文件：cscope.out, cscope.in.out, cscope.po.out。

    * Python代码格式检查
        python格式检查配置，放到/root/.vimrc
              iletype plugin indent on
                        "set autoindent
                                  execute pathogen#infect()
              autocmd BufWritePre * :%s/\s\+$//e

    * Vim记住上一次打开同一文件的位置          
        autocmd BufReadPost *
        \ if line("'\"")>0&&line("'\"")<=line("$") |
        \ exe "normal g'\"" |
        \ endif

* git gitignore文件
    1)批量取消跟踪git文件
       git  update-index  --assume-unchanged  `find ./ngunp -name Makefile |awk "{print $1}"`
    2) git rm --cached FILENAME
       这样就可以了…如果后面跟的是目录就加上个 -r  就行了

    3) git config --global core.excludesfile ~/.gitignore
       你会发现在~/.gitconfig文件中会出现excludesfile = /home/fff/.gitignore
       说明Git把文件过滤规则应用到了Global的规则中/home/fff/.gitignore。
       说明Git把文件过滤规则应用到了Global的规则中


* git 删除远程仓库文件或目录
    git rm -r --cached a/2.txt //删除a目录下的2.txt文件   删除a目录git rm -r --cached a
    git commit -m "删除a目录下的2.txt文件"
    git push

* 自己创建git仓库管理开发版本
    服务器端：
    1.创建git用户名和组
    groupadd git
    useradd -g git -m git
    passwd git
    #可以是其他的用户名

    2.创建一个空的git 仓库
    切换到git用户，
    mkdir /home/git/project.git
    cd 到目录
    git --bare init

    客户端：
    1.切换到非超级用户，然后创建git
    git init
    git add .
    git commit -m ""
    git remote  add origin git@192.168.18.93:/home/git/project.git     #红色git只是用户名，可以是其他的用户
    git remote add 对应的删除语句:      git remote rm origin
    git push origin master


