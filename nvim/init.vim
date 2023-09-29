set number
set autoindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
"set mouse=a
set completeopt=menuone

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'

call plug#end()

" use TAB for auto fill
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>"


" airline theme
let g:airline_theme='owo'

" C/C++
autocmd FileType c,cpp call SetupCpp()
function SetupCpp()
  set cindent
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set expandtab
endfunction
