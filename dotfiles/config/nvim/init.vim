" ### Basics ###
set nocompatible
set directory=$HOME/.vim/swp
set nobackup nowritebackup noswapfile autoread
set mouse=a
let mapleader=","
let maplocalleader=","
set clipboard=unnamed,unnamedplus "use the system clipboard
set backspace=2
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000

" ### vim-plug ###
call plug#begin('~/.vim/plugged')
Plug 'godlygeek/tabular'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'plasticboy/vim-markdown'
Plug 'ayu-theme/ayu-vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'alok/notational-fzf-vim'
Plug 'shime/vim-livedown', { 'do': 'npm install -g livedown' }
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" ## Coc ##
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
call plug#end()

" ### Colours ###
syntax on
let ayucolor="light"
silent! colorscheme ayu
set background=light
let g:one_allow_italics = 1
set t_Co=256

" ### Lines ###
set number
set wrap

" ### Tabs -> Spaces ###
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2

" ### Search ###
set incsearch
set hlsearch
set ignorecase
set smartcase

" ### netrw ###
let g:netrw_liststyle=3

" ### Aliases ###
nnoremap <Leader>n :NV<CR>
nnoremap <Leader>f :Explore!<CR>
nnoremap <Leader>l :LivedownToggle<CR>
nnoremap <Leader>s :Rg<CR>
nnoremap <Leader>h :History<CR>
" ## Coc Aliases ##
inoremap <silent><expr> <c-space> coc#refresh()
nmap <leader>a <Plug>(coc-codeaction)
nmap <leader>r <Plug>(coc-rename)
nmap <leader>q <Plug>(coc-diagnostic-prev)
nmap <leader>w <Plug>(coc-diagnostic-next)
nnoremap <leader>i :CocList diagnostics<CR>
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gr <Plug>(coc-references)

" ### Status Line / Airline ###
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='papercolor'
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" ### Setup for seemless tmux integration
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-w>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-w>k :TmuxNavigateUp<cr>
nnoremap <silent> <C-w>l :TmuxNavigateRight<cr>

" ### Markdown ###
autocmd BufRead,BufNewFile *.txt set filetype=markdown
autocmd Filetype markdown setlocal spell spelllang=en_us
let g:vim_markdown_folding_disabled = 1

" ### FZF ###
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" ### NV ####
let g:nv_search_paths=['~/notes']
let g:nv_use_short_pathnames = 1
let g:nv_default_extension = '.txt'
let g:nv_keymap = {
    \ 'ctrl-s': 'split ',
    \ 'ctrl-v': 'vertical split ',
    \ }
let g:nv_create_note_key = 'ctrl-n'
let g:nv_create_note_window = 'vertical split'

" ### Goyo ###
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:limelight_conceal_ctermfg = 'gray'

" ### Include .vimrc.local file for local overrides
if filereadable(glob("~/.vimrc.local")) 
    source ~/.vimrc.local
endif
