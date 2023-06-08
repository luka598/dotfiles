local ESCAPE = "\u{001b}["
local BOLD = ";1"
local END = "m"

local colors = {
    black = "30",
    red = "31",
    green = "32",
    yellow = "33",
    blue = "34",
    magenta = "35",
    cyan = "36",
    white = "37",
    reset = "0",
}

return function(color, bold)
	local cstr = ""
	for c, color_code in pairs(colors) do
		if c == color then
			cstr = ESCAPE..color_code
			if bold then
				cstr = cstr..BOLD
			end
			cstr = cstr..END
			return cstr
		end
	end
end
