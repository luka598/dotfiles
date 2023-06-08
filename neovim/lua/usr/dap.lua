local namespace = "dap"
return {
	packer = {
		ns = namespace,
		name = "packer",
		f = function(ctx)
			if ctx:getRet("packer", "init") then
				local packer = require("usr/packer")
				packer.M.addPlugin(ctx, {'mfussenegger/nvim-dap'})
			end
			return true;
		end
	},
	main = {
		ns = namespace,
		name = "main",
		f = function(ctx)
			require("package").setup()
			return true;
		end
	},
	keymap = {
		ns = namespace,
		name = "keymap",
		f = function(ctx)
			if ctx:reqRet("which-key", "main") then
				local wk = require("usr/whichkey")
				wk.M.keymap(ctx, "db", require'dap'.toggle_breakpoint(), "Toggle breakpoint")
				wk.M.keymap(ctx, "dc", require'dap'.continue(), "Continue")
				wk.M.keymap(ctx, "dso", require'dap'.step_over(), "Step over")
				wk.M.keymap(ctx, "dsi", require'dap'.step_into(), "Step into")
				wk.M.keymap(ctx, "dr", require'dap'.repl.open(), "REPL")
			end
			return true;
		end
	}
}
