# vim 命令及使用技巧
**maning 20160414**

## 1. vim简介及设计理念说明： {{{1

### 1.1 vim简介
+ (1)可以用于在任何类型的终端上编辑各式各样的文件。
+ (2)Vim是一个高度可定制的文本编辑器，在Vi的基础上改进和增加了很多特性。
+ (3)VIM是纯粹的自由软件。
+ (4)Vim和Emacs同样都是非常优秀的文本编辑器。
+ (5)终端敲入vimtutor, 调用vim辅导(tutor)教程
+ (6)终端输入man vim , 查看Manual page
+ (7)ctrl+c=ESC
	尽可能少的呆在插入模式里面，VIM 的强大之处在于他的命令模式。

### 1.2 vim的设计理念是组合:
	+ (a)命令组合(普通模式命令):<br/>
	`dd`  删除当前行，<br/>
	`dj`  删除当前行和下一行<br/>
	`d^`  删除行首到光标前的内容(不包含光标);<br/>
	`d$`  删除光标到行尾的内容(包含光标);<br/>
		> 原理是第一个d含义是删除,j键代表移动到下一行
		> 指定命令重复次数，2dd（重复dd两次），和dj效果一样。

	+ (b)模式间的组合:

### 1.3 在普通模式进入插入模式:
	`a`（append/追加）:当前光标后插入
	`i`（insert/插入）:当前光标前插入


--------------------------------------------------------------------------------
## 2. 基本命令 {{{1

### 2.1 vi编辑器的启动与退出 {{{2

#### 2.1.1 vi的启动
	启动vi后，会进入一个临时缓冲区，

	文件存在，将其拷贝到一个临时缓冲区。
	文件不存在，将建立此文件；

+ (1) `vi` 　进入vi的一个临时缓冲区的首行。
+ (2) `vi file1`           打开文件到首行
+ (3) `vi + file1`         打开文件到最后一行
+ (4) `vi +n file1`        打开文件到n行
+ (5) `vi +/string file1`  打开文件到字符串string首次出现的位置
+ (6) `vi -O file1 file2 ...`   以竖直分割窗口打开多个文件
`vi -o file1 file2 ...`   以水平分割窗口打开多个文件

#### 2.1.2 退出vi(底行模式（last line mode）)
`<Esc>+:命令`<br/>
退出vi前，先按ESC键，确保处于普通模式，再键入“：”(冒号)，输入下列命令，退出vi。

+ (1) `:w`          保存<br/>
		`:w filename`     存入指定文件<br/>
		`:q`              退出<br/>
+ (2) `:wq`         保存后退出。文件未被修改，会更新时间戳
+ (3) `:x` 或 `ZZ`    保存后退出。:x 文件未被修改，不会更新时间戳
+ (4) `:q!`(或`:quit`) 　　不保存,强制退出

### 2.2 查看文件
+ (1) 只读形式打开文件：
		`vim -R file`
+ (2) 强制避免对文件进行修改：
		`vim -M file`

### 2.3 base command
+ `q:` comand line <br/>
+ `J` combine two rows<br/>
+ `D` delete to the end of line<br/>

1. Scrolling downwards					*scroll-down*<br/>
`ctrl-e`<br/>
`ctrl-f`<br/>
2. Scrolling upwards					*scroll-up*<br/>
`ctrl-y`<br/>
`ctrl-u`<br/>
`ctrl-b`<br/>
3. Scrolling relative to cursor				*scroll-cursor*<br/>

- `z<CR>` Redraw, cursor line at top of window. Put cursor at first non-blank in the line.<br/>
- `zt` Like "z<CR>", but leave the cursor in the same column.<br/>
- `z.` Redraw, cursor line at center of window. Put cursor at first non-blank in the line. <br/>
- `zz` Like "z.", but leave the cursor in the same column.<br/>
Careful: If caps-lock is on, this command becomes<br/>
"ZZ": write buffer and exit!<br/>
- `z-` Redraw, cursor line at bottom of window. Put cursor at first non-blank in the line.<br/>
- `zb` Like "z-", but leave the cursor in the same column.<br/>

