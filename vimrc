set encoding=utf-8


""""""""""""""""""""""""""""""
" Plugin Install
""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox' " colorscheme gruvbox
Plug 'itchyny/lightline.vim' " A light and configurable statusline/tabline plugin for Vim
Plug 'preservim/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin' " Nerdtree
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' } " fuzzy finder that helps to locate files, buffers, mrus, gtags, etc.
Plug 'tpope/vim-surround' " Surround.vim is all about surroundings
Plug 'mbbill/undotree' " visualizes undo history and makes it easier to browse and switch between different undo branches
Plug 'jiangmiao/auto-pairs' " Insert or delete brackets, parens, quotes in pair
Plug 'dense-analysis/ale' "ALE (Asynchronous Lint Engine) is a plugin providing linting (syntax checking and semantic errors)
Plug 'preservim/nerdcommenter' " Comment functions so powerful—no comment necessary
Plug 'davidhalter/jedi-vim' " jedi-vim is a VIM binding to the autocompletion library Jedi
Plug 'puremourning/vimspector' " A multi language graphical debugger for Vim

call plug#end()


""""""""""""""""""""""""""""""
" Basic Settings
""""""""""""""""""""""""""""""
set nocompatible
set timeoutlen=1500 
set ttimeoutlen=100

" backup, use undotree(undo file)
set nobackup
set noswapfile

" Number
set number
set relativenumber

" Search
set incsearch
set hlsearch

" Tab
set expandtab
set tabstop=4
set autoindent
set shiftwidth=4
set smarttab

" Listchars
set showbreak=↪
" set showbreak=^\ 
set listchars=tab:→\ ,eol:↲,nbsp:␣,space:•,trail:•,extends:⟩,precedes:⟨ 
" set listchars=tab:>-\,eol:$,space:.,trail:.
set nolist

" Buffers
set switchbuf=useopen,usetab " useage: :sb partial_buffer_name

" Leaderkey
let mapleader=" "

" Find and wildmenu
set path+=**
set wildmenu

" Remain some lines for scroll
set scrolloff=8

" basic remap for switch windows
nnoremap <leader>ww <C-W><C-W>
nnoremap <leader>wh <C-W>h
nnoremap <leader>wj <C-W>j
nnoremap <leader>wk <C-W>k
nnoremap <leader>wl <C-W>l
nnoremap <leader>wH <C-W>H
nnoremap <leader>wJ <C-W>J
nnoremap <leader>wK <C-W>K
nnoremap <leader>wL <C-W>L
nnoremap <leader>wc <C-W>c
nnoremap <leader>wt <C-W>T

" remap for fast tab switch
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<cr>

" terminal key remap
tnoremap <esc><esc> <c-\><c-n>
tnoremap <esc>w <C-W><C-W>
tnoremap <esc>: <C-W>:
tnoremap <esc>h <C-W>h
tnoremap <esc>j <C-W>j
tnoremap <esc>k <C-W>k
tnoremap <esc>l <C-W>l

" disable automatic comment insertion, to disable for all files and sessions
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" filetype
autocmd BufNewFile,BufRead CMakeLists.txt set filetype=cmake

""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""
" gruvbox
colorscheme gruvbox
set bg=dark

" lightline
set laststatus=2

" nerdtree
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

" learderf
function! LeaderfSetShowHidden(val) " show hidden files or not
    let g:Lf_ShowHidden = a:val
    echo "Leaderf_ShowHidden: " . g:Lf_ShowHidden . " ( Please refresh<F5> first! )"
endfunction
command! LeaderfShowHiddenToggle call LeaderfSetShowHidden(!g:Lf_ShowHidden)
command! LeaderfShowHiddenEnable call LeaderfSetShowHidden(1)
command! LeaderfShowHiddenDisable call LeaderfSetShowHidden(0)
nnoremap <leader>F <ESC>:LeaderfFunction<CR>

" undotree
if has("persistent_undo") " Persistent undo
    let target_path = expand('~/.vim/.undodir')
    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif
    let &undodir=target_path
    set undofile
endif
nnoremap <leader>uu :UndotreeToggle<CR>:UndotreeFocus<CR>

" ale
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '!'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_linters = {
\   'c++': ['cc'],
\   'c': ['cc'],
\   'python': ['pylint'],
\}
nmap  <silent> <leader>ll <ESC>:ALELint<CR>
nmap  <silent> <leader>lp <Plug>(ale_previous_wrap)
nmap  <silent> <leader>ln <Plug>(ale_next_wrap)
nmap  <silent> <leader>ld <Plug>(ale_go_to_definition)
nmap  <silent> <leader>lt <Plug>(ale_go_to_type_definition)
nmap  <silent> <leader>lr <Plug>(ale_find_references)
" nmap  <silent> <leader>lds <Plug>(ale_go_to_definition_in_split)
" nmap  <silent> <leader>lts <Plug>(ale_go_to_type_definition_in_split)

" nerdcommenter
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>dx :call vimspector#Reset()<CR>
" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval
