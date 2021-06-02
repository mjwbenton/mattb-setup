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
set nofoldenable

" ### vim-plug ###
call plug#begin('~/.vim/plugged')
Plug 'godlygeek/tabular'
Plug 'liuchengxu/vim-which-key'
Plug 'hoob3rt/lualine.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'jxnblk/vim-mdx-js'
Plug 'christoomey/vim-tmux-navigator'
Plug 'shaunsingh/moonlight.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
" ## Coc ##
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
call plug#end()

" ### Notepad Setup ###
command Pad :exe ":e! " . system('date +~/notes/scratch-%Y-%m-%d.txt') | :split ~/notes/todo-house.txt | :split ~/notes/todo-projects.txt | :split ~/notes/todo.txt

" ### WhichKey setup so that we can check what options are attached to
" leaders
nnoremap <silent> <leader>      :<c-u>WhichKey ','<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>

" ### Treesitter
lua << EOF
  require('nvim-treesitter.configs').setup {
    ensure_installed = "maintained",
    highlight = {
      enable = true
    },
    indent = {
      enable = true
    }
  }
EOF

" ### Colors
lua << EOF
  vim.g.moonlight_italic_comments = true
  vim.g.moonlight_italic_keywords = true
  vim.g.moonlight_contrast = true
  vim.g.moonlight_disable_background = true
  require('moonlight').set();
EOF

lua << EOF
  require('nvim-web-devicons').setup {
    default = true;
  }
EOF

" ### Tabs -> Spaces ###
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent

" ### Lines ###
set number
set wrap

" ### Search ###
set incsearch
set hlsearch
set ignorecase
set smartcase

" ### netrw ###
let g:netrw_liststyle=3

" ### Aliases ###
nnoremap <Leader>f :Telescope file_browser<CR>
nnoremap <Leader>s :Telescope live_grep<CR>
nnoremap <Leader>p :Telescope git_files<CR>
nnoremap <Leader>h :Telescope oldfiles<CR>
nnoremap <Leader>c :Telescope commands<CR>
nnoremap <Leader>l :LivedownToggle<CR>
" ## Coc Aliases ##
inoremap <silent><expr> <c-space> coc#refresh()
nmap <leader>a <Plug>(coc-codeaction)
nmap <leader>r <Plug>(coc-rename)
nnoremap <leader>i :CocList diagnostics<CR>
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gr <Plug>(coc-references)

" ### Lualine ###
lua << EOF
  require'lualine'.setup {
    options = {
      theme = 'moonlight'
    }
  }
EOF

" ### Setup for seemless tmux integration
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-w>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-w>k :TmuxNavigateUp<cr>
nnoremap <silent> <C-w>l :TmuxNavigateRight<cr>

" ### Markdown ###
autocmd BufRead,BufNewFile *.txt set filetype=markdown
autocmd Filetype markdown setlocal spell spelllang=en_us

" ### FZF ###
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
