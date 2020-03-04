"显示行号
set number

"语法高亮
syntax on

"显示下划线
set cursorline

"搜索结果高亮显示(hight line search)
se hlsearch

"动态显示搜索结果
set incsearch

"搜索结果智能大小写（搜索大写只能搜索大写，搜索小写，大小写都显示）
set smartcase

"搜索结束后，高亮显示关闭(快捷键)：(<LEADER>默认为\（反斜杠))
noremap <LEADER><CR> :nohlsearch<CR>

set showmode

"在窗口下方展示当前执行的命令
set showcmd

"使用鼠标

" 普通模式
"v 可视模式
"i 插入模式
"c 命令行模式
"h 在帮助文件里，以上所有的模式
"a 以上所有的模式
set mouse=a

set t_Co=256

filetype indent on

set autoindent

set showmatch

"高亮显示搜索
set hlsearch

"自动换行(不超过当前窗口大小)
set wrap"

"ESC快捷键为jk
imap jk <Esc>
imap JK <Esc>

"中文括号改成英文括号,中文冒号改成英文冒号,书引号改成单引号,小括号修改
imap （ (
imap ） )
imap ： :
"imap 《 <
"imap 》 >
imap …… ^

"删除键可以删除到上一行
set backspace=2

"插件=================================================
call plug#begin('~/.vim/plugged')

"vim-latex
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

"UltiSnips
Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

"vim-markdown-preview
Plug 'iamcco/markdown-preview.vim'
Plug 'iamcco/mathjax-support-for-mkdp'
"设置打开md文件自动打开chrome预览(只在打开的时候执行一次)
"let g:mkdp_auto_start = 1

call plug#end()

"======================================================
"按<F5>运行python代码
map <F5> :call CompileRunGcc()<CR>
    func! CompileRunGcc()
        exec "w"
if &filetype == 'c'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'cpp'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'java'
            exec "!javac %"
            exec "!time java %<"
elseif &filetype == 'sh'
            :!time bash %
elseif &filetype == 'python'
            exec "!time python %"
elseif &filetype == 'html'
            exec "!firefox % &"
elseif &filetype == 'go'
    "        exec "!go build %<"
            exec "!time go run %"
elseif &filetype == 'mkd'
            exec "!~/.vim/markdown.pl % > %.html &"
            exec "!firefox %.html &"
endif
    endfunc

"退出插入模式，推出fcitx
"##### auto fcitx  ###########
let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set ttimeoutlen=150
"退出插入模式
autocmd InsertLeave * call Fcitx2en()
"进入插入模式
autocmd InsertEnter * call Fcitx2zh()
"##### auto fcitx end ######


