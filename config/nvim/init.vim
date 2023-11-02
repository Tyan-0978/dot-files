set number
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set autoindent
set mouse=nv
set completeopt=menuone
set autoread

set timeoutlen=10
set ttimeoutlen=5

" code block folding
"set foldmethod=syntax
set nofoldenable

" cursor
set guicursor=n-v:block,i-c-ci-ve:ver25

" buffer navigation
map <C-J> :bprev<CR>
map <C-K> :bnext<CR>
map <C-Q> :bd<CR>

autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


" airline settings
let g:airline_theme='owo'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" use TAB for auto fill
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>"
let g:coc_global_extensions = [
    \'coc-json', 
    \'coc-markdownlint',
    \'coc-git', 
    \'coc-sh',
    \'coc-html',
    \'coc-css',
    \'coc-tsserver',
    \'coc-clangd',
    \'coc-pyright',
    \'coc-rust-analyzer']

" for docker-compose language server
au FileType yaml if bufname("%") =~# "docker-compose.yml" | set ft=yaml.docker-compose | endif
au FileType yaml if bufname("%") =~# "compose.yml" | set ft=yaml.docker-compose | endif
let g:coc_filetype_map = {'yaml.docker-compose': 'dockercompose'}

" re-map nerdtree commands
nnoremap <C-n> :NERDTreeToggle<CR>

" close nerdtree after opening a file
let NERDTreeQuitOnOpen=1

" CtrlP
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 1
set wildignore+=*.swp
set wildignore+=*/node_modules/*
set wildignore+=*/__pycache__/*
