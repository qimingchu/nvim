-- https://medium.com/@shaikzahid0713/code-completion-for-neovim-6127401ebec2
-- whichkey.lua

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 },                                   -- min and max height of the columns
		width = { min = 20, max = 50 },                                   -- min and max width of the columns
		spacing = 3,                                                      -- spacing between columns
		align = "left",                                                   -- align columns left, center or right
	},
	ignore_missing = true,                                                    -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true,                                                         -- show help message on the command line when the popup is visible
	triggers = "auto",                                                        -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {

	["a"] = { "<cmd>Alpha<cr>", "Alpha" },
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" }, -- File Explorer
	["n"] = { "<cmd>NvimTreeFocus<cr>", "Focus on Explorer" }, -- Focus on File Explorer
	["k"] = { "<cmd>bdelete<CR>", "Kill Buffer" }, -- Close current file
	["m"] = { "<cmd>Mason<cr>", "Mason" },         -- LSP Manager
	["p"] = { "<cmd>Lazy<CR>", "Plugin Manager" }, -- Invoking plugin manager
	["q"] = { "<cmd>wqall!<CR>", "Quit" },         -- Quit Neovim after saving the file
	["r"] = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Reformat Code" },

	-- Language Support
	l = {
		name = "LSP Info",
		-- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		-- d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to Definition" },
		-- D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to Declaration" },
		-- i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Show Implementation" },
		-- o = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type definition" },
		-- r = { "<cmd>lua vim.lsp.buf.references()<cr>", "Show References" },
		-- h = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
		-- l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		-- R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		-- f = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Open Float" },
		I = { "<cmd>LspInfo<cr>", "Info" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},

	-- Mappings for Code
	--[[
	g = {
		name = "LSP",
		-- vim.lsp.buf
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to Definition" },
		D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to Declaration" },
		i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Show Implementation" },
		o = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type definition" },
		r = { "<cmd>lua vim.lsp.buf.references()<cr>", "Show References" },
		h = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
		R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
		-- codelens.run
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		-- vim.diagnostic
		f = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Open Float" },
		e = { "<cmd>lua vim.diagnostic.show_line_diagnostics()<cr>", "Show diagnostic line" },
		p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Goto Prev diagnostic" },
		n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Goto Next diagnostic" },
	},
	]]

	-- Telescope
	f = {
		name = "File Search",
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find files" },
		t = { "<cmd>Telescope live_grep <cr>", "Find Text Pattern" },
		r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
	},
	s = {
		name = "Search",
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		c = { "<cmd>Telescope commands<cr>", "Commands" },
	},
	-- Floating Terminal
	t = {
		name = "Floating Terminal",
		o = { "<cmd>lua require('FTerm').open()<cr>", "Open Floating Terminal" },
		c = { "<cmd>lua require('FTerm').close()<cr>", "Close Floating Terminal" },
		t = { "<cmd>lua require('FTerm').toggle()<cr>", "Toggle Floating Terminal" },
	},
	-- Window
	w = {
		name = "Windows",
		w = { "<cmd>wincmd w<cr>", "Other window" },
		s = { "<cmd>wincmd s<cr>", "Split window below" },
		v = { "<cmd>wincmd v<cr>", "Split window right" },
		h = { "<cmd>wincmd h<cr>", "window-left"},
		j = { "<cmd>wincmd j<cr>", "window-below"},
		l = { "<cmd>wincmd l<cr>", "window-right"},
		k = { "<cmd>wincmd k<cr>", "window-up"},
	},
}

which_key.setup(setup)
which_key.register(mappings, opts)
