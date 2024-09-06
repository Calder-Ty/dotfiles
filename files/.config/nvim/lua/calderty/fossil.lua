-- plugin code for managing and working with
-- fossil
--
-- Thing Fugitive, but for fossil
--
-- Better names will be had in the future
M = {}



-- TICKETS
--
-- Fossil has some great ticket Management Capabilities
-- We can add Tickets, List Tickets, Respond to Tickets
-- and View tickets.

-- view_tickets
-- @param: report_id is the id of the report to be viewed
M.view_tickets = function (report_id)
	-- XXX: This is not safe, we are just taking user input and running it
	-- Fix this before releasing it.
	vim.system({'fossil', 'ticket', 'show', report_id}, {}, function(obj)
		print(obj.code)
		if obj.code ~= 0 then
			error(obj.stderr)
			return
		end
		print(obj.stdout)
	end
	)
end



return M
