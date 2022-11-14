" /etc/vimrc (configuration file for vim only)
" author: Klaus Franken     <kfr@suse.de>
" author: Werner Fink       <werner@suse.de> 
" author: Florian La Roche  <florian@suse.de> 
" version: 06/11/2011
" commented lines start with `"'

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


"set mouse=a
set completeopt=longest,menu
set term=xterm
set t_Co=256
set number
set sw=2
set tabstop=4
set expandtab
set shiftwidth=4
set cindent
set smartindent
set autoindent
set backspace=indent,eol,start  "" set backspace

"" Display
set paste
"set cursorline    "" highlight the current line
set showcmd



function! SKEL_spec()
        0r /usr/share/vim/current/skeletons/skeleton.spec
        language time en_US
        if $USER != ''
            let login = $USER
        elseif $LOGNAME != ''
            let login = $LOGNAME
        else
            let login = 'unknown'
        endif
        let newline = stridx(login, "\n")
        if newline != -1
            let login = strpart(login, 0, newline)
        endif
        if $HOSTNAME != ''
            let hostname = $HOSTNAME
        else
            let hostname = system('hostname -f')
            if v:shell_error
                let hostname = 'localhost'
            endif
        endif
        let newline = stridx(hostname, "\n")
        if newline != -1
            let hostname = strpart(hostname, 0, newline)
        endif
        exe "%s/specCURRENT_YEAR/" . strftime("%Y") . "/ge" 
        exe "%s/specRPM_CREATION_DATE/" . strftime("%a\ %b\ %d\ %Y") . "/ge"
        exe "%s/specRPM_CREATION_AUTHOR_MAIL/" . login . "@" . hostname . "/ge"
        exe "%s/specRPM_CREATION_NAME/" . expand("%:t:r") . "/ge"
        setf spec
endfunction

" enable syntax highlighting
syntax on

set hls

" automatically indent lines (default)
" set noautoindent

" select case-insenitiv search (not default)
" set ignorecase

" show cursor line and column in the status line
set ruler

" show matching brackets
set showmatch

" display mode INSERT/REPLACE/...
set showmode

" changes special characters in search patterns (default)
" set magic

" Required to be able to use keypad keys and map missed escape sequences
set esckeys

" get easier to use and more user friendly vim defaults
" CAUTION: This option breaks some vi compatibility. 
"          Switch it off if you prefer real vi compatibility
set nocompatible

" allow backspacing over everything in insert mode 
set backspace=indent,eol,start

" Complete longest common string, then each full match
" enable this for bash compatible behaviour
" set wildmode=longest,full

" Try to get the correct main terminal type
if &term =~ "xterm"
    let myterm = "xterm"
elseif &term =~ "screen"
    let myterm = "screen"
else
    let myterm =  &term
endif
let myterm = substitute(myterm, "cons[0-9][0-9].*$",  "linux", "")
let myterm = substitute(myterm, "cons[0-9][0-9].*$",  "linux", "")
let myterm = substitute(myterm, "vt1[0-9][0-9].*$",   "vt100", "")
let myterm = substitute(myterm, "vt2[0-9][0-9].*$",   "vt220", "")
let myterm = substitute(myterm, "\\([^-]*\\)[_-].*$", "\\1",   "")

" Here we define the keys of the NumLock in keyboard transmit mode of xterm
" which misses or hasn't activated Alt/NumLock Modifiers.  Often not defined
" within termcap/terminfo and we should map the character printed on the keys.
if myterm == "xterm" || myterm == "kvt" || myterm == "gnome"
    " keys in insert/command mode.
    map! <ESC>Oo  :
    map! <ESC>Oj  *
    map! <ESC>Om  -
    map! <ESC>Ok  +
    map! <ESC>Ol  ,
    map! <ESC>OM  
    map! <ESC>Ow  7
    map! <ESC>Ox  8
    map! <ESC>Oy  9
    map! <ESC>Ot  4
    map! <ESC>Ou  5
    map! <ESC>Ov  6
    map! <ESC>Oq  1
    map! <ESC>Or  2
    map! <ESC>Os  3
    map! <ESC>Op  0
    map! <ESC>On  .
    " keys in normal mode
    map <ESC>Oo  :
    map <ESC>Oj  *
    map <ESC>Om  -
    map <ESC>Ok  +
    map <ESC>Ol  ,
    map <ESC>OM  
    map <ESC>Ow  7
    map <ESC>Ox  8
    map <ESC>Oy  9
    map <ESC>Ot  4
    map <ESC>Ou  5
    map <ESC>Ov  6
    map <ESC>Oq  1
    map <ESC>Or  2
    map <ESC>Os  3
    map <ESC>Op  0
    map <ESC>On  .
