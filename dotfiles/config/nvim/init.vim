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
set updatetime=300
set hidden
set signcolumn=number

" ### vim-plug ###
call plug#begin('~/.vim/plugged')
Plug 'godlygeek/tabular'
Plug 'liuchengxu/vim-which-key'
Plug 'hoob3rt/lualine.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'jxnblk/vim-mdx-js'
Plug 'christoomey/vim-tmux-navigator'
Plug 'shaunsingh/moonlight.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kyazdani42/nvim-web-devicons'
" ## Coc ##
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
call plug#end()

" ### Commands to open specific files ###
command Todo :lua require("mattb.todo").openAll()
command Scratch :exe ":e! ~/notes/scratch-" . strftime('%Y-%m-%d') . ".txt"
command Notes :cd ~/notes

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

" ### Rename ###
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

" ### Mappings ###
nnoremap <silent> <Leader>rv :source $MYVIMRC<CR>
" Show Files
nnoremap <Leader>sf :NvimTreeToggle<CR>
" Find
nnoremap <Leader>fs :Telescope live_grep<CR>
nnoremap <Leader>ff :Telescope find_files<CR>
nnoremap <Leader>fg :Telescope git_status<CR>
nnoremap <Leader>fh :Telescope oldfiles<CR>
nnoremap <Leader>fc :Telescope commands<CR>
nnoremap <Leader>fb :Telescope buffers<CR>
" Rename
nnoremap <leader>rf :call RenameFile()<cr>
" Buffer
nnoremap <Leader>bn :BufferNext<CR>
nnoremap <Leader>bp :BufferPrevious<CR>
nnoremap <Leader>bc :BufferClose<CR>
" CoC
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
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'filename'},
      lualine_c = {'g:coc_status', {'diagnostics',
        sources = {'coc'}
        }},
      lualine_x = {'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'},
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

" ### Gitsigns ###
lua << EOF
  require('gitsigns').setup()
EOF

