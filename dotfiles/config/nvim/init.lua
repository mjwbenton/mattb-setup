-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("lazy").setup({
  spec = {
    {
      'nvim-telescope/telescope.nvim',
      tag = 'v0.2.0',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('telescope').setup({
          defaults = {
            file_ignore_patterns = { "^%.git/" },
          },
          pickers = {
            find_files = {
              hidden = true,
            },
          },
        })
      end,
    },
    {
      'projekt0n/github-nvim-theme',
      name = 'github-theme',
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd('colorscheme github_dark_colorblind')
      end,
    },
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter.configs').setup({
          ensure_installed = { 'lua', 'vim', 'vimdoc', 'javascript', 'typescript', 'python', 'bash', 'json', 'yaml', 'html', 'css' },
          auto_install = true,
          highlight = { enable = true },
          indent = { enable = true },
        })
      end,
    },
    {
      'stevearc/conform.nvim',
      event = { 'BufWritePre' },
      cmd = { 'ConformInfo' },
      config = function()
        require('conform').setup({
          formatters_by_ft = {
            javascript = { 'prettier' },
            typescript = { 'prettier' },
            javascriptreact = { 'prettier' },
            typescriptreact = { 'prettier' },
            css = { 'prettier' },
            html = { 'prettier' },
            json = { 'prettier' },
            yaml = { 'prettier' },
            markdown = { 'prettier' },
            graphql = { 'prettier' },
          },
          format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
          },
        })
      end,
    },
    {
      'saghen/blink.cmp',
      version = '1.*',
      opts = {
        keymap = { preset = 'default' },
        appearance = { nerd_font_variant = 'mono' },
        completion = { documentation = { auto_show = true } },
        sources = { default = { 'lsp', 'path', 'buffer' } },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
      },
    },
    {
      'mason-org/mason-lspconfig.nvim',
      dependencies = {
        { 'mason-org/mason.nvim', opts = {} },
        { 'neovim/nvim-lspconfig' },
        { 'saghen/blink.cmp' },
      },
      config = function()
        require('mason-lspconfig').setup({
          ensure_installed = { 'lua_ls', 'ts_ls', 'harper_ls' },
        })
        vim.lsp.config('*', {
          capabilities = require('blink.cmp').get_lsp_capabilities(),
        })
        vim.lsp.config('lua_ls', {
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
              },
              diagnostics = {
                globals = { 'vim' },
              },
              workspace = {
                library = { vim.env.VIMRUNTIME },
                checkThirdParty = false,
              },
            },
          },
        })
        vim.lsp.config('harper_ls', {
          filetypes = { 'markdown' },
        })
        vim.lsp.enable({ 'lua_ls', 'ts_ls', 'harper_ls' })
      end,
    },
    {
      'coder/claudecode.nvim',
      config = function()
        require('claudecode').setup()
      end,
    },
    {
      'mfussenegger/nvim-lint',
      event = { 'BufReadPre', 'BufNewFile' },
      config = function()
        require('lint').linters_by_ft = {
          markdown = { 'cspell' },
          text = { 'cspell' },
        }
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
          callback = function()
            require('lint').try_lint()
          end,
        })
      end,
    },
    {
      'christoomey/vim-tmux-navigator',
      init = function()
        vim.g.tmux_navigator_no_mappings = 1
      end,
      keys = {
        { '<C-w>h', '<cmd>TmuxNavigateLeft<cr>',  silent = true },
        { '<C-w>j', '<cmd>TmuxNavigateDown<cr>',  silent = true },
        { '<C-w>k', '<cmd>TmuxNavigateUp<cr>',    silent = true },
        { '<C-w>l', '<cmd>TmuxNavigateRight<cr>', silent = true },
      },
    },
    {
      'nvim-tree/nvim-tree.lua',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('nvim-tree').setup({
          view = {
            width = 30,
          },
        })
      end,
    },
    {
      'milanglacier/minuet-ai.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('minuet').setup({
          provider = 'openai_fim_compatible',
          n_completions = 1,
          context_window = 512,
          virtualtext = {
            auto_trigger_ft = { 'python', 'lua', 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'markdown' },
            keymap = {
              accept = '<Tab>',
              accept_line = '<Tab>',
              next = '<Leader>cn',
              prev = '<Leader>cp',
              dismiss = '<Leader>cd',
            },
          },
          provider_options = {
            openai_fim_compatible = {
              api_key = 'TERM',
              name = 'llama.cpp',
              end_point = 'http://localhost:8012/v1/completions',
              model = 'qwen2.5-coder-3b-q8_0',
              optional = {
                max_tokens = 56,
                top_p = 0.9,
              },
              template = {
                prompt = function(context_before_cursor, context_after_cursor, _)
                  return '<|fim_prefix|>'
                      .. context_before_cursor
                      .. '<|fim_suffix|>'
                      .. context_after_cursor
                      .. '<|fim_middle|>'
                end,
                suffix = false,
              },
            },
          },
        })
      end,
    },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true, frequency = 604800 },
})

-- Copy from system clipboard
vim.opt.clipboard = "unnamedplus"

-- Tab settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true


-- Treat MDX files as markdown for syntax highlighting
vim.filetype.add({
  extension = {
    mdx = 'markdown',
  },
})

-- ===== Keymaps =====
-- Telescope keymaps
vim.keymap.set('n', '<Leader>fs', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<Leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<Leader>fg', '<cmd>Telescope git_status<cr>')
vim.keymap.set('n', '<Leader>fh', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', '<Leader>fc', '<cmd>Telescope commands<cr>')
vim.keymap.set('n', '<Leader>fb', '<cmd>Telescope buffers<cr>')
-- LSP keymaps
vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>')
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action)
vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename)
vim.keymap.set('n', '<Leader>F', function() vim.lsp.buf.format({ async = true }) end)
-- File tree
vim.keymap.set('n', '<Leader>e', '<cmd>NvimTreeToggle<cr>')


-- ==== Diagnostics config =====
vim.diagnostic.config({
  float = {
    border = 'rounded',
    source = true,
  },
})
-- Show diagnostics on hover
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})
-- Delay before CursorHold triggers diagnostic float above (default 4000ms)
vim.opt.updatetime = 500
