require("usr/utils/log").warning({"Warning: Using utils.lua is deprecated", debug.traceback()})

local M = {}
M.T = {
	none="nil",
	bool="boolean",
	n="number",
	str="string",
	udata="userdata",
	f="function",
	thread="thread",
	table="table"
}

function M.validate_val(val, T, extra)
	if type(extra) == M.T.none then
		extra = {}
	else
		M.validate_val(extra, M.T.table)
	end
	if not (type(val) == T) then
		local msg = string.format("Invalid variable type %s, expected %s.", type(val), T)
		if extra.comment then
			M.validate_val(extra.comment, M.T.str)
			msg = msg..string.format(" %s", extra.comment)
		end
		if extra.noerror then
			print(msg)
		else
			error(msg)
		end
	end
end

return M
