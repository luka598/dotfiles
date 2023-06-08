local M = {}
local t = require("usr/utils/types")
local log = require("usr/utils/log")

M.index = 0

function M.Module(m)
	log.log({M.index, m})
	M.index = M.index + 1
end
M.M = M.Module

function M:new(modules)
	return {run = function()end, print_list = function()end}
end
return M
