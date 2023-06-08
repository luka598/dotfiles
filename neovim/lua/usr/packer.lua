local t = require("usr/utils/types")
local log = require("usr/utils/log")
local namespace = "packer"

--
-- Module
--
local M = {}

function M.func(ctx, a, b)
	return a + b
end

function M.addPlugin(ctx, plugin)
	t.validate(plugin, t.T.t, {name="plugin"})
	t.validate(plugin[1], t.T.str, {name="plugin name"})
	table.insert(ctx:getVar("packer", "plugins"), plugin)
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
		local vim = vim
		local fn = vim.fn
		local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
		if fn.empty(fn.glob(install_path)) > 0 then
			fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
			vim.cmd [[packadd packer.nvim]]
			require('packer').sync()
		end
		ctx:setVar("packer", "plugins", {})
		return true;
	end
}

run.packer = {
	ns = namespace,
	name = "packer",
	f = function(ctx)
		if ctx:getRet("packer", "init") then
			local packer = require("usr/packer")
			packer.M.addPlugin(ctx, {'wbthomason/packer.nvim'})
		end
		return true;
	end
}

run.main = {
	ns = namespace,
	name = "main",
	f = function(ctx)
		require('packer').startup(function(use)
			for _, p in pairs(ctx:getVar("packer", "plugins")) do
				use(p)
			end
		end)
		if (vim.env.NVIM_INSTALL) then 
			require('packer').sync()
		end
		return true;
	end
}

run.keymap = {
	ns = namespace,
	name = "keymap",
	f = function(ctx)
		if ctx:getRet("which-key", "init") then
			local wk = require("usr/whichkey")
			wk.M.keymap(ctx, "p", "", "Packer")
			wk.M.keymap(ctx, "ps", ":PackerSync<Enter>", "Packer sync")
		end
		return true;
	end
}

return {M = M, run = run}
