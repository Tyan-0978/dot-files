let g:mapleader = ","
let g:localmapleader = ","
set number
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set autoindent
set mouse=
set completeopt=menuone
set autoread

set timeoutlen=500
set ttimeoutlen=50

" code block folding
set nofoldenable

" cursor
set guicursor=n-v:block,i-c-ci-ve:ver25

" buffer navigation
map <C-H> :bprev<CR>
map <C-L> :bnext<CR>
map <C-Q> :bp\|bd #<CR>

" scrolling
nmap <C-j> <C-e>
nmap <C-k> <C-y>

" recording macro
nnoremap <Leader>q qa
nnoremap <Leader>r @a

" color column
" ref: https://www.ditig.com/publications/256-colors-cheat-sheet
highlight ColorColumn ctermbg=240

filetype plugin on
autocmd FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType vue setlocal shiftwidth=2 tabstop=2 softtabstop=2

" copy/paste from system clipboard
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p
nnoremap <Leader>y "+yy
nnoremap <Leader>p "+p

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'easymotion/vim-easymotion'
Plug 'psliwka/vim-smoothie'
Plug 'dominikduda/vim_current_word'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'github/copilot.vim'

call plug#end()


" airline settings
let g:airline_theme='owo'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" coc-nvim
highlight CocMenuSel ctermbg=237 guibg=#606060
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>"
inoremap <expr><C-k> coc#pum#visible() ? coc#pum#prev(1) : ""
inoremap <expr><C-j> coc#pum#visible() ? coc#pum#next(1) : ""
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
au FileType yaml if bufname("%") =~# "docker-compose.yml" | set ft=yaml.docker-compose | endif
au FileType yaml if bufname("%") =~# "compose.yml" | set ft=yaml.docker-compose | endif
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
set wildignore+=*/node_modules/*
set wildignore+=*/__pycache__/*
set wildignore+=*/.tox/*
set wildignore+=*/env/*

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

" Copilot
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" vim_current_word
highlight CurrentWord cterm=underline ctermfg=white
highlight CurrentWordTwins cterm=underline,bold ctermfg=white gui=underline,bold guifg=white
