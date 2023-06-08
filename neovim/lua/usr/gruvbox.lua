-- Version 4

local log = require("usr/utils/log")
local namespace = "gruvbox"

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
		return true;
	end
}

run.packer = {
	ns = namespace,
	name = "packer",
	f = function(ctx)
		if ctx:reqRet("packer", "init") then
			local packer = require("usr/packer")
			packer.M.addPlugin(ctx, {'morhetz/gruvbox'})
		end
		return true;
	end
}

run.main = {
	ns = namespace,
	name = "main",
	f = function(ctx)
		vim.g.gruvbox_contrast_dark = 'dark'
		vim.cmd('colorscheme gruvbox')
		return true;
	end
}

return {M = M, run = run}
