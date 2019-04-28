" Basic vim settings {{{
" =======================================================================

" tarted as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif


" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" keep 50 lines of command line history.
set history=50

" enable settings embedded in the files.
set modeline

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

  set autoindent " always set autoindenting on

endif " has("autocmd")

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
  \ | wincmd p | diffthis
endif

if &diff
  set diffopt=filler,context:1000000
endif

set nobackup

" file encoding
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936;
set termencoding=utf-8
set encoding=utf-8

" set the number of spaces for an indent level to 4
" and also map tab to spaces
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

" make <Left><Right> available to get across EOL
set whichwrap+=<,>


" =======================================================================
" }}}


" Appearance {{{
" =======================================================================

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set incsearch " do incremental searching
  colorscheme gruvbox
  set background=dark
  set cursorline
  highlight Normal ctermbg=NONE
  highlight NonText ctermbg=NONE
endif

set ruler " show the cursor position all the time
set showcmd " display incomplete commands

set number
if exists('&relativenumber')
  set relativenumber
endif

set laststatus=2
set smartindent
set autoindent

set wrap linebreak textwidth=0
if exists('&colorcolumn')
  set colorcolumn=80
endif

let &t_Co=256

" =======================================================================
" }}}


" Key Mapping {{{
" =======================================================================

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Map leader key to <SPACE>
nnoremap <SPACE> <Nop>
let mapleader="\<SPACE>"

map ; :
inoremap jk <ESC>

nnoremap <expr> j v:count ? 'j' : 'gjzz'
nnoremap <expr> k v:count ? 'k' : 'gkzz'

" search selected text in visual mode
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" <Ctrl-l> redraws the screen and REMOVES ANY SEARCH HIGHLIGHTING
nnoremap <silent> <C-l> :nohl<CR><C-l>

" =======================================================================
" }}}


" Plugins (using 'junegunn/vim-plug') {{{
" =======================================================================
call plug#begin('~/.vim/plugged')

" Appearance
" =======================================================================
" hightlight brackets
Plug 'luochen1990/rainbow'
" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" =======================================================================


" Editor Enhancement
" =======================================================================
Plug 'easymotion/vim-easymotion'
Plug 'lukelike/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" =======================================================================


" Additional Functionalities
" =======================================================================
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'

" file tree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" send text from vim buffer to tmux buffer
Plug 'sjl/tslime.vim'

Plug 'skywind3000/asyncrun.vim'
" =======================================================================


" Languages Plugins
" =======================================================================
" Python
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" =======================================================================
call plug#end()
" =======================================================================
" }}}


" Plugin Settings {{{
" =======================================================================
" luochen1990/rainbow
let g:rainbow_active = 0
let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
    \       'html': 0,
	\		'css': 0,
	\	}
	\}

" vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_theme='wombat'

" scrooloose/nerdtree
nmap <c-b> :NERDTreeToggle<CR>
imap <c-b> <ESC>:NERDTreeToggle<CR>
let NERDTreeNodeDelimiter="\t"

" sjl/tslime.vim
let g:tslime_normal_mapping = '<leader>t'
let g:tslime_visual_mapping = '<leader>t'
let g:tslime_vars_mapping = '<leader>T'

" skywind3000/asyncrun.vim
let g:asyncrun_mode=0
let g:asyncrun_open=8
noremap <C-j> :call asyncrun#quickfix_toggle(8)<cr>
noremap <leader>r :AsyncRun<SPACE>

" lukelike/auto-pairs
let g:AutoPairs={'(':')', '[':']', '{':'}'}

" davidhalter/jedi-vim
let g:jedi#rename_command="<leader>rn"

" junegunn/fzf.vim
nmap <leader>p :Buffers<CR>
nmap <leader>o :Files<CR>

" majutsushi/tagbar
let g:airline#extensions#tagbar#enabled = 0
nmap <leader>tb :TagbarToggle<CR>
" =======================================================================
" }}}


" enable folder specific .vimrc files
set exrc
set secure

" vim:set foldmethod=marker foldlevel=0 sts=2 sw=2 ts=2 expandtab nomodeline:

