" tarted as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" if has("vms")
"   set nobackup" do not keep a backup file, use versions instead
" else
"   set backup" keep a backup file
" endif
set history=50" keep 50 lines of command line history
set ruler" show the cursor position all the time
set showcmd" display incomplete commands
set incsearch" do incremental searching


" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  colorscheme Tomorrow-Night
  set cursorline
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
  \ | wincmd p | diffthis
endif

" my version of settings:
set number
set nobackup
set wrap linebreak textwidth=0
set laststatus=2
let &t_Co=256

if &diff
    set diffopt=filler,context:1000000
endif

" file encoding
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936;
set termencoding=utf-8
set encoding=utf-8

" key map:
map j gjzz
map k gkzz
inoremap jj <ESC>
map <SPACE> $
map ; :

" brackets matching
inoremap {<CR> {<CR>}<ESC>O
inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
function! ClosePair(char)
    if getline('.')[col('.')-1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

" convert tab to 4 spaces:
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

" Vundle configuration:
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Vundle itself
Plugin 'VundleVim/Vundle.vim'

" vim-surround
Plugin 'tpope/vim-surround'

" vim-repeat
Plugin 'tpope/vim-repeat'

" airline
Plugin 'vim-airline/vim-airline'
"let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#right_sep = ' '
"let g:airline#extensions#tabline#right_alt_sep = '|'

Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='wombat'

" YouCompleteMe
" Plugin 'Valloric/YouCompleteMe'
" let g:ycm_extra_conf_globlist = ['~/*']
" let g:ycm_server_python_interpreter = '/usr/bin/python3'

call vundle#end()
filetype plugin indent on
