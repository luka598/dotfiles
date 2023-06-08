local log = require("usr/utils/log")
local table_u = require("usr/utils/table")
local bit = require("usr/utils/bit")

-- local log = require("./log")
-- local table_u = require("./table")
-- local bit = require("./bit")

local M = {}

local types_list = { "nil", "boolean", "number", "string", "function", "cfunction", "userdata", "table" }

M.T = {
	["nil"] =       bit.bit(0),
	null =          bit.bit(0),
	["boolean"] =   bit.bit(1),
	bool =          bit.bit(1),
	["number"] =    bit.bit(2),
	n =             bit.bit(2),
	["string"] =    bit.bit(3),
	str =           bit.bit(3),
	["function"] =  bit.bit(4),
	f =             bit.bit(4),
	["cfunction"] = bit.bit(5),
	cf =            bit.bit(5),
	["userdata"] =  bit.bit(6),
	udata =         bit.bit(6),
	["table"] =     bit.bit(7),
	t =             bit.bit(7),
}
M.T.any = bit.bor({M.T.null, M.T.bool, M.T.n, M.T.str, M.T.f, M.T.cf, M.T.udata, M.T.t})

local function bitset_to_table(n)
	local t = {}
	for i = 0, 7 do
		if bit.hasbit(n, i) then
			table.insert(t, types_list[i+1])
		end
	end
	return t
end

local function isvalid(value, T)
	T = bitset_to_table(T)
	for _, t in pairs(T) do
		if type(value) == t then
			return true
		end
	end
	return false
end

-- function M.validate(values, types, kwargs)
-- 	kwargs = kwargs or {}
-- 	kwargs.path = kwargs.path or "root"
-- 	local logf = kwargs.log or log.error
--
-- 	validate_single(values, M.T.t, string.format("%s argument values", kwargs.path), logf)
-- 	validate_single(types, M.T.t, string.format("%s argument types", kwargs.path), logf)
-- 	for k, _ in pairs(types) do
-- 		log.log({"Validating", kwargs.path.."."..k})
-- 		validate_single(types[k], bit.bor({M.T.t, M.T.n}), "type "..kwargs.path.."."..k, logf)
-- 		if type(types[k]) == "table" then
-- 			_ = kwargs.path
-- 			kwargs.path = kwargs.path .. "." .. k
-- 			if not M.validate(values[k], types[k], kwargs) then return false end
-- 			kwargs.path = _
-- 		else
-- 			if not validate_single(values[k], types[k], kwargs.path.."."..k, logf) then return false end
-- 		end
-- 	end
-- 	log.log("Valid")
-- 	return true
-- end

function M.validate(value, T, kwargs)
	kwargs = kwargs or {}
	kwargs.name = kwargs.name or "value"
	local logf = kwargs.log or log.error

	if not isvalid(T, M.T.n) then log.error(string.format("Type must be integer, got %s!", type(T)), {f=2}) end
	if not isvalid(value, T) then
		logf(string.format("Invalid type for %s, got %s insted of %s", kwargs.name, type(value), table_u.istr(bitset_to_table(T))), {f=2})
		return false
	end
end

return M
