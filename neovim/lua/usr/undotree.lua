local log = require("usr/utils/log")
local namespace = "undotree"

--
-- Run
--
local run = {}

run.init = {
	ns = namespace,
	name = "init",
	f = function(ctx)
		if ctx:getRet(namespace, "init") then
			log.error("Namespace %s is already taken!", namespace)
		end
		return true;
	end
}

run.packer = {
	ns = namespace,
	name = "packer",
	f = function(ctx)
		if ctx:getRet("packer", "init") then
			local packer = require("usr/packer")
			packer.M.addPlugin(ctx, {'mbbill/undotree'})
		end
		return true;
	end
}

run.keymap = {
	ns = namespace,
	name = "keymap",
	f = function(ctx)
		if ctx:reqRet("which-key", "init") then
			local wk = require("usr/whichkey")
			wk.M.keymap(ctx, "u", vim.cmd.UndotreeToggle, "Undo tree")
		end
		return true;
	end
}

return {M = {}, run = run}
