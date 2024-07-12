return {
	{ 
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- ADAPTERS
			dap.adapters.codelldb = {
				type = 'server',
				port = "13299",
				executable = {
					command = '/home/tyler/.local/bin/codelldb',
					args = { "--port", "13299" },
				}
			}

			dap.adapters.python = function(cb, config)
			  if config.request == 'attach' then
				---@diagnostic disable-next-line: undefined-field
				local port = (config.connect or config).port
				---@diagnostic disable-next-line: undefined-field
				local host = (config.connect or config).host or '127.0.0.1'
				cb({
				  type = 'server',
				  port = assert(port, '`connect.port` is required for a python `attach` configuration'),
				  host = host,
				  options = {
					source_filetype = 'python',
				  },
				})
			  else
				cb({
				  type = 'executable',
				  command = '/home/tyler/Envs/debugpy/bin/python',
				  args = { '-m', 'debugpy.adapter' },
				  options = {
					source_filetype = 'python',
				  },
				})
			  end
			end


			-- CONFIGURATIONS
			dap.configurations.zig= {
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
						vim.ui.select(vim.fn.glob(vim.fn.getcwd() .. '/zig-out/**/*', false, true), {
							prompt = "Select executable",
							kind="file",
						}, 
						cb)
						return coroutine.yield()
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				}
			}

			dap.configurations.rust = {
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
						vim.ui.select(vim.fn.glob(vim.fn.getcwd() .. '/target/debug/**/*', false, true), {
							prompt = "Select executable",
							kind="file",
						}, 
						cb)
						return coroutine.yield()
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = function()
						return {vim.fn.input('Args: ')}
					end,
				}
			}

			dap.configurations.python = {
			  {
				-- The first three options are required by nvim-dap
				type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
				request = 'launch';
				name = "Launch file";

				-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

				program = "${file}"; -- This configuration will launch the current file if used.
				pythonPath = function()
				  -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
				  -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
				  -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
				  local cwd = vim.fn.getcwd()
				  if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
					return cwd .. '/venv/bin/python'
				  elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
					return cwd .. '/.venv/bin/python'
				  elseif vim.fn.executable(os.getenv("VIRTUAL_ENV") .. "/bin/python") == 1 then
					return os.getenv("VIRTUAL_ENV") .. "/bin/python"
				  else
					return '/usr/bin/python3'
				  end
				end;
			  },
			}



			-- keymaps
			vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { silent = true })
			vim.keymap.set("n", "<Leader>dB", function() dap.toggle_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
				{ silent = true })
			vim.keymap.set("n", "<Leader>dl", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
				{ silent = true })
			vim.keymap.set("n", "<Leader>dc", dap.continue, { silent = true })
			vim.keymap.set("n", "<Leader>dn", dap.step_over, { silent = true })
			vim.keymap.set("n", "<Leader>do", dap.step_out, { silent = true })
			vim.keymap.set("n", "<Leader>ds", dap.step_into, { silent = true })



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
						id = "scopes",
						size = 0.25
					  }, {
						id = "breakpoints",
						size = 0.25
					  }, {
						id = "stacks",
						size = 0.25
					  }, {
						id = "watches",
						size = 0.25
					  } },
					position = "left",
					size = 40
				  }, {
					elements = { {
						id = "repl",
						size = 0.5
					  }, {
						id = "console",
						size = 0.5
					  } },
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
		end,
	},
}
