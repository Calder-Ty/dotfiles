-- Colors
-- clear and set defaults
vim.cmd("hi clear");
vim.g.colors_name = "minima"
local colors = {}

if (vim.o.background == "dark") then
	colors = {
		normal = {guibg="#13181e", guifg="#d4cbbc", gui=""},
		["function"] = { guibg="bg", guifg="#71a1e5", gui=""},
		string = {guibg="bg", guifg="#4f8142", gui=""},
		literal = {guibg="bg", guifg="#ec843b", gui=""},
		keyword = {guibg="bg", guifg="#7a5d73", gui=""},
	}
else
	colors = {
		normal = {guibg="#f7e1d3", guifg="#020605", gui=""},
		["function"] = { guibg="bg", guifg="#0c3956", gui=""},
		string = {guibg="bg", guifg="#4f8142", gui=""},
		literal = {guibg="bg", guifg="#4f8142", gui=""},
		keyword = {guibg="bg", guifg="#6d5c7c", gui=""},
	}
end


local highlights = {
	Normal = colors.normal,
	Operator = colors.normal,
	Identifier = colors.normal,
	Function = colors["function"],
	Special = colors["function"],
	String = colors.string,
	Constant = colors.literal,
	Statement = colors.normal,
	["@variable"] = colors.normal,
	Type = colors.keyword,
}

local set_hl = function(group, hl)
	local settings = ""
	for k, v in pairs(hl) do
		if v ~= "" then
			settings = settings .. " " .. k.."="..v
		end
	end
	vim.cmd("hi " .. group .. " ".. settings)
end

for k, v in pairs(highlights) do
	set_hl(k, v)
end