+ `VISUAL mode + ctrl+g` -> SELECT mode<br/>
+ `Q` Switch to "Ex" mode.  Use the `:vi` command `:visual` to exit "Ex" mode.

### 2.4 多标签切换|窗口拆分-tabnew

**usage:**<br/>
`:tabnew [++opt选项] [+cmd] 文件`		建立对指定文件新的tab<br/>
`:tabc`      关闭当前的tab<br/>
`:tabo`      关闭所有其他的tab<br/>
`:tabs`      查看所有打开的tab<br/>
`:tabp`      前一个<br/>
`:tabn`      后一个<br/>

**标准模式下：**
`gt` , `gT` 可以直接在tab之间切换。

:h table

--------------------------------------------------------------------------------
## 3. 使用技巧 {{{1

### 3.1 vimgrep和quickfix列表: {{{2
#### 3.1.1 在文件及目录中查找字符串:
	+ (1)在所有打开的文件中查找字符串
	+ (2)在某一个目录及它的子目录中查找

在路径和文件名符合{file}的所有文件中,查找符合{pattern}的字符串：<br/>
`:vim(grep)     /{pattern}/[g][j]     {file} ...`<br/>

参数:<br/>
g:    查找所有的关键字;	缺省,只查找一次关键字<br/>
j:    只更新结果列表(quickfix); 缺省，VIM跳转至第一个关键字所在的文件<br/>
查找时，{pattern}可用正则表达式,使用起来和'/'命令是一样的.
用grep同样可以达到这个效果,用vimgrep与系统无关,能适用于所有系统的VIM,而且能<br/>
	自动识别文件编码和换行。

#### 3.1.2 quickfix使用：
	`:cw` 或 `:copen`    打开quickfix列表查看结果，回车打开对应文件<br/>
	`:cclose`    关闭quickfix<br/>
	`:cc`    转到当前查找到的位置<br/>
	`:cn`    转到下一个位置<br/>
	`:cp`    转到前一个位置<br/>


例如：<br/>
1 在当前目录下的扩展名为php的所有文件中,查找字符串"the menu".<br/>
`:vimgrep /the menu/ *.php`

2 在当前目录下的includes目录的所有文件中,查找字符串"the menu".<br/>
`:vimgrep /the menu/ ./includes/*.*`

3 在当前目录及其子目录中查找：<br/>
`:vimgrep /the menu/ **/*.*`

### 3.2 buffers 切换:{{{2

#### 3.2.1 同时打开多个文件：
  `vim test1 test2 test3`
+ 可用 `:o` 继续打开文件<br/>
  `:o test4`

#### 3.2.2 查看当前buffer中的文件列表:
	`:buffers`
	`:ls`
	`:files`

+ 缓冲文件的状态：<br/>
	\-   非活动的缓冲区<br/>
	a   当前被激活缓冲区<br/>
	h   隐藏的缓冲区<br/>
	%   当前的缓冲区<br/>
	\#   交换缓冲区<br/>
	=   只读缓冲区<br/>
	\+   已经更改的缓冲区<br/>

#### 3.2.3 切换缓冲区:
+ 方式1:<br/>
  先用`:buffers` 查看所有的缓冲区，<br/>
  然后使用`:buffer 编号`或者`:buffer 文件名`切换：<br/>
  `:buffer 1`<br/>
  `:buffer test1`<br/>
+ 方式2:<br/>
  切换上一个或下一个缓冲区，切换到第一个和最后一个缓冲区。文件比较少的时候<br/>
  `:bn[ext`]<br/>
  `:bp[revious]`<br/>
  `:bl[ast]`<br/>
  `:bf[irst]`<br/>

