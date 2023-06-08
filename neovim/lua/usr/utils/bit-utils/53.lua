local M = {}

function M.ls(a, b) -- Left shift
	return a << b
end

function M.rs(a, b) -- Right shift
	return a >> b
end

function M.a(a, b) -- AND
	return a & b
end

function M.o(a, b) -- OR
	return a | b
end

function M.n(a) -- NOT
	return ~a
end

function M.x(a, b) -- XOR
	error("Not implemented")
	return a ^ b
end

return M
