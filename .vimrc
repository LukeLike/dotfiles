if !empty(glob("$HOME/.vimrc.local.pre"))
  source $HOME/.vimrc.local.pre
endif

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

  autocmd BufEnter *.sch setlocal filetype=scheme
  autocmd BufEnter .ydcv setlocal filetype=dosini

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
if !has('nvim-0.11')
  set termencoding=utf-8
endif
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
" if exists('&relativenumber')
"   set relativenumber
" endif

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

set splitbelow
set splitright

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

" nnoremap <expr> j v:count ? 'j' : 'gjzz'
" nnoremap <expr> k v:count ? 'k' : 'gkzz'

" search selected text in visual mode
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" <Ctrl-l> redraws the screen and REMOVES ANY SEARCH HIGHLIGHTING
nnoremap <silent> <C-l> :nohl<CR><C-l>

" leader keymap
" basic
nnoremap <leader>rl :source ~/.vimrc<cr>
nnoremap <leader>xc :qa<cr>
nnoremap <leader>xf :Files<cr>
nnoremap <leader>xm :
nnoremap <leader>xs :w<cr>
nnoremap <leader>xw :saveas<space>
nnoremap <leader>xz <c-z>
" buffer management
nnoremap <leader>xb :Buffers<cr>
nnoremap <leader>kb :bd<space>%<cr>
" toggle
nnoremap <leader>tb :NERDTreeToggle<cr>
nnoremap <leader>tp :call asyncrun#quickfix_toggle(8)<cr>
" edit functions
vnoremap <leader>aa "+y
nnoremap <leader>aa "+y
vnoremap <leader>pp "+p
nnoremap <leader>pp "+p
nnoremap <leader>xh ggVG
" search
nnoremap <leader>qq :Rg<space>
"" TODO: open recent
" pane management and navigation
nnoremap <leader>x1 :only<cr>
nnoremap <leader>x2 :sp<cr>
nnoremap <leader>x- :sp<cr>
nnoremap <leader>x3 :vs<cr>
nnoremap <leader>x\ :vs<cr>
nnoremap <leader>rw <c-w><c-r>
nnoremap <leader>1 :exe 1."wincmd w"<cr>
nnoremap <leader>2 :exe 2."wincmd w"<cr>
nnoremap <leader>3 :exe 3."wincmd w"<cr>
nnoremap <leader>4 :exe 4."wincmd w"<cr>
nnoremap <leader>5 :exe 5."wincmd w"<cr>
nnoremap <leader>6 :exe 6."wincmd w"<cr>
nnoremap <leader>7 :exe 7."wincmd w"<cr>
nnoremap <leader>8 :exe 8."wincmd w"<cr>
nnoremap <leader>9 :exe 9."wincmd w"<cr>
" toggle diff
nnoremap <leader>wdt :windo diffthis<CR>
nnoremap <leader>wdo :windo diffoff<CR>


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
" Plug 'lukelike/vim-fcitx-switch'
Plug 'lukelike/vim-im-select'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
" =======================================================================


" Additional Functionalities
" =======================================================================
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kassio/neoterm'
Plug 'majutsushi/tagbar'

" file tree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" snippets
if has("python3")
  Plug 'SirVer/ultisnips'
endif


" send text from vim buffer to tmux buffer
" Plug 'lukelike/tslime.vim'
Plug 'benmills/vimux'

Plug 'skywind3000/asyncrun.vim'

Plug 'jceb/vim-orgmode'

Plug 'samoshkin/vim-mergetool'
" =======================================================================


" Languages Plugins
" =======================================================================
" sheerun/vim-polyglot
let g:polyglot_disabled = ['latex']
Plug 'sheerun/vim-polyglot'
" Go
if has("patch-8.0-1453") || has("nvim")
  Plug 'fatih/vim-go'
endif
" LaTeX
Plug 'lervag/vimtex'
" Markdown
" Plug 'gabrielelana/vim-markdown'
Plug 'plasticboy/vim-markdown'
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
  \ 'coc-css', 'coc-emmet', 'coc-emoji', 'coc-gocode', 'coc-html',
  \ 'coc-json', 'coc-python', 'coc-tag', 'coc-tsserver', 'coc-snippets',
  \ 'coc-vimlsp', 'coc-vimtex', 'coc-sql'
  \ ]
call plug#end()
" =======================================================================
" }}}


