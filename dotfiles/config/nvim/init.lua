-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
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
      'nvim-telescope/telescope.nvim', tag = 'v0.2.0',
      dependencies = { 'nvim-lua/plenary.nvim' }
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
    }
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

-- Copy from system clipboard
vim.opt.clipboard = "unnamedplus"

-- Telescope keymaps
vim.keymap.set('n', '<Leader>fs', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<Leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<Leader>fg', '<cmd>Telescope git_status<cr>')
vim.keymap.set('n', '<Leader>fh', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', '<Leader>fc', '<cmd>Telescope commands<cr>')
vim.keymap.set('n', '<Leader>fb', '<cmd>Telescope buffers<cr>')

