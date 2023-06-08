-- local color = require("usr/utils/color")

local M = {}

function M.create_message(args, kwargs)
	kwargs = kwargs or {}
	local sep = kwargs.sep or " "
	local f = kwargs.f and kwargs.f + 1 or 2
	local prefix = kwargs.prefix or ""
	local postfix = kwargs.postfix or ""

	local inf = debug.getinfo(f)
	local time = os.time()
	local message = ""

	if type(args) == "table" then
		for _, m in ipairs(args) do
			message = message..tostring(m)..tostring(sep)
		end
	else
		message = tostring(args)
	end
	return string.format("%s[%s:%d]@[%d]: %s%s", prefix, inf.source, inf.currentline, time, message, postfix)
end

function M.log(args, kwargs)
	kwargs = kwargs or {}
	kwargs.f = kwargs.f and kwargs.f + 1 or 2
	print(M.create_message(args, kwargs))
end

function M.warning(args, kwargs)
	kwargs = kwargs or {}
	kwargs.prefix = "[ ! ]"
	kwargs.f = kwargs.f and kwargs.f + 1 or 2
	print(M.create_message(args, kwargs))
end
M.warn = M.warning

function M.error(args, kwargs)
	kwargs = kwargs or {}
	kwargs.prefix = "[ ! ! ! ]"
	kwargs.f = kwargs.f and kwargs.f + 1 or 2
	error(M.create_message(args, kwargs))
end

return M
