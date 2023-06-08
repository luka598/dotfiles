-- Version 4

local log = require("usr/utils/log")
local t = require("usr/utils/types")
local tu = require("usr/utils/table")
local b = require("usr/utils/bit")
local namespace = "which-key"

--
-- Module
--
local M = {}

function M.keymap(ctx, key, cmd, comment, opts)
	t.validate(key, t.T.str, {name="key"})
	t.validate(cmd, b.band({t.T.str, t.T.f}), {name="cmd"})
	t.validate(comment, t.T.str, {name="comment"})
	t.validate(opts, b.band({t.T.table, t.T.null}), {name="opts"})
	if opts then
		t.validate(opts.mode, b.band({t.T.table, t.T.null}), {name="opts.mode"})
		t.validate(opts.prefix, b.band({t.T.str, t.T.null}), {name="opts.prefix"})
		t.validate(opts.buffer, t.T.any, {name="opts.buffer"})
		t.validate(opts.silent, b.band({t.T.bool, t.T.null}), {name="opts.silent"})
		t.validate(opts.noremap, b.band({t.T.bool, t.T.null}), {name="opts.noremap"})
		t.validate(opts.nowait, b.band({t.T.bool, t.T.null}), {name="opts.nowait"})
		t.validate(opts.expr, b.band({t.T.bool, t.T.null}), {name="opts.expr"})
	else
		opts = {}
	end
	if not opts.prefix then opts.prefix = "<leader>" end
	if not opts.noremap then opts.noremap = false end
	if not opts.mode then opts.mode = {'n', 'v'} end
	local modes = opts.mode
	for _, m in pairs(modes) do
		t.validate(m, b.band({t.T.str}), {name="opts.mode.m"})
		opts.mode = m
		table.insert(ctx:getVar("which-key", "keymap"), tu.deepcopy({map = {[key] = {cmd, comment}}, opts = opts}))
	end
end

function M.group(ctx, key, comment)
	M.keymap(ctx, key, "", comment)
end

--
-- Run
--
local run = {}

run.init = {
	ns = namespace,
	name = "init",
	f = function(ctx)
		vim.o.timeout = true
		vim.o.timeoutlen = 500
		ctx:setVar("which-key", "keymap", {})
		return true
	end
}

run.packer = {
	ns = namespace,
	name = "packer",
	f = function(ctx)
		if ctx:reqRet("packer", "init") then
			local packer = require("usr/packer")
			packer.M.addPlugin(ctx, {'folke/which-key.nvim'})
		end
		return true;
	end
}

run.setKeymaps = {
	ns = namespace,
	name = "main",
	f = function(ctx)
		if ctx:reqRet("packer", "init") then
			local wk = require("which-key")
			for _, km in ipairs(ctx:getVar("which-key", "keymap")) do
				wk.register(km.map, km.opts)
				-- log.log(km.opts.mode)
				-- log.log(tu.JSON(km))
			end
		end
		return true
	end
}

return {M = M, run = run}
