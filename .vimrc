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

  " Set the `filetype` to `text` if is not already set.
  autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

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

let g:tex_flavor="latex"

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
  colorscheme Tomorrow-Night
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

set noshowmode

if has("termguicolors")
  set termguicolors
endif

" =======================================================================
" }}}


" Key Mapping {{{
" =======================================================================

" Don't use Ex mode, use Q for formatting
noremap Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Map leader key to <SPACE>
nnoremap <SPACE> <Nop>
let mapleader="\<SPACE>"
let maplocalleader=","

noremap ; :
inoremap jk <ESC>
inoremap kj <ESC>

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
if has('win32')
  call plug#begin('~\vimfiles\plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" Appearance
" =======================================================================
" hightlight brackets
Plug 'luochen1990/rainbow'
" status line
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
" =======================================================================


" Editor Enhancement
" =======================================================================
Plug 'AndrewRadev/switch.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'easymotion/vim-easymotion'
Plug 'lukelike/auto-pairs'
Plug 'lukelike/vim-fcitx-switch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" =======================================================================


" Additional Functionalities
" =======================================================================
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kassio/neoterm'
Plug 'majutsushi/tagbar'

" file tree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" snippets
Plug 'SirVer/ultisnips'

" send text from vim buffer to tmux buffer
Plug 'lukelike/tslime.vim'

Plug 'skywind3000/asyncrun.vim'
" =======================================================================


" Languages Plugins
" =======================================================================
" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" LaTeX
Plug 'lervag/vimtex', { 'for': 'tex' }
" Markdown
Plug 'gabrielelana/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', {
      \ 'do': { -> mkdp#util#install_sync() },
      \ 'for' :['markdown', 'vim-plug'] }
" Python
" Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" =======================================================================


" Code Completion
" =======================================================================
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-css', 'coc-emmet', 'coc-emoji', 'coc-gocode', 'coc-html', 'coc-json',
  \ 'coc-python', 'coc-tag', 'coc-snippets', 'coc-vimlsp',
  \ 'coc-vimtex'
  \ ]
call plug#end()
" =======================================================================
" }}}


" Plugin Settings {{{
" =======================================================================
" luochen1990/rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
  \	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
  \	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
  \	'operators': '_,_',
  \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
  \	'separately': {
  \   '*': 0,
  \   'scheme': {
  \     'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick',
  \                'darkorchid3'],
  \   },
  \		'lisp': {
  \	    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick',
  \                'darkorchid3'],
  \   },
  \   'html': 0,
  \   'css': 0,
  \ }
  \}

" vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 0
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr = ''

" scrooloose/nerdtree
nnoremap <c-b> :NERDTreeToggle<CR>
inoremap <c-b> <ESC>:NERDTreeToggle<CR>
let NERDTreeNodeDelimiter="\t"

" skywind3000/asyncrun.vim
let g:asyncrun_mode=0
let g:asyncrun_open=8
noremap <C-j> :call asyncrun#quickfix_toggle(8)<cr>
noremap <leader>r :AsyncRun<SPACE>

" lukelike/auto-pairs
let g:AutoPairs={'(':')', '[':']', '{':'}'}
let g:AutoPairsMultilineClose=0

" davidhalter/jedi-vim
let g:jedi#rename_command="<leader>n"
let g:jedi#popup_on_dot=0
let g:jedi#show_call_signatures=2
" set completeopt-=preview

" junegunn/fzf.vim
nnoremap <leader>p :Buffers<CR>
nmap <leader>o :Files<CR>

" majutsushi/tagbar
let g:airline#extensions#tagbar#enabled = 0
nnoremap <leader>tb :TagbarToggle<CR>

" lervag/vimtex
let g:vimtex_compiler_latexmk = {
      \ 'build_dir': './tmp'
      \ }
