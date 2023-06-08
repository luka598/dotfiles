-- Version 4

local log = require("usr/utils/log")
local namespace = "indent-blankline"

--
-- Module
--
local M = {}

function M.func(ctx, a, b)
	return a + b
end

--
-- Run
--
local run = {}

run.init = {
	ns = namespace,
	name = "init",
	f = function(ctx)
		if ctx:getRet(namespace, "init") then
			log.error(string.format("Namespace %s is already taken!", namespace))
		end
		return true;
	end
}

run.packer = {
	ns = namespace,
	name = "packer",
	f = function(ctx)
		if ctx:reqRet("packer", "init") then
			local packer = require("usr/packer")
			packer.M.addPlugin(ctx, {'lukas-reineke/indent-blankline.nvim'})
		end
		return true;
	end
}

run.main = {
	ns = namespace,
	name = "main",
	f = function(ctx)
		require("indent_blankline").setup {
			show_current_context = true,
			show_current_context_start = true,
		}
		return true;
	end
}

run.keymap = {
	ns = namespace,
	name = "keymap",
	f = function(ctx)
		if ctx:reqRet("which-key", "init") then
			local wk = require("usr/whichkey")
			wk.M.keymap(ctx, "cl", "gcc", "Comment line")
		end
		return true;
	end
}

return {M = M, run = run}
