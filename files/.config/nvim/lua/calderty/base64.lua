--- My Rewrite of Base64 Encoding
local bit = require("bit")
local band = bit.band
local bor = bit.bor
local lshift = bit.lshift
local rshift = bit.rshift

local LO6 = 0x3F
local HO2 = 0xC0
local LO4 = 0x0F
local HO4 = 0xF0
local LO2 = 0x03
local HO6 = 0xFC

local PAD = 0xC0


M = {}

local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local pad = "="

---Perform Base64 encoding of input string
---@param input string
M.encode = function(input)
	local bytes = {}
	local i = 1
	while (i <= input:len()) do
		local b1, b2, b3 = input:byte(i, i+2)
		local quantum = rshift(band(HO6, b1),2)

		-- CHAR 1
		bytes[#bytes+1] = alphabet:sub(quantum+1, quantum+1)

		-- Char 2
		if (b2 ~=nil) then
			quantum = bor(lshift(band(LO2, b1),4), rshift(band(HO4, b2),4))
			bytes[#bytes+1] = alphabet:sub(quantum+1,quantum+1)
		-- CHAR 2-4
		else
			quantum = lshift(band(LO2, b1), 4)
			bytes[#bytes+1] = alphabet:sub(quantum+1,quantum+1)
			bytes[#bytes+1] = pad
			bytes[#bytes+1] = pad
			break
		end
		-- CHAR 3 - 4
		if (b3 ~=nil) then
			quantum = bor(lshift(band(LO4, b2),2), rshift(band(HO2, b3),6))
			bytes[#bytes+1] = alphabet:sub(quantum+1, quantum+1)
			quantum = band(LO6,b3)
			bytes[#bytes+1] = alphabet:sub(quantum+1, quantum+1)
		else
			quantum =lshift(band(LO4, b2), 2)
			bytes[#bytes+1] = alphabet:sub(quantum +1, quantum+1)
			bytes[#bytes+1] = pad
			break
		end
		i = i + 3
	end
	return table.concat(bytes)
end

local function getNextBase64Chars(input, start)
	local results = {}
	for i= 0, 3 do
		local a1 = input:sub(start + i, start + i)
		local c1
		if a1 == "=" then
			c1 = PAD
		else
			c1, _ = alphabet:find(a1) - 1
		end
		if c1 == nil then
			error("Invalid base64 input at byte"..input + start + i .. ": "..a1)
		end
		results[#results+1] = c1
	end

	return results
end


---Decode the Base64 input to original string
---@param inpuu string
M.decode = function (input)
	assert(#input % 4 == 0, "Malformed base64 input: must be a multipe of 4 characters in length")
	local i = 1;
	local output = {}
	while i <= input:len() do
		local c = getNextBase64Chars(input, i)

		output[#output+1] = string.char(bor(lshift(c[1], 2), rshift(band(0x30, c[2]),4)))
		if c[2] == PAD or (band(c[2], LO4) == 0 and c[3] == PAD) then
			break
		else
			output[#output+1] = string.char(bor(lshift(band(LO4, c[2]), 4), rshift(band(0x3C, c[3]),2)))
		end
		if c[3] == PAD or (band(c[3], LO2) == 0 and c[4] == PAD)then
			break
		else
			output[#output+1] = string.char(bor(lshift(band(LO2, c[3]), 6), band(LO6,c[4])))
		end
		i = i +4
	end
	return table.concat(output)
end

return M
