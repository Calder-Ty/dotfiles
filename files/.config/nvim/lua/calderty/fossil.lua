local str = require("calderty.strings")
-- TICKETS
--
-- Fossil has some great ticket Management Capabilities
-- We can add Tickets, List Tickets, Respond to Tickets
-- and View tickets.

-- plugin code for managing and working with
-- fossil
--
-- Thing Fugitive, but for fossil
--
-- Better names will be had in the future
M = {}

function ls_ticket_display(item)
	return string.sub(item.tkt_uuid, 1, 10) .. "  " .. item.title
end

function Ticket(line)

	split = str:split_str(line, '\t')

	return {
		tkt_id=split[1],
		tkt_uuid=split[2],
		tkt_mtime=split[3],
		tkt_ctime=split[4],
		type=split[5],
		status=split[6],
		subsystem=split[7],
		priority=split[8],
		severity=split[9],
		foundin=split[10],
		private_contact=split[11],
		resolution=split[12],
		title=split[13],
		comment=split[14],
	}
end

local function select_ticket()
	-- XXX: This is not safe, we are just taking user input and running it
	-- Fix this before releasing it.
	local obj = vim.system({'fossil', 'ticket', 'show', '0'}, {text= true}):wait()
	if obj.code ~= 0 then
		error(obj.stderr)
		return
	end
	local lines = str:split_lines(obj.stdout)
	tickets = {}
	for key, value in pairs(lines) do
		if key > 1 and value ~= "" then
			table.insert(tickets, Ticket(value))
		end
	end

	co = coroutine.running()
	if co then
		cb = function(item)
			view_ticket(item.tkt_uuid)
			coroutine.resume(co, item)
		end
	else
		error("Cannot run fossil outside of eventloop")
	end

	vim.ui.select(tickets, {prompt = "Tickets", format_item=ls_ticket_display}, cb);
	return coroutine.yield();
end

local function parse_ticket_data(text)
	lines = str:split_lines(text)
	ticket = {fields = {}, comments = {}}
	for i = #lines, 1, -1 do
		line = lines[i]
		if string.match(line, "^%s+Change") then
			local key, value = string.match(line, "([^%s]+): (.*)")
			if key == "icomment" then
				table.insert(ticket.comments, value)
			else
				ticket.fields[key] = value
			end
		end
	end
	return ticket
end

function view_ticket(tkt_uuid)
	local obj = vim.system({'fossil', 'ticket', 'history', tkt_uuid}, {text= true}):wait()
	if obj.code ~= 0 then
		error("Error getting fossil ticket history for ".. tkt_uuid)
	end
	ticket = parse_ticket_data(obj.stdout)

	buf = vim.api.nvim_create_buf(true, true)
	if buf == 0 then
		error("Failure to create new buffer")
	end


	field_names = {}
	for key in pairs(ticket.fields) do
		table.insert(field_names, key)
	end
	table.sort(field_names)

	buf_text = {"Fields: "}
	for _, key in ipairs(field_names) do
		table.insert(buf_text, "\t" .. key .. ": " .. ticket.fields[key])
	end
	table.insert(buf_text, "")
	for i = 1, #ticket.comments do
		table.insert(buf_text, ticket.comments[i])
		table.insert(buf_text, "---")
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, true, buf_text)

	vim.api.nvim_open_win(buf, true, {split="right"})
end

function filter_fields(key)

	if key == "icomment" or 
		key == "foundin" or
		key == "icomment" or
		key == "priority" or
		key == "private_contact" or
		key == "resolution" or
		key == "severity" or
		key == "status" or
		key == "subsystem" or
		key == "title" or
		key == "type" then
		return true
	end
	return false
end

-- search_tickets
-- @param: report_id is the id of the report to be viewed
M.search_tickets = function()
	co = coroutine.create(select_ticket)
	local status, ticket = coroutine.resume(co)
	if status == false then
		error("Selection error finding ticket")
	end
end

return M