#### 3.2.4 维护缓冲区:
维护一个简洁的缓冲区:<br/>
(1)删除和当前工作不相关的缓冲区，<br/>
(2)手动把和当前工作相关的文件加入到缓冲区：<br/>

`:badd test5`<br/>
`:bd[elete] test4`<br/>
添加一个名为test5的缓冲区，删除缓冲区test4。<br/>

#### 3.2.5 bufexplorer插件:
bufexplorer提供了一些替换上面命令的快捷键，并且提供了一个窗口，可以选择、删除缓冲区。<br/>

### 3.3 基本计算器:
插入模式下，按下`ctrl+r+=`,输入一个算式，按enter,显示计算结果<br/>

### 3.4 查找重复的连续单次:
`/\(\<\w\+\>\)\_s*\1`

### 3.5 忘记用root方式打开文件时的文件保存:
`:w !sudo tee %`

### 3.6
+ 删除标记内部的文字:<br/>
  `di[标记]`<br/>
  比如，光标放在开始的圆括号上，`di(`<br/>
  类似的`di{` `di"`<br/>

+ 删除指定标记前的内容：<br/>
  `dt[标记]`<br/>
  会删除所有光标和标记之间的内容（标记保持）<br/>
  例如，`dt.` 会删除至句子末尾，保持'.'不动<br/>

### 3.7 把vim 变为十六进制编辑器:
`:%!xxd`<br/>
恢复原来的状态:<br/>
`:%!xxd -r`<br/>

### 3.8 把当前文件转化为网页:
`:TOhtml`<br/>

### 3.9 删除匹配的行
+ 删除包含特定字符的行：<br/>
  `g/pattern/d`<br/>

+ 删除不包含指定字符的行：<br/>
  `v/pattern/d`<br/>
  `g!/pattern/d`<br/>

+ 删除指定的行：<br/>
  `:x,.d` #从ｘ行删除到当前行；<br/>
  `:.,xd` #从当前行删除到x行；<br/>
  `:x,.+3d` #从x行删除到当前行后第三行；<br/>
  `:x,.-1d` #从x行删除到当前行前一行。<br/>

### 3.10 显示TAB键以及空格等：
`set list!`<br/>

`:help indent.txt`

## 4 Vim 有什么奇技淫巧？{{{2
### 4.1 vim参数：
`vim -b` 用二进制打开<br/>
`vim +number`  打开并定位到底nunber行<br/>
`vimdiff  a.txt b.txt` 比对文件<br/>

### 4.2 insert模式下：
`ctrl + [` ，或者`ctrl+c`实现ESC功能<br/>
`crtl+d` `ctrl+t` 左右缩进<br/>
`ctrl + x + i` 行补齐<br/>
`ctrl + x + f` 文件路径补齐<br/>
`ctrl + w` 删除word<br/>
`ctrl + u` 重新编辑本行<br/>

### 4.3 命令模式：
`g+ctrl+g` 字节统计<br/>
`ctrl + v` 块选择，可以用来给代码多行注释<br/>

`gd` 跳转到局部定义<br/>
`gf` 跳转到文件<br/>
`ctrl + o` 跳转到上一位置<br/>
`ctrl + i` 跳转下一位置（和ctrl + o配合在代码间跳转）<br/>
`K`    查询系统函数（unix、linux），在linux系统函数上用K跳转到man查询页面<br/>
`ctrl + ]`  跳转到定义<br/>
`<<` 左缩进<br/>
`>>` 右缩进<br/>

### 4.4 底行命令模式：
`:r !pwd` 输入当前路径<br/>
`:!cmd` 执行shell的命令<br/>
`:%!xxd` 转换16进制<br/>
`:set list` 显示不可见字符<br/>
`:set fileencoding` 设置编码<br/>
`:set spell` 拼写检查<br/>
`:set scrolloff=3`  滚动<br/>
`:set cursorline` 水平线<br/>
`:set incsearch` 增量搜索<br/>
