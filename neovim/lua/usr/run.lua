local M = {}
local t = require("usr/utils/types")
local log = require("usr/utils/log")

function M.Module(m)
	t.validate(m, t.T.t, {name="run module"})
	t.validate(m.ns, t.T.str, {name="namespace"})
	t.validate(m.name, t.T.str, {name="name"})
	t.validate(m.f, t.T.f, {name="function"})
	return m
end
M.M = M.Module

function M.M_repr(f)
	M.M(f)
	return string.format("%s::%s", f.ns, f.name)
end

function M:new(modules)
	t.validate(modules, t.T.t)
	self.modules = modules
	return self
end

function M:print_list()
	for i, f in ipairs(self.modules) do
		log.log({i, M.M_repr(f), f.f})
	end
end

function M:run()
	self.context = {
		getRet = function(self, ns, name)
			t.validate(ns, t.T.str, {name = "namespace"})
			t.validate(name, t.T.str, { name = "function name" })
			if not self[ns] then
				return nil
			else
				return self[ns]._return[name]
			end
		end,
		getReturns = function(self, list)
			local result = true
			for item in ipairs(list) do
				result = result and self.getRet(item[1], item[2])
			end
		end,
		getVar = function(self, ns, var)
			t.validate(ns, t.T.str, { name = "namespace" })
			t.validate(var, t.T.str, { name = "variable name" })
			t.validate(self[ns], t.T.table, {name=string.format("namespace %s", ns)})
			t.validate(self[ns]._variables[var], t.T.any, {name=string.format("variable %s::%s", ns, var)})
			return self[ns]._variables[var]
		end,
		setVar = function(self, ns, key, val)
			t.validate(ns, t.T.str, { name = "namespace" })
			t.validate(key, t.T.str, { name = "variable name" })
			t.validate(self[ns], t.T.table, {name=string.format("namespace %s", ns)})
			self[ns]._variables[key] = val
		end,
		reqRet = function(self, ns, name)
			if not self.getRet(self, ns, name) then
				log.warn(string.format("Required %s::%s is not avabile", ns, name), {f=2})
				return false
			end
			return true
		end
	}
	for _, f in ipairs(self.modules) do
		M.M(f)
		self.context[f.ns] = {
			_return = {},
			_variables = {}
		}
	end

	for _, f in ipairs(self.modules) do
		self.context[f.ns]._return[f.name] = f.f(self.context)
		t.validate(self.context[f.ns]._return[f.name], t.T.bool,
		{ name = string.format("%s::%s return code", f.ns, f.name)})
	end
end

return M
