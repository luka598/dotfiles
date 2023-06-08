-- local bw = require("usr/utils/bit-utils/53")
local bw = require("usr/utils/bit-utils/jit")

local M = {}
M.bw = bw

function M.bor(values)
	if not type(values) == "table" then
		error("Invalid values type")
	end
	local res = 0
	if values[1] then
		res = values[1]
	end
	for _, v in pairs(values) do
		res = bw.o(res, v)
	end
	return res
end

function M.band(values)
	if not type(values) == "table" then
		error("Invalid values type")
	end
	local res = 0
	if values[1] then
		res = values[1]
	end
	for _, v in pairs(values) do
		res = bw.o(res, v)
	end
	return res
end


function M.bit(n) return 2 ^ n end
function M.hasbit(x, n) return (bw.rs(x, n) % 2) == 1 end
function M.setbit(x, n) return bw.o(x,bw.ls(1, n)) end
function M.clearbit(x, n) return bw.a(x, bw.n(bw.ls(1,n))) end

function M.print(x)
	local str = ""
	while x > 0 do
		str = str..tostring(x%2)
		x = bw.rs(x, 1)
	end
	str = string.reverse(str)
	print(str)
end

return M
