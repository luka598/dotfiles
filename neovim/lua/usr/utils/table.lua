local M = {}

function M.tablelength(table)
  local count = 0
  for _ in pairs(table) do count = count + 1 end
  return count
end

function M.inside(value, table)
  local count = 0
  for _, v in ipairs(table) do
	  if value == v then count = count + 1 end
  end
  return count
end

function M.istr(table)
	local str = "{ "
	for _, v in ipairs(table) do
		str = str..tostring(v).." "
	end
	str = str.."}"
	return str
end

function M.JSON(tbl)
    local function escapeString(str)
        str = string.gsub(str, "[%c\"\\]", {
            ["\n"] = "\\n",
            ["\r"] = "\\r",
            ["\t"] = "\\t",
            ["\""] = "\\\"",
            ["\\"] = "\\\\",
        })
        return str
    end

    local function convertValue(val)
        if type(val) == "string" then
            return "\"" .. escapeString(val) .. "\""
        elseif type(val) == "number" or type(val) == "boolean" then
            return tostring(val)
        elseif type(val) == "table" then
            return M.JSON(val)
        else
            return "null"
        end
    end

    local json = "{"
    local isFirst = true

    for key, value in pairs(tbl) do
        if not isFirst then
            json = json .. ","
        end

        json = json .. "\"" .. escapeString(tostring(key)) .. "\":" .. convertValue(value)
        isFirst = false
    end

    json = json .. "}"

    return json
end

function M.deepcopy(o, seen)
  seen = seen or {}
  if o == nil then return nil end
  if seen[o] then return seen[o] end

  local no
  if type(o) == 'table' then
    no = {}
    seen[o] = no

    for k, v in next, o, nil do
      no[M.deepcopy(k, seen)] = M.deepcopy(v, seen)
    end
    setmetatable(no, M.deepcopy(getmetatable(o), seen))
  else -- number, string, boolean, etc
    no = o
  end
  return no
end

return M
