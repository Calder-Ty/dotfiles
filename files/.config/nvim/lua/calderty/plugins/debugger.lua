local splitStr = function(inputstr)
	split = "%s"
	local t = {}
	for str in string.gmatch(inputstr, "([^%s]+)") do
		table.insert(t, str)
	end
	return t
end

vim.pack.add({
	{src="https://github.com/mfussenegger/nvim-dap"},
	"https://github.com/nvim-neotest/nvim-nio",
	{src="https://github.com/rcarriga/nvim-dap-ui"},
})

local dap = require("dap")
local dapui = require("dapui")
local memoryview = require("calderty.memoryview")
memoryview.setup({})

-- ADAPTERS
dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

dap.adapters.codelldb = {
	type = 'server',
	port = "13299",
	executable = {
		command = 'lldb-dap',
		args = { "--port", "13299" },
	}
}

-- CONFIGURATIONS
dap.configurations.zig = {
	{
		name = "Run Program",
		type = "gdb",
		request = "launch",
		program = function()
			co = coroutine.running()
			if co then
				cb = function(item)
					coroutine.resume(co, item)
				end
			end
			cb = vim.schedule_wrap(cb)
			vim.ui.select(vim.fn.glob(vim.fn.getcwd() .. '**/zig-out/**/*', false, true), {
					prompt = "Select executable",
					kind = "file",
				},
				cb)
			return coroutine.yield()
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = function()
			return splitStr(vim.ui.input('Args: '))
		end,
	}
}

dap.configurations.c = {
	{
		name = "Run Program",
		type = "codelldb",
		request = "launch",
		program = function()
			co = coroutine.running()
			if co then
				cb = function(item)
					coroutine.resume(co, item)
				end
			end
			cb = vim.schedule_wrap(cb)
			vim.ui.select(vim.fn.glob(vim.fn.getcwd() .. '/bin/**/*', false, true), {
					prompt = "Select executable",
					kind = "file",
				},
				cb)
			return coroutine.yield()
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = function()
			return { vim.fn.input('Args: ') }
		end,
	}
}

-- keymaps
vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { silent = true })
vim.keymap.set("n", "<Leader>dB",
	function() dap.toggle_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
	{ silent = true })
vim.keymap.set("n", "<Leader>dl",
	function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
	{ silent = true })
vim.keymap.set("n", "<Leader>dc", dap.continue, { silent = true })
vim.keymap.set("n", "<Leader>dn", dap.step_over, { silent = true })
vim.keymap.set("n", "<Leader>do", dap.step_out, { silent = true })
vim.keymap.set("n", "<Leader>ds", dap.step_into, { silent = true })
vim.keymap.set("n", "<Leader>dv", function () dapui.float_element("scopes", {enter=true}) end , { silent = true })
vim.keymap.set("n", "<Leader>dt", function () dapui.float_element("console", {enter=true}) end , { silent = true })
vim.keymap.set("n", "<Leader>dm", memoryview.showInMemory, { silent = true })
vim.keymap.set("n", "<Leader>da", memoryview.showInMemoryAddr, { silent = true })


dapui.setup()
dap.listeners.after.event_initialized["debug_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dapui.setup({
	controls = {
		element = "repl",
		enabled = true,
	},
	element_mappings = {},
	expand_lines = true,
	floating = {
		border = "single",
		mappings = {
			close = { "q", "<Esc>" }
		}
	},
	force_buffers = true,
	layouts = { {
		elements = { {
			id = "watches",
			size = 0.5
		},
			{
				id = "repl",
				size = 0.5
			},
		},
		position = "bottom",
		size = 10
	} },
	mappings = {
		edit = "e",
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		repl = "r",
		toggle = "t"
	},
	render = {
		indent = 1,
		max_value_lines = 100
	}
})