" Plugin Settings {{{
" =======================================================================
" luochen1990/rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
  \	'guifgs': ['#008787', '#d75f87', '#87af87', '#d75f00'],
  \	'ctermfgs': [30, 168, 108, 166],
  \	'operators': '_,_',
  \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
  \	'separately': {
  \   '*': 0,
  \   'scheme': {
  \	    'guifgs': ['#008787', '#d75f87', '#87af87', '#d75f00']
  \   },
  \		'lisp': {
  \	    'guifgs': ['#008787', '#d75f87', '#87af87', '#d75f00']
  \   }
  \ }
  \}

" vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr = ''
" add winnr to status line
function! WindowNumber(...)
  let builder = a:1
  let context = a:2
  call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
  return 0
endfunction
if !exists("g:luke_airline_winnr_loaded")
  call airline#add_statusline_func('WindowNumber')
  call airline#add_inactive_statusline_func('WindowNumber')
endif
let g:luke_airline_winnr_loaded = 1

function! s:update_highlights()
  if has('nvim-0.11')
    hi StatusLine    cterm=NONE gui=NONE
    hi StatusLineNC  cterm=NONE gui=NONE 
  endif
endfunction
autocmd User AirlineAfterTheme call s:update_highlights()

" scrooloose/nerdtree
" nnoremap <c-b> :NERDTreeToggle<CR>
" inoremap <c-b> <ESC>:NERDTreeToggle<CR>
let NERDTreeNodeDelimiter="\t"

" skywind3000/asyncrun.vim
let g:asyncrun_mode=0
let g:asyncrun_open=8
" noremap <C-j> :call asyncrun#quickfix_toggle(8)<cr>
noremap <leader>rr :AsyncRun<SPACE>
noremap <leader>rq :AsyncStop<cr>


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
nnoremap <leader>tag :TagbarToggle<CR>

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
    elseif has('mac')
      let l:srcname = b:vimtex.root . '/tmp/' . b:vimtex.name . '.pdf'
      let l:desname = b:vimtex.root . '/' . b:vimtex.name . '.pdf'
      silent exe '!gcp "' . l:srcname . '" "' . l:desname . '"'
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
elseif has('mac')
  let g:vimtex_view_method = 'skim'
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
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_folding_disabled = 1

" iamcco/markdown-preview.nvim
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
if has("unix") && !has("mac")
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
" nnoremap <leader>t <Plug>(neoterm-repl-send)
" vnoremap <leader>t <Plug>(neoterm-repl-send)
" nnoremap <leader>tt <Plug>(neoterm-repl-send-line)
" nnoremap <leader>ts :TREPLSetTerm

" neoclide/coc.nvim {{{
set updatetime=300
set shortmess+=c
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col-1] =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? "\<C-y>" :
      \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Navigate diagnostics
nmap <silent> ,pe <Plug>(coc-diagnostic-prev)
nmap <silent> ,ne <Plug>(coc-diagnostic-next)
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
nmap <leader>cn <Plug>(coc-rename)
" Remap for format selected region
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format)
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
" Restart coc
nmap <leader>cr :CocRestart<CR>
" Scroll floating window
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
" }}}

" coc-pairs
augroup cocpairs
  autocmd!
  autocmd FileType html let b:coc_pairs_disabled = ['<']
  autocmd FileType markdown let b:coc_pairs_disabled = ['`']
  autocmd FileType markdown let b:coc_pairs = [["$", "$"]]
  autocmd FileType tex let b:coc_pairs = [["$", "$"]]
augroup END

" SirVer/ultisnips
" let g:UltiSnipsExpandTrigger = "<nop>"

" benmills/vimux
function! TmuxRun(args)
  let l:cmd = split(a:args)
  let l:new_cmd = []
  for item in l:cmd
    if item =~# '^%.*'
      let l:new_cmd = add(l:new_cmd, expand(item))
    else
      let l:new_cmd = add(l:new_cmd, item)
    endif
  endfor
  let l:cmd_str = join(l:new_cmd, ' ')
  echom l:cmd_str
  call VimuxRunCommand(l:cmd_str)
endfunction
command! -nargs=* TmuxRun :call TmuxRun(<q-args>)
nnoremap <leader>vr :TmuxRun<SPACE>
nnoremap <leader>vp :VimuxPromptCommand<CR>
nnoremap <leader>vl :VimuxRunLastCommand<CR>
nnoremap <leader>vi :VimuxInspectRunner<CR>
nnoremap <leader>vq :VimuxCloseRunner<CR>
nnoremap <leader>vx :VimuxInterruptRunner<CR>
nnoremap <leader>vz :call VimuxZoomRunner()<CR>
function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction
vmap <c-c><c-c> "vy :call VimuxSlime()<CR>

" samoshkin/vim-mergetool
let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'

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
  if has('win32')
    set noimdisable
  endif
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

