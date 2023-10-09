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


call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


let g:airline_theme='owo'

" use TAB for auto fill
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>"

" for docker-compose language server
au FileType yaml if bufname("%") =~# "docker-compose.yml" | set ft=yaml.docker-compose | endif
au FileType yaml if bufname("%") =~# "compose.yml" | set ft=yaml.docker-compose | endif
let g:coc_filetype_map = {'yaml.docker-compose': 'dockercompose'}

" re-map nerdtree commands
nnoremap <C-n> :NERDTreeToggle<CR>