let g:vimtex_compiler_callback_hooks = ['CopyFromTemp']
function! CopyFromTemp(status)
  if exists('b:vimtex.root')
    if has('win32')
      let l:srcname = b:vimtex.root . '\tmp\' . b:vimtex.name . '.pdf'
      let l:desname = b:vimtex.root . '\' . b:vimtex.name . '.pdf'
      silent exe '!start /B copy "' . l:srcname . '" "' . l:desname . '"'
    else
      let l:srcname = b:vimtex.root . '/tmp/' . b:vimtex.name . '.pdf'
      let l:desname = b:vimtex.root . '/' . b:vimtex.name . '.pdf'
      silent exe '!cp "' . l:srcname . '" "' . l:desname . '"'
    endif
  endif
endfunction

let g:vimtex_quickfix_mode = 0
if has('win32')
  let g:vimtex_view_general_viewer = 'SumatraPDF'
  let g:vimtex_view_general_options
      \ = '-reuse-instance -forward-search @tex @line @pdf'
      \ . ' -inverse-search "gvim --servername ' . v:servername
      \ . ' --remote-send \"^<C-\^>^<C-n^>'
      \ . ':drop \%f^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'
      \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
      \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
      \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
  let g:vimtex_view_general_options_latexmk = '-reuse-instance'
else
  let g:vimtex_view_method = 'zathura'
endif

" dhruvasagar/vim-table-mode
let g:table_mode_corner = '|'
let g:table_mode_map_prefix = '<LocalLeader>t'

" gabrielelana/vim-markdown
let g:markdown_enable_input_abbreviations = 0
let g:markdown_enable_spell_checking = 0
let g:markdown_mapping_switch_status = "<LocalLeader>s"

" iamcco/markdown-preview.nvim
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
if has("unix")
  let g:mkdp_browser = 'google-chrome-stable'
elseif has("win32")
  let g:mkdp_browser = 'chrome.exe'
endif
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '${name}'

" morhetz/gruvbox
silent! colorscheme gruvbox

" kassio/neoterm
nnoremap <leader>t <Plug>(neoterm-repl-send)
vnoremap <leader>t <Plug>(neoterm-repl-send)
nnoremap <leader>tt <Plug>(neoterm-repl-send-line)
nnoremap <leader>ts :TREPLSetTerm

" neoclide/coc.nvim {{{
set updatetime=300
set shortmess+=c
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col-1] =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? "\<C-y>" :
      \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Remap for rename current word
nmap <leader>n <Plug>(coc-rename)
" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" }}}

" coc-pairs
autocmd FileType html let b:coc_pairs_disabled = ['<']
autocmd FileType markdown let b:coc_pairs_disabled = ['`']
autocmd FileType markdown let b:coc_pairs = [["$", "$"]]
autocmd FileType tex let b:coc_pairs = [["$", "$"]]

" SirVer/ultisnips
let g:UltiSnipsExpandTrigger = "<nop>"

" =======================================================================
" }}}


" settings for GVim and Windows {{{
if has("gui_running")
  let $LANG='en_US'
  set langmenu=en_US
  source $VIMRUNTIME/delmenu.vim
  source $VIMRUNTIME/menu.vim
  set guioptions-=m
  set guioptions-=T
  set guifont=Consolas:h11

  set lines=32
  set columns=85
  set clipboard=unnamed,unnamedplus
  " disable IME when entering Normal mode
  set noimdisable
  " support for formating CJK characters
  set formatoptions+=mB

  nmap <leader>sc <ESC>:setlocal spell spelllang=en_us<CR>
  nmap <leader>ss <ESC>:setlocal nospell<CR>
  vmap <leader>c "+y
  nmap <leader>v "+p

  nnoremap <M-Space> :simalt ~<cr>
  inoremap <M-Space> <esc>:simalt ~<cr>
endif

if has("win32")
  set pythondll=C:\Applications\Miniconda3\envs\py27_32\python27.dll
  set pythonhome=C:\Applications\Miniconda3\envs\py27_32
  set noswapfile
endif
" }}}


" Load the settings for local machine
if !empty(glob("$HOME/_vimrc.local"))
  source $HOME/_vimrc.local
endif
if !empty(glob("$HOME/.vimrc.local"))
  source $HOME/.vimrc.local
endif

" enable folder specific .vimrc files
set exrc
set secure


" vim:set foldmethod=marker foldlevel=0 sts=2 sw=2 ts=2 expandtab nomodeline:

