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



