set fileencodings=utf-8,ucs-bom,cp936,big5
set fileencoding=utf-8
" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Remap a few keys for Windows behavior
source $VIMRUNTIME/mswin.vim

" Mouse behavior (the Windows way)
behave mswin

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

set number

syntax on

"下划线
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

set mouse=a

set t_Co=256

filetype indent on

set autoindent

set showmatch

set hlsearch

"自动换行(不超过当前窗口大小)
set wrap"

"ESC快捷键
imap jj <Esc>

"在vim中自动运行python程序

"一键运行代码
function CheckPythonSyntax() 
    let mp = &makeprg 
    let ef = &errorformat 
    let exeFile = expand("%:t") 
    setlocal makeprg=python\ -u  
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m 
    silent make %
    copen 
"   set efm 是设置quickfix的errorformat，以便vim识别  
"  makeprg 是vim内置的编译命令，可以通过更改来实现编译对应类型文件。具体可参考vim官方说明文件。
"  copen是打开quickfix，n用来设置quichfix窗口大小，如 cope5。在错误描述上回车，可以直接跳转到错误行。
    let &makeprg     = mp  
    let &errorformat = ef  
endfunction
"一个是普通模式下，一个是插入模式下
au filetype python map <f5>  :w <cr> :call CheckPythonSyntax() <cr>
au filetype python imap <f5> <esc> :w <cr> :call CheckPythonSyntax() <cr></cr></cr></esc></f5></cr></cr></f5>
