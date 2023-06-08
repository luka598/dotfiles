-- Version 2

local log = require("usr/utils/log")
local namespace = "package"

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
			log.error("Namespace %s is already taken!", namespace)
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
			packer.M.addPlugin(ctx, {'romgrk/barbar.nvim'})
		end
		return true;
	end
}

run.main = {
	ns = namespace,
	name = "main",
	f = function(ctx)
		require("barbar").setup()
		return true;
	end
}

run.keymap = {
	ns = namespace,
	name = "keymap",
	f = function(ctx)
		if ctx:reqRet("which-key", "init") then
			local wk = require("usr/whichkey")
			wk.M.keymap(ctx, "b", "", "Buffer")
			wk.M.keymap(ctx, "bb", "<Cmd>BufferPrevious<CR>", "Previous")
			wk.M.keymap(ctx, "bc", "<Cmd>BufferClose<CR>", "Close")
			wk.M.keymap(ctx, "bp", "<Cmd>BufferPick<CR>", "Pick")
			wk.M.keymap(ctx, "b1", "<Cmd>BufferGoto 1<CR>", "Buffer 1")
			wk.M.keymap(ctx, "b2", "<Cmd>BufferGoto 2<CR>", "Buffer 2")
			wk.M.keymap(ctx, "b3", "<Cmd>BufferGoto 3<CR>", "Buffer 3")
			wk.M.keymap(ctx, "b4", "<Cmd>BufferGoto 4<CR>", "Buffer 4")
			wk.M.keymap(ctx, "b5", "<Cmd>BufferGoto 5<CR>", "Buffer 5")
			wk.M.keymap(ctx, "b6", "<Cmd>BufferGoto 6<CR>", "Buffer 6")
			wk.M.keymap(ctx, "b7", "<Cmd>BufferGoto 7<CR>", "Buffer 7")
			wk.M.keymap(ctx, "b8", "<Cmd>BufferGoto 8<CR>", "Buffer 8")
			wk.M.keymap(ctx, "b1", "<Cmd>BufferGoto 1<CR>", "Buffer 1")
			wk.M.keymap(ctx, "b9", "<Cmd>BufferGoto 9<CR>", "Buffer 9")
		end
		return true;
	end
}

return {M = M, run = run}
