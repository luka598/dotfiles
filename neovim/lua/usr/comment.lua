local packer = require("usr/packer")
local wk = require("usr/whichkey")

return {
	packer = {
		ns = "comment",
		name = "init",
		f = function(ctx)
			packer.M.addPlugin(ctx, {'numToStr/Comment.nvim'})
			return true
		end
	},
	main = {
		ns = "comment",
		name = "main",
		f = function(ctx)
			require("Comment").setup()
			return true
		end
	},
	keymap = {
		ns = "comment",
		name = "keymap",
		f = function(ctx)
			-- wk.M.keymap(ctx, "cl", "gcc", "Comment line")
			return true
		end
	}
}
