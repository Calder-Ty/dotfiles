local function create_ziggy_filetype()
	vim.filetype.add({
		ziggy = 'ziggy',
		['ziggy-schema'] = 'ziggy_schema'
	})
	vim.api.nvim_create_autocmd('FileType', {
		group = vim.api.nvim_create_augroup('ziggy', {clear=true}),
		pattern = 'ziggy',
		callback = function()
			vim.lsp.start {
				name = 'Ziggy LSP',
				cmd = { 'ziggy', 'lsp' },
				root_dir = vim.loop.cwd(),
				flags = { exit_timeout = 1000 , debounce_text_changes=150},
			}
		end,
	})
	local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
	parser_config.ziggy = {
		install_info = {
			url = 'https://github.com/kristoff-it/ziggy',
			includes = { 'tree-sitter-ziggy/src' },
			files = { 'tree-sitter-ziggy/src/parser.c' },
			branch = 'main',
			generate_requires_npm = false,
			requires_generate_from_grammar = false,
		},
		filetype = 'ziggy',
	}

	parser_config.ziggy_schema = {
		install_info = {
			url = 'https://github.com/kristoff-it/ziggy',
			files = { 'tree-sitter-ziggy-schema/src/parser.c' },
			branch = 'main',
			generate_requires_npm = false,
			requires_generate_from_grammar = false,
		},
		filetype = 'ziggy-schema',
	}
end

create_ziggy_filetype()
