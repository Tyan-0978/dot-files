" misc. options
set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set completeopt=menuone
set expandtab
set guicursor=n-v:block,i-c-ci-ve:ver25
set hidden
set list
set listchars=tab:>-,trail:$
set mouse=
set number
set scrolloff=3
set shiftround
set shiftwidth=4
set wildmenu
set wildoptions=pum
set wrap
set nolangremap
set noshowmatch

" tabs
set expandtab
set smarttab

" timeout
set timeout
set timeoutlen=1000
set ttimeoutlen=100

" folding
set nofoldenable

let g:mapleader = ","
let g:localmapleader = ","

" buffer navigation
map <C-H> :bprev<CR>
map <C-L> :bnext<CR>
map <C-Q> :bp\|bd #<CR>

" copy/paste from system clipboard
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p
nnoremap <Leader>y "+yy
nnoremap <Leader>p "+p

" misc. mappings
nnoremap <leader>r :source $MYVIMRC<cr>
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>

" color column
" ref: https://www.ditig.com/publications/256-colors-cheat-sheet
highlight ColorColumn ctermbg=240

filetype plugin on

augroup MyGroup
    autocmd!
    autocmd FileType html,css,json setlocal shiftwidth=2
    autocmd FileType javascript,typescript,vue setlocal shiftwidth=2
    autocmd InsertEnter * set nolist
    autocmd InsertLeave * set list
augroup END

call plug#begin()

Plug 'ctrlpvim/ctrlp.vim'
Plug 'dominikduda/vim_current_word'
Plug 'easymotion/vim-easymotion'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'psliwka/vim-smoothie'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" airline settings
let g:airline_theme='owo'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" coc-nvim
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
vmap <leader>f  <Plug>(coc-format-selected)
let g:coc_global_extensions = [
    \'coc-clangd',
    \'coc-css',
    \'coc-git',
    \'coc-html',
    \'coc-json',
    \'coc-markdownlint',
    \'coc-pyright',
    \'coc-rust-analyzer',
    \'coc-sh',
    \'coc-tsserver',
    \'@yaegassy/coc-volar',
\]

" for docker-compose language server
autocmd FileType yaml if bufname("%") =~# "docker-compose.yml" | set ft=yaml.docker-compose | endif
autocmd FileType yaml if bufname("%") =~# "compose.yml" | set ft=yaml.docker-compose | endif
let g:coc_filetype_map = {'yaml.docker-compose': 'dockercompose'}

" NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1

" CtrlP
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 1
set wildignore+=*.swp
set wildignore+=*/.tox/*
set wildignore+=*/.venv/*
set wildignore+=*/__pycache__/*
set wildignore+=*/node_modules/*

" indent-guides
nnoremap <Leader>i :IndentGuidesToggle<CR>
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=darkgray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgray

" nerd commenter
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 0
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDToggleCheckAllLines = 1

" easymotion
let g:EasyMotion_do_mapping = 0
nmap <Leader>e <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1

" tagbar
nmap <Leader>t :TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_sort = 0
let g:tagbar_show_tag_linenumbers = 0
let g:tagbar_foldlevel = 0

" vim_current_word
highlight CurrentWord cterm=underline ctermfg=white
highlight CurrentWordTwins cterm=underline,bold ctermfg=white gui=underline,bold guifg=white
