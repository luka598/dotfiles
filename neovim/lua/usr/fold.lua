-- Version 3

local log = require("usr/utils/log")
local namespace = "fold"

--
-- Module
--
local M = {}

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
		vim.g.foldmethod = 'indent'
		return true;
	end
}

run.keymap = {
	ns = namespace,
	name = "keymap",
	f = function(ctx)
		if ctx:reqRet("which-key", "init") then
			local wk = require("usr/whichkey")
			wk.M.keymap(ctx, "s", "", "Section", {mode={'n', 'x'}})
			wk.M.keymap(ctx, "sf", "", "Fold", {mode={'n', 'x'}})
			wk.M.keymap(ctx, "sfc", "zf", "Create fold", {mode={'n', 'x'}})
			wk.M.keymap(ctx, "sfd", "zd", "Delete fold", {mode={'n', 'x'}})
			wk.M.keymap(ctx, "sft", "za", "Toggle fold", {mode={'n', 'x'}})
			wk.M.keymap(ctx, "sfi", "zc", "Toggle indent fold", {mode={'n', 'x'}})
		end
		return true;
	end
}

return {M = M, run = run}