endif

" xterm but without activated keyboard transmit mode
" and therefore not defined in termcap/terminfo.
if myterm == "xterm" || myterm == "kvt" || myterm == "gnome"
    " keys in insert/command mode.
    map! <Esc>[H  <Home>
    map! <Esc>[F  <End>
    " Home/End: older xterms do not fit termcap/terminfo.
    map! <Esc>[1~ <Home>
    map! <Esc>[4~ <End>
    " Up/Down/Right/Left
    map! <Esc>[A  <Up>
    map! <Esc>[B  <Down>
    map! <Esc>[C  <Right>
    map! <Esc>[D  <Left>
    " KP_5 (NumLock off)
    map! <Esc>[E  <Insert>
    " keys in normal mode
    map <ESC>[H  0
    map <ESC>[F  $
    " Home/End: older xterms do not fit termcap/terminfo.
    map <ESC>[1~ 0
    map <ESC>[4~ $
    " Up/Down/Right/Left
    map <ESC>[A  k
    map <ESC>[B  j
    map <ESC>[C  l
    map <ESC>[D  h
    " KP_5 (NumLock off)
    map <ESC>[E  i
    set t_Co=256

endif

" xterm/kvt but with activated keyboard transmit mode.
" Sometimes not or wrong defined within termcap/terminfo.
if myterm == "xterm" || myterm == "kvt" || myterm == "gnome"
    " keys in insert/command mode.
    map! <Esc>OH <Home>
    map! <Esc>OF <End>
    map! <ESC>O2H <Home>
    map! <ESC>O2F <End>
    map! <ESC>O5H <Home>
    map! <ESC>O5F <End>
    " Cursor keys which works mostly
    " map! <Esc>OA <Up>
    " map! <Esc>OB <Down>
    " map! <Esc>OC <Right>
    " map! <Esc>OD <Left>
    map! <Esc>[2;2~ <Insert>
    map! <Esc>[3;2~ <Delete>
    map! <Esc>[2;5~ <Insert>
    map! <Esc>[3;5~ <Delete>
    map! <Esc>O2A <PageUp>
    map! <Esc>O2B <PageDown>
    map! <Esc>O2C <S-Right>
    map! <Esc>O2D <S-Left>
    map! <Esc>O5A <PageUp>
    map! <Esc>O5B <PageDown>
    map! <Esc>O5C <S-Right>
    map! <Esc>O5D <S-Left>
    " KP_5 (NumLock off)
    map! <Esc>OE <Insert>
    " keys in normal mode
    map <ESC>OH  0
    map <ESC>OF  $
    map <ESC>O2H  0
    map <ESC>O2F  $
    map <ESC>O5H  0
    map <ESC>O5F  $
    " Cursor keys which works mostly
    " map <ESC>OA  k
    " map <ESC>OB  j
    " map <ESC>OD  h
    " map <ESC>OC  l
    map <Esc>[2;2~ i
    map <Esc>[3;2~ x
    map <Esc>[2;5~ i
    map <Esc>[3;5~ x
    map <ESC>O2A  ^B
    map <ESC>O2B  ^F
    map <ESC>O2D  b
    map <ESC>O2C  w
    map <ESC>O5A  ^B
    map <ESC>O5B  ^F
    map <ESC>O5D  b
    map <ESC>O5C  w
    " KP_5 (NumLock off)
    map <ESC>OE  i
endif

if myterm == "linux"
    " keys in insert/command mode.
    map! <Esc>[G  <Insert>
    " KP_5 (NumLock off)
    " keys in normal mode
    " KP_5 (NumLock off)
    map <ESC>[G  i
endif

if myterm == "screen"
    map! <ESC>[1;2D <S-Left>
    map! <ESC>[1;2C <S-Right>
    map! <ESC>[1;2A <S-Up>
    map! <ESC>[1;2B <S-Down>
    map! <ESC>[1;2H <Home>
    map! <ESC>[1;2F <End>
    map! <ESC>[2;2~ <Insert>
    map! <ESC>[3;2~ <Delete>
    map! <ESC>[5;2~ <PageUp>
    map! <ESC>[6;2~ <PageDown>
    map! <ESC>[1;5D <C-Left>
    map! <ESC>[1;5C <C-Right>
    map! <ESC>[1;5A <C-Up>
    map! <ESC>[1;5B <C-Down>
    map! <ESC>[1;5H <Home>
    map! <ESC>[1;5F <End>
    map! <ESC>[2;5~ <Insert>
    map! <ESC>[3;5~ <Delete>
    map! <ESC>[5;5~ <PageUp>
    map! <ESC>[6;5~ <PageDown>
    map! <ESC>[1;3D <A-Left>
    map! <ESC>[1;3C <A-Right>
    map! <ESC>[1;3A <A-Up>
    map! <ESC>[1;3B <A-Down>
    map! <ESC>[1;3H <Home>
    map! <ESC>[1;3F <End>
    map! <ESC>[2;3~ <Insert>
    map! <ESC>[3;3~ <Delete>
    map! <ESC>[5;3~ <PageUp>
    map! <ESC>[6;3~ <PageDown>
endif

" This escape sequence is the well known ANSI sequence for
" Remove Character Under The Cursor (RCUTC[tm])
map! <Esc>[3~ <Delete>
map  <ESC>[3~    x

" Only do this part when compiled with support for autocommands. 
if has("autocmd") 
  " When editing a file, always jump to the last known cursor position. 
  " Don't do it when the position is invalid or when inside an event handler 
  " (happens when dropping a file on gvim). 
  autocmd BufReadPost * 
    \ if line("'\"") > 0 && line("'\"") <= line("$") | 
    \   exe "normal g`\"" | 
    \ endif 
 
endif " has("autocmd")

" Changed default required by SuSE security team--be aware if enabling this
" that it potentially can open for malicious users to do harmful things.
set nomodeline

" Skeleton for spec files
autocmd BufNewFile      *.spec  call SKEL_spec()

" get easier to use and more user friendly vim defaults
" /etc/vimrc ends here



if has("cscope")
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    if filereadable("cscope.out")

        cscope add cscope.out

    endif

endif

"if has("cscope")
"set cscopequickfix=s-,c-,d-,i-,t-,e-
"set csprg=/usr/local/bin/cscope
"set csto=0
"set cst
"set nocsverb
"if filereadable("cscope.out")
"cs add cscope.out
"elseif $CSCOPE_DB != ""
"cs add $CSCOPE_DB
"endif
"set csverb
"endif

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>  
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>  
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>  
"let Tlist_Auto_Open = 1 "打开vim自动就显示taglist窗口
let Tlist_Show_One_File = 0 "不同时显示多个文件的tag，只显示当前文件的  
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim  
let Tlist_Use_Right_Window = 0 "在右侧窗口中显示taglist窗口
let Tlist_File_Fold_Auto_Close = 1 "当设置成同时显示多个文件的tag时，只显示焦点在当前窗口的tag,其他tag自动折叠
let Tlist_GainFocus_On_ToggleOpen = 1 "打开Tlist是，焦点在此。
let Tlist_WinWidth=25



" configuration for minibufexpl plugin
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplMoreThanOne=0

let g:winManagerWindowLayout='FileExplorer'
noremap <F2> :WMToggle<CR>

"NERDTree show right
"let NERDTreeWinPos=1 
let NERDTreeWinSize=20

"zi dong bu quan
filetype plugin indent on


noremap <F10> :Tlist<CR>
noremap <F11> :NERDTreeToggle<CR>
noremap se :set hlsearch<CR>
noremap sen :set nohlsearch<CR>
noremap ms :set mouse=a<CR>
noremap msn :set mouse=""<CR>

"ctrl+w nmap
nmap ww <C-W>

"ctrl+t nmap
nmap tt <C-T>

nmap ff <C-F>
nmap cc <C-B>


" // The switch of the Source Explorer 
nmap  <F8> :SrcExplToggle<CR> 

" // Set the height of Source Explorer window 
let g:SrcExpl_winHeight = 5 

" // Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 100 

" // Set "Enter" key to jump into the exact definition context 
let g:SrcExpl_jumpKey = "<ENTER>" 

" // Set "Space" key for back from the definition context 
let g:SrcExpl_gobackKey = "<C-H>" 

let g:SrcExpl_searchLocalDef = 1 

let g:SrcExpl_isUpdateTags = 0 

let g:SrcExpl_updateTagsKey = "<F12>" 

let g:SrcExpl_prevDefKey = "<F3>" 

let g:SrcExpl_nextDefKey = "<F4>"


" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 0




"***********************************************PYTHON*****************
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" python.vim
" Python syntax highlighting script for Vim
" For full syntax highlighting:
let python_highlight_all=1

" the prefix key
" May be in use: nnoremap <leader>d dd
let mapleader = ","

" Insert mode abbreviations
iabbrev pyh1 #!/usr/bin/env python
iabbrev pyh2 # -*- coding: utf-8 -*-
iabbrev pyh #!/usr/bin/env python<cr># -*- coding: utf-8 -*-
iabbrev pytodo # TODO ----------
iabbrev pymain if __name__ == "__main__":
iabbrev pyprint~ print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
iabbrev pyprint! print "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
iabbrev pyprint@ print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
iabbrev pyprint# print "##############################"
iabbrev pyprint$ print "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
iabbrev pyprint% print "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
iabbrev pyprint^ print "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
iabbrev pyprint& print "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
iabbrev pyprint* print "******************************"
iabbrev pyprint= print "=============================="
iabbrev pyprint- print "------------------------------"
iabbrev pyprint+ print "++++++++++++++++++++++++++++++"

" Autocommands(autocmd)
" Comment out the line for python file.
autocmd FileType python nnoremap <leader>c I#<esc>
autocmd FileType python :iabbrev <buffer> iff if:<left>

" Color scheme
" colorscheme torte
colorscheme desert

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
au BufRead,BufNewFile *py,*pyw,*.c,*.h,*html,*js,*.go set tabstop=8

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" C: tabs (pre-existing files) or 4 spaces (new files)
au BufRead,BufNewFile *.py,*pyw,*.html,*.js,*.go set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw,*.html,*.js,*.go set expandtab
fu Select_c_style1()
    if search('^\t', 'n', 150)
        set shiftwidth=8
        set noexpandtab
    el
        set shiftwidth=4
        set expandtab
    en
endf
au BufRead,BufNewFile *.c,*.h call Select_c_style1()
au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw,*.go match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*go match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: No limit
" C: 79
" Uncomment this if you want to limit your textwidth in python
" can be very annoying ..
" au BufRead,BufNewFile *.py,*.pyc set textwidth=79
au BufRead,BufNewFile *.c,*.h set textwidth=79

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" C: yes
au BufNewFile *.py,*.pyw,*.c,*.h,*.go set fileformat=unix

" Set the default file encoding to UTF-8:
set encoding=utf-8

" Automatically indent based on file type:
filetype plugin indent on
" Keep indentation level from previous line:
"set autoindent

" pathogen.vim Manage your 'runtimepath' with ease. In practical terms,
" pathogen.vim makes it super easy to install plugins and runtime files,
" in their own private directories.
" any plugins you wish to install can be extracted to a subdirectory
" under ~/.vim/bundle, and they will be added to the 'runtimepath'.

" setlocal tabstop=4
set softtabstop=4
" always show the status bar
set laststatus=2
" set cursorline

highlight Search ctermfg=0 ctermbg=149 guifg=#000000 guibg=#afdf5f
