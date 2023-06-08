-- Version 1

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
		vim.opt.mouse = 'a'
		vim.opt.ignorecase = true
		vim.opt.smartcase = true
		vim.opt.hlsearch = false
		vim.opt.wrap = true
		vim.opt.breakindent = true
		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4
		vim.opt.expandtab = false
		vim.opt.number = true
		vim.opt.relativenumber = true
		vim.opt.termguicolors = true
		vim.opt.undofile = true
		vim.g.mapleader = ' '
		vim.o.scrolloff = 5
		return true;
	end
}

run.keymap = {
	ns = namespace,
	name = "keymap",
	f = function(ctx)
		if ctx:reqRet("which-key", "init") then
			local wk = require("usr/whichkey")
			--[[
			n: Normal modepace>
			i: Insert mode.
			x: Visual mode.
			s: Selection mode.
			v: Visual + Selection.
			t: Terminal mode.
			o: Operator-pending.
			--]]
			wk.M.keymap(ctx, "c", "", "Clipboard")
			wk.M.keymap(ctx, "cy", '"+y', "Copy to clipboard", {mode={'n', 'x'}})
			wk.M.keymap(ctx, "cp", '"+p', "Paste from clipboard", {mode={'n', 'x'}})
			wk.M.keymap(ctx, "x", '"_x', "Delete wo changing registers", {prefix="", mode={'n', 'x'}})
			wk.M.keymap(ctx, "<Esc>", '<C-\\><C-n>', "Exit terminal", {prefix="", mode={'t'}})
			wk.M.keymap(ctx, "f", "", "File")
			wk.M.keymap(ctx, "a", "ggVG", "Select all")
			wk.M.keymap(ctx, "fs", "<Cmd>:w<CR>", "Save file")
		end
		return true;
	end
}

return {M = M, run = run}
