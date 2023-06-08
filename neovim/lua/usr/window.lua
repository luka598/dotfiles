local wk = require("usr/whichkey")

return {
	keymap = {
		ns = "window",
		name = "keymap",
		f = function (ctx)
			wk.M.keymap(ctx, "w", "<C-w>", "Window")
			return true
		end
	}
}
