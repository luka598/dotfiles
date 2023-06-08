local run = require("usr/run")

local r = run:new({
	-- Init
	run.M(require("usr/vim-opt").run.init),
	run.M(require("usr/fold").run.init),
	run.M(require("usr/whichkey").run.init),
	run.M(require("usr/packer").run.init),
	
	-- Packer
	run.M(require("usr/packer").run.packer),
	run.M(require("usr/whichkey").run.packer),
	run.M(require("usr/comment").packer),
	run.M(require("usr/nvimtree").packer),
	run.M(require("usr/lsp").packer),
	run.M(require("usr/cmp").packer),
	run.M(require("usr/polyglot").run.packer),
	run.M(require("usr/undotree").run.packer),
	run.M(require("usr/barbar").run.packer),
	run.M(require("usr/gruvbox").run.packer),
	run.M(require("usr/autopairs").run.packer),
	run.M(require("usr/indent-blankline").run.packer),
	run.M(require("usr/treesitter").run.packer),

	-- Main
	run.M(require("usr/packer").run.main),
	run.M(require("usr/comment").main),
	run.M(require("usr/cmp").main),
	run.M(require("usr/lsp").main),
	run.M(require("usr/nvimtree").main),
	run.M(require("usr/gruvbox").run.main),
	run.M(require("usr/barbar").run.main),
	run.M(require("usr/autopairs").run.main),
	run.M(require("usr/indent-blankline").run.main),
	run.M(require("usr/treesitter").run.main),

	-- Keymaps
	run.M(require("usr/vim-opt").run.keymap),
	run.M(require("usr/comment").keymap),
	run.M(require("usr/window").keymap),
	run.M(require("usr/cmp").keymap),
	run.M(require("usr/lsp").keymap),
	run.M(require("usr/nvimtree").keymap),
	run.M(require("usr/packer").run.keymap),
	run.M(require("usr/undotree").run.keymap),
	run.M(require("usr/barbar").run.keymap),
	run.M(require("usr/fold").run.keymap),

	run.M(require("usr/whichkey").run.setKeymaps),
	})

r:print_list()
r:run()
