" .vimrc - Vim configuration file.
"
" Copyright (c) 2013 sky8336. All Rights Reserved.
"
" Maintainer: sky8336 <1919592995@qq.com>
"    Created: 2013-06-28
"    Install: online
"------------------------------
" LastChange: 2019-09-04
"    Version: v0.2.45
" major.minor.patch-build.desc (linux kernel format)
"""""""""""""""""""""""""""""""""""""""""""""""""""""


" GENERAL SETTINGS: {{{1
" To use VIM settings, out of VI compatible mode.{{{2
set nocompatible
" Enable file type detection.{{{2
" filetype plugin indent on
filetype on
" Syntax highlighting.{{{2
syntax enable
syntax on "syntax highlighting on

filetype plugin on
au BufRead,BufNewFile *.txt setlocal ft=txt "syntax highlight for txt

" Setting colorscheme{{{2
color mycolor
"colorscheme nslib_color256
if &diff
	"colorscheme blue
	"colorscheme default
	"colorscheme murphy
	"colorscheme peachpuff
	"colorscheme ron
	"colorscheme torte
	"colorscheme elflord
	"colorscheme industry
endif

" termdebug setting {{{2
let g:termdebug_wide = 163

" Other settings.{{{2
set autoindent
set autoread
set autowrite
set background=dark
" make backspaces more powerfull
set backspace=indent,eol,start
set nobackup
set cindent " enable specific indenting for C code
set cinoptions=:0
"set cinoptions+=j1,(0,ws,Ws " enable partial c++11 (lambda) support
" Avoiding "visibility" modifiers indenting in C++
" public, namespace,
set cinoptions+=g0,N-s
"set cinoptions+=L0 "tell vim not to de-indent labels
"set cursorcolumn
set cursorline
set completeopt=longest,menuone
set noexpandtab
set fileencodings=utf-8,gb2312,gbk,gb18030
set fileformat=unix
set foldenable
set foldmethod=marker
set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=l
set helpheight=10
set helplang=cn
set hidden
set history=100
set hlsearch
set ignorecase
set incsearch
set laststatus=2 "show the status line
set statusline+=[%1*%M%*%-.2n]%.62f%h%r%=\[%-4.(%P:%LL,%c]%<%{fugitive#statusline()}\[%Y\|%{&fenc}\]%)
set mouse=a
set number
set rnu
set pumheight=10
set ruler
set scrolloff=2
set shiftwidth=4
set showcmd
set smartindent
set smartcase
set tabstop=4
set termencoding=utf-8
set textwidth=80
set cc=80 "colorcolumn
set whichwrap=h,l
set wildignore=*.bak,*.o,*.e,*~
set wildmenu
set wildmode=list:longest,full
set wrap
set t_Co=256

" splitting a window will put the new window below the currentone
" splitting a window will put the new window right of the current on
" set splitbelow
" set splitright

" sky8336's vim {{{1
" setTitle.vim {{{2
if filereadable(expand("$HOME/.vim/sky8336/setTitle.vim"))    " 判断文件是否存在"
	"echo 'setTitle.vim is exists'
	execute 'source ~/.vim/sky8336/setTitle.vim'
else
	"echo 'setTitle.vim is not exists'
endif

" gen_load_Ctags_Cscope.vim {{{2
if filereadable(expand("$HOME/.vim/sky8336/gen_load_Ctags_Cscope.vim"))    " 判断文件是否存在"
	"echo 'gen_load_Ctags_Cscope.vim is exists'
	execute 'source ~/.vim/sky8336/gen_load_Ctags_Cscope.vim'
else
	"echo 'gen_load_Ctags_Cscope.vim is not exists'
endif

" stripTrailing.vim {{{2
if filereadable(expand("$HOME/.vim/sky8336/stripTrailing.vim"))    " 判断文件是否存在"
	"echo 'stripTrailing.vim is exists'
	execute 'source ~/.vim/sky8336/stripTrailing.vim'
else
	"echo 'stripTrailing.vim is not exists'
endif

" function_definition: {{{1
" plugin shortcuts {{{2
function! RunShell(Msg, Shell)
	echo a:Msg . '...'
	call system(a:Shell)
	echon 'done'
endfunction

" set statusline color {{{2
" default the statusline to White (black character) when entering Vim
hi StatusLine term=reverse ctermfg=White ctermbg=Black gui=bold,reverse
" 状态栏颜色配置:插入模式品红色，普通模式White
if version >= 700
	"au InsertEnter * hi StatusLine term=reverse ctermbg=3 gui=undercurl guisp=Magenta
	au InsertEnter * hi StatusLine term=reverse ctermfg=DarkMagenta ctermbg=Black gui=undercurl guisp=Magenta
	au InsertLeave * hi StatusLine term=reverse ctermfg=White ctermbg=Black gui=bold,reverse
endif

"" 获取当前路径，将$HOME转化为~,for statusline {{{2
"function! CurDir()
"let curdir = substitute(getcwd(), $HOME, "~", "g")
"return curdir
"endfunction

" show function names in command line{{{2
fun! ShowFuncName()
	let lnum = line(".")
	let col = col(".")
	echohl ModeMsg
	echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
	echohl None
	call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun

""vim窗口的最上面显示当前打开文件的路径和文件名{{{2
"let &titlestring = expand("%:t")
"if &term == "screen"
"set t_ts=^[k
"set t_fs=^[\
"endif
"if &term == "screen" || &term == "xterm"
"set title
"endif
""如果把上面代码中的expand("%:p")换成expand("%:t")将不显示路径只显示文件名。

" 设置跳出自动补全的括号 {{{2
func SkipPair()
	if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == '>' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'
		return "\<ESC>la"
	else
		return "\t"
	endif
endfunc

" Highlight variable under cursor in Vim {{{3
let g:HlUnderCursor=1
let g:no_highlight_group_for_current_word=["Statement", "Comment", "Type", "PreProc"]
function s:HighlightWordUnderCursor()
	let l:syntaxgroup = synIDattr(synIDtrans(synID(line("."), stridx(getline("."), expand('<cword>')) + 1, 1)), "name")

	if (index(g:no_highlight_group_for_current_word, l:syntaxgroup) == -1)
		"exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
		exe exists("g:HlUnderCursor")?g:HlUnderCursor?printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""
	else
		"exe 'match IncSearch /\V\<\>/'
		exe 'match ExtraWhitespace /\s\+$\| \+\ze\t\+\|\t\+\zs \+/'
	endif
endfunction

" function_definition end
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SHORTCUT_SETTINGS: mapleader{{{1
" Set mapleader
let mapleader=","
" SHORTCUT_SETTINGS end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sky8336's vim {{{1
" sky8336: plugin.vim {{{2
if filereadable(expand("$HOME/.vim/sky8336/plugin.vim"))    " 判断文件是否存在"
	"echo 'plugin.vim is exists'
	execute 'source ~/.vim/sky8336/plugin.vim'
	"let plugin_loaded = 1
else
	"let plugin_loaded = 0
	"echo 'plugin.vim is not exists'
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SHORTCUT_SETTINGS: 按键映射 key_mappings {{{1
" command line key_mappings {{{2
cmap ,e <ESC>
cmap ,pi PlugInstall
cmap ,gk :call Generate_kernel_tags_cscope()<CR>

" alt key_mappings {{{2
" 设置方法:按下ctrl-v 后，输入alt-想设置的键
" vim-autoformat
nnoremap af :Autoformat<CR>

" vimdiff hot keys {{{2
" if you know the buffer number, you can use hot key like ",2"
" (press comma first, then press two as quickly as possible) to
" pull change from buffer number two.set up hot keys:
map <silent><leader>1 :diffget 1<CR>:diffupdate<CR>
map <silent><leader>2 :diffget 2<CR>:diffupdate<CR>
map <silent><leader>3 :diffget 3<CR>:diffupdate<CR>
map <silent><leader>4 :diffget 4<CR>:diffupdate<CR>

" space key_mappings. {{{2
nnoremap <space>e<CR> :e<CR>
nnoremap <space>w<CR> :w<CR>
nnoremap <space>q<CR> :q<CR>
nnoremap <space>wq :wq<CR>
nnoremap <space>wa :wa<CR>
nnoremap <space>qa :qa<CR>
nnoremap <space>; :
vnoremap <space>; :

nmap  <space>tm :vert terminal<CR>
nmap  <space>td :packadd termdebug<CR>:Termdebug<CR>
" vim-repl key-mapping
nnoremap <space>r<CR> :REPLToggle<Cr>

" Linux Programmer's Manual
" <C-m> is Enter in quickfix window
nmap <space>mm :Man <C-R>=expand("<cword>")<cr><cr>
nmap <space>m2 :Man 2 <C-R>=expand("<cword>")<cr><cr>


" Switching between buffers. {{{2
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

inoremap <C-h> <Esc><C-W>h
inoremap <C-j> <Esc><C-W>j
inoremap <C-k> <Esc><C-W>k
inoremap <C-l> <Esc><C-W>l

" switch to normal
inoremap jk <Esc>
inoremap js <Esc>:w<CR>

if version >= 800
	" [>= vim8.0]]terminal mode key_mappings
	tnoremap <C-h> <C-W>h
	tnoremap <C-j> <C-W>j
	tnoremap <C-k> <C-W>k
	tnoremap <C-l> <C-W>l
endif

" 括号自动补全
inoremap '<TAB> ''<ESC>i
inoremap "<TAB> ""<ESC>i
inoremap <<TAB> <><ESC>i
inoremap (<TAB> ()<ESC>i
inoremap [<TAB> []<ESC>i
inoremap {<TAB> {<CR>}<ESC>O

" 将tab键绑定为跳出括号
inoremap jj <c-r>=SkipPair()<CR>

" alt+key mapping {{{2
" Delete key {{{3
nnoremap d <DELETE>
inoremap d <DELETE>

" insert mode 光标移动 {{{3
" alt + k 插入模式下光标向上移动
imap k <Up>
" alt + j 插入模式下光标向下移动
imap j <Down>
" alt + h 插入模式下光标向左移动
imap h <Left>
" alt + l 插入模式下光标向右移动
imap l <Right>

" "cd" to change to open directory.{{{2
let OpenDir=system("pwd")
nmap <silent> <leader>cd :exe 'cd ' . OpenDir<cr>:pwd<cr>
" F2 ~ F12 按键映射 {{{2
nmap  <leader>f1 :TagbarToggle<CR>

"nmap  <F2> :NERDTreeToggle<cr>
nmap  <F2> :NERDTreeTabsToggle<cr>
nmap  <leader>f2 :NERDTreeTabsToggle<cr>

nmap  <C-\><F2> :NERDTreeTabsFind<CR>
nmap  <leader><F2> :silent! VE .<cr>

"<F3>
nmap  <F3> :exec 'MRU' expand('%:p:h')<CR>
nmap  <leader>f3 :exec 'MRU' expand('%:p:h')<CR>

"<F4> vim-preview
nmap  <F4> :PreviewTag<CR>
nmap  <leader>f4 :PreviewTag<CR>
noremap u :PreviewScroll -1<cr>
noremap d :PreviewScroll +1<cr>
inoremap u <c-\><c-o>:PreviewScroll -1<cr>
inoremap d <c-\><c-o>:PreviewScroll +1<cr>

"the keymap in quickfix window
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>



"------map_f5------
" nmap  <F5>
"
" ,f5 ,;5 ,\5	:	单个文件相关命令
" 设置 ,f5 打开/关闭 Quickfix 窗口
nnoremap <leader>f5 :call asyncrun#quickfix_toggle(6)<cr>
" 编译单个文件
nnoremap <silent><leader>;5 :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" 运行
nnoremap <silent><leader>\5 :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" ,5f ,5; ,5\	:	项目相关命令
" “<root>” 或 “$(VIM_ROOT)”表示项目所在路径，按 ,5f 编译整个项目：
nnoremap <silent><leader>5f :AsyncRun -cwd=<root> make <cr>
" 运行当前项目, makefile 中需要定义怎么 run
nnoremap <silent><leader>5; :AsyncRun -cwd=<root> -raw make run <cr>
" 测试
nnoremap <silent><leader>5\ :AsyncRun -cwd=<root> -raw make test <cr>
"------map_f5------

nmap  <C-F5> :UndotreeToggle<cr>
"nmap  <leader><F5> :execute 'vimgrep //gj '.expand('%:p:h').'/*.c '.expand('%:p:h').'/*.h'

nmap  <F6> :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%:p:h').'/*.c '.expand('%:p:h').'/*.h'<CR>:botright cwindow<CR>
nmap  <leader>f6 :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%:p:h').'/*.c '.expand('%:p:h').'/*.h'<CR>:botright cwindow<CR>

nmap  <C-F6> :vimgrep /<C-R>=expand("<cword>")<cr>/ **/*.c **/*.h<cr><C-o>:botright cwindow<cr>
nmap  <leader><F6> :vimgrep /<C-R>=expand("<cword>")<cr>/
nmap  <C-\><F6> :execute 'vimgrep //gj '.expand('%:p:h').'/*.c '.expand('%:p:h').'/*.h'

" F7
nmap  <F7> :SyntasticCheck<CR>
nmap  <leader>f7 :SyntasticCheck<CR>

nmap  <C-F7> :Errors<CR>
nmap  <leader><F7> :lclose<CR>

" quickfix
nmap  <leader>7f :botright copen 10<CR>

" F8
nmap  <leader>f8 :call Generate_cpp_tags_cscope()<CR>
" load tags which buffer name is ../../other/directory/file
nmap  <leader>8f :call LoadTagsByBufferName()<CR>

" f9
nmap  <F9> :call Generate_fntags_tags_cscope()<CR>
nmap  <leader>f9 :call Generate_fntags_tags_cscope()<CR>
nmap  <leader>9f :call AutoLoadCTagsAndCScope()<CR>

nmap <C-F9> :call AutoLoadCTagsAndCScope()<CR>
nmap <C-\><F9> :CCTreeLoadDB cscope.out<CR>

" F10
nmap <C-F10> :bn<CR>
" F11
nmap <C-F11> :bp<CR>

"cscope 按键映射及说明 {{{2
nmap <leader>sa :cs add cscope.out<cr>
nmap <leader>ss :cs find s <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sg :cs find g <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sc :cs find c <C-R>=expand("<cword>")<cr><cr>
nmap <leader>st :cs find t <C-R>=expand("<cword>")<cr><cr>
nmap <leader>se :cs find e <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>si :cs find i <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>sd :cs find d <C-R>=expand("<cword>")<cr><cr>

"FIXME
nmap <leader>sq :set cscopequickfix=s+,g+,c+,d+,i+,t+,e+,a+<cr>
nmap <leader>nq :set cscopequickfix=<cr>


nmap <leader>vs :vert scs find s <C-R>=expand("<cword>")<cr><cr>
nmap <leader>vg :vert scs find g <C-R>=expand("<cword>")<cr><cr>
nmap <leader>vc :vert scs find c <C-R>=expand("<cword>")<cr><cr>
nmap <leader>vt :vert scs find t <C-R>=expand("<cword>")<cr><cr>
nmap <leader>ve :vert scs find e <C-R>=expand("<cword>")<cr><cr>
nmap <leader>vf :vert scs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>vi :vert scs find i <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>vd :vert scs find d <C-R>=expand("<cword>")<cr><cr>

nmap <leader>fs :cs find s 
nmap <leader>fg :cs find g 
nmap <leader>fc :cs find c 
nmap <leader>ft :cs find t 
nmap <leader>fe :cs find e 
nmap <leader>ff :cs find f 
nmap <leader>fi :cs find i 
nmap <leader>fd :cs find d 
",sa 添加cscope.out库
",ss 查找c语言符号（函数名 宏 枚举值）出现的地方
",sg 查找函数/宏/枚举等定义的位置，类似ctags的功能
",sc 查找调用本函数的函数
",st 查找字符串
",se 查找egrep模式
",sf 查找并打开文件，类似vim的find功能
",si 查找包含本文件的文件
",sd 查找本函数调用的函数

"其他映射 {{{2
nmap <leader>zz <C-w>o
nmap <leader>hm :tabnew ~/.vim/README.md<cr>
nmap <leader>hd :tabnew ~/.vim/my_help/<cr>
",zz  关闭光标所在窗口之外的其他所有窗口
",hm  tab标签页,打开帮助文档README.md
",hd  tab标签页,打开my_help directory，可选择需要帮助文档

" window-resize {{{2
nmap w= :res +15<CR>
nmap w- :res -15<CR>
nmap w, :vertical res +30<CR>
nmap w. :vertical res -30<CR>

nmap <space>wv :vertical res 86<CR>
nmap <space>wh :res 25<CR>

""""""""""""""""""""""""""""""""""""
" {{{2
set noswapfile
"set tags+=/usr/include/tags
set tags+=./tags  "引导omnicppcomplete等找到tags文件
"生成专用于c/c++的ctags文件
map ta :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

""""""""""""""""""""""""""""""
" 编辑文件相关配置 {{{2
""""""""""""""""""""""""""""""
" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>

" 删除行尾空格
nmap cm :%s/\s\+$//<CR>:noh<CR>

" 转换成utf-8格式
nmap cu :set fileencoding=utf-8<CR>:noh<CR>

" 全部缩进(indent)对齐
nmap ci ggVG=

" 复制全部
nmap cy ggVGy

" set mouse mode, see :help mouse
nmap <leader>ma :set mouse=a<cr>
nmap <leader>mv :set mouse=v<cr>

" set paste mode
nmap <leader>p :set paste<cr>
nmap <leader>np :set nopaste<cr>

" define a shortcut key for enabling/disabling highlighting:
nnoremap  <C-\><F3> :exe "let g:HlUnderCursor=exists(\"g:HlUnderCursor\")?g:HlUnderCursor*-1+1:1"<CR>

map \ :call ShowFuncName()<CR>
nmap  <leader>m :MRU
" SHORTCUT_SETTINGS end
""""""""""""""""""""""""""""""
"实现vim和终端及gedit等之间复制、粘贴的设置 {{{1
""""""""""""""""""""""""""""""
" 让VIM和ubuntu(X Window)共享一个粘贴板
set clipboard=unnamedplus " 设置vim使用"+寄存器(粘贴板)，"+寄存器是代表ubuntu的粘贴板。

" AUTO COMMANDS: autocmd_setting {{{1
" VIM退出时，运行xsel命令把"+寄存器中的内容保存到系统粘贴板中;需要安装xsel {{{2
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" 启用每行超过80列的字符提示（背景变black） {{{2
"highlight MyGroup ctermbg=black guibg=black
"au BufWinEnter * let w:m2=matchadd('MyGroup', '\%>' . 80 . 'v.\+', -1)

" Highlight unwanted spaces {{{2
highlight ExtraWhitespace ctermbg=red guibg=red
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t\+\|\t\+\zs \+/

" high light word under cursor {{{2
autocmd CursorMoved * call s:HighlightWordUnderCursor()

" auto expand tab to blanks {{{2
"autocmd FileType c,cpp set expandtab
" Restore the last quit position when open file.{{{2
autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\     exe "normal g'\"" |
			\ endif

" insert time
ab xtime <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
" 不自动添加新的注释行 {{{2
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"colorcolumn
"after entering another window, set cc=80
"before leaving a window, set cc=""
autocmd WinEnter,BufEnter * set cc=80
autocmd WinLeave,BufLeave * set cc=""
