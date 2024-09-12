-- String Functions
M = {}

-- Splits the string by any character in the sep string
function M:split_str(str, sep)
	data = {}
	for ln in string.gmatch(str, "([^" .. sep .. "]*)"..sep) do
		table.insert(data,ln)
	end

	if string.sub(str, -1) == sep then
		table.insert(data, "")
	end
	return data
end

-- Splits incoming lines into a table of strings on the
-- newline character.
function M:split_lines(str)
	return self:split_str(str, '\n')
end


return M
