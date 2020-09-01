" leader
let mapleader=' '

set clipboard=unnamed

syntax on

" show line number
set number
set relativenumber

set cursorline
set wrap
set showcmd
set wildmenu

" use mouse
set mouse=a

" search setting
set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase
nnoremap <LEADER><CR> :noh<CR>

nnoremap <LEADER>l $
nnoremap <LEADER>h 0

" save and quit
nnoremap S :w<CR>
nnoremap Q :q<CR>

" split
nnoremap sl :set splitright<CR>:vsplit<CR>
nnoremap sh :set nosplitright<CR>:vsplit<CR>

" 移动光标所在窗口 
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" 标签页 
nnoremap te :tabe<CR>
nnoremap tl :+tabnext<CR>
nnoremap th :-tabnext<CR>

nnoremap n nzz
nnoremap N Nzz

nnoremap R :source $MYVIMRC<CR>

inoremap jk <Esc>`^

set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set encoding=utf-8
let &t_ut=''
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set list
" set listchars=tab:▸\ ,trail:▫
set scrolloff=5
set tw=0
set indentexpr=
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
set laststatus=2
set autochdir
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
set scrolloff=5

set colorcolumn=120

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" vim-plug
call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'

" theme
Plug 'morhetz/gruvbox'

" file manager
" Plug 'rbgrouleff/bclose.vim'
" Plug 'francoiscabrol/ranger.vim'

Plug 'tpope/vim-surround'

" Underlines the word under the cursor
Plug 'itchyny/vim-cursorword'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Comment stuff out
Plug 'tpope/vim-commentary'

Plug 'easymotion/vim-easymotion'

" display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine'

Plug 'mhinz/vim-startify'

Plug 'voldikss/vim-floaterm'

Plug 'junegunn/vim-easy-align'

Plug 'Chiel92/vim-autoformat'

" suda is a plugin to read or write files with sudo command
Plug 'lambdalisue/suda.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree'

call plug#end()

" python file header
function HeaderPython()
	call setline(1, '#!/usr/bin/env python')
	call append(1, '#-*- coding:utf8 -*-')
	normal G
	normal o
	normal o
endfunc

autocmd bufnewfile *.py call HeaderPython()

" run file
map <leader>r :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
	if &filetype == 'c'
	    exec "!g++ % -o %<"
	    exec "!time ./%<"
	elseif &filetype == 'cpp'
	    exec "!g++ % -o %<"
	    exec "!time ./%<"
	elseif &filetype == 'sh'
	    :!time bash %
	elseif &filetype == 'go'
        exec "!time go run %"
	elseif &filetype == 'python'
	    exec "!time python %"
	endif
endfunc

" ===
" === theme
" ===
colorscheme gruvbox

" ===
" === easymotion
" ===
nmap ss <Plug>(easymotion-s2)


" ===
" === vim-easy-align
" ===
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ===
" === coc.nvim
" ===
let g:python3_host_prog = '/Users/nchen/miniconda3/bin/python'
let g:coc_global_extensions = ['coc-python', 'coc-vimlsp', 'coc-json', 'coc-pyright', 'coc-translator', 'coc-snippets']
set hidden
set updatetime=100
set shortmess+=c

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-o> coc#refresh()
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

nmap <LEADER>t :CocCommand translator.popup<CR>
imap <C-j> <Plug>(coc-snippets-expand-jump)

nmap <LEADER>b :TagbarToggle<CR>

nmap <LEADER>p :CocCommand python.setInterpreter<CR>

"===
"=== NERDTree
"===
nnoremap <leader>v :NERDTreeFind<cr>
nnoremap <leader>v :NERDTreeToggle<cr>
let NERDTreeShowHidden=1

"===
"=== suda
"===
nnoremap <LEADER>w :w suda://%<CR>

"===
"=== vim-floaterm
"===
nnoremap <LEADER>f :FloatermNew
