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

"为了能够从vim复制文本到外边，鼠标先禁掉
"set mouse=a

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
