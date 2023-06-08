local wk = require("usr/whichkey")
local packer = require("usr/packer")

return {
	packer={
		ns = "nvimtree",
		name = "packer",
		f = function (ctx)
			packer.M.addPlugin(ctx, {'nvim-tree/nvim-tree.lua', requires = {'nvim-tree/nvim-web-devicons'}})
			return true
		end
	},
	main = {
		ns = "nvimtree",
		name = "main",
		f = function (ctx)
			require("nvim-tree").setup()
			return true
		end
	},
	keymap = {
		ns = "nvimtree",
		name = "keymap",
		f = function (ctx)
			wk.M.keymap(ctx, "t", "", "Nvim tree")
			wk.M.keymap(ctx, "tt", "<Cmd>:NvimTreeToggle<CR>", "Toggle nvim tree")
			wk.M.keymap(ctx, "tf", "<Cmd>:NvimTreeFocus<CR>", "Focus nvim tree")
			wk.M.keymap(ctx, "tr", "<Cmd>:NvimTreeRefresh<CR>", "Refresh nvim tree")
			wk.M.keymap(ctx, "th", "g?", "Nvim tree help")
			return true
		end
	}
}
