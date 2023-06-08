local M = {}

function M.ls(a, b) -- Left shift
	return bit.lshift(a, b)
end

function M.rs(a, b) -- Right shift
	return bit.rshift(a, b)
end

function M.a(a, b) -- AND
	return bit.band(a, b)
end

function M.o(a, b) -- OR
	return bit.bor(a, b)
end

function M.n(a) -- NOT
	return bit.bnot(a)
end

function M.x(a, b) -- XOR
	return bit.bxor(a, b)
end

return M
