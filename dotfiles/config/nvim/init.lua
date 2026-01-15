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
			'mason-org/mason-lspconfig.nvim',
			dependencies = {
				{ 'mason-org/mason.nvim', opts = {} },
				'neovim/nvim-lspconfig',
			},
			config = function()
				require('mason-lspconfig').setup({
					ensure_installed = { 'lua_ls', 'ts_ls' },
					handlers = {
						function(server_name)
							require('lspconfig')[server_name].setup({})
						end,
					},
				})
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
				{ '<C-w>h', '<cmd>TmuxNavigateLeft<cr>', silent = true },
				{ '<C-w>j', '<cmd>TmuxNavigateDown<cr>', silent = true },
				{ '<C-w>k', '<cmd>TmuxNavigateUp<cr>', silent = true },
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
			'olimorris/codecompanion.nvim',
			dependencies = {
				'nvim-lua/plenary.nvim',
				'nvim-treesitter/nvim-treesitter',
			},
			config = function()
				require('codecompanion').setup({
					adapters = {
						ollama = function()
							return require('codecompanion.adapters').extend('ollama', {
								schema = {
									model = {
										default = 'qwen2.5-coder:3b',
									},
								},
							})
						end,
					},
					strategies = {
						chat = { adapter = 'ollama' },
						inline = { adapter = 'ollama' },
						cmd = { adapter = 'ollama' },
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
						auto_trigger_ft = { 'python', 'lua', 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'go', 'rust' },
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
							name = 'Ollama',
							end_point = 'http://localhost:11434/v1/completions',
							model = 'qwen2.5-coder:3b',
							optional = {
								max_tokens = 56,
								top_p = 0.9,
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
vim.keymap.set('n', 'K', vim.lsp.buf.hover)

-- File tree
vim.keymap.set('n', '<Leader>e', '<cmd>NvimTreeToggle<cr>')

-- Treat MDX files as markdown for syntax highlighting
vim.filetype.add({
	extension = {
		mdx = 'markdown',
	},
})
