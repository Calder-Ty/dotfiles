local function create_supermd_filetype()
	vim.filetype.add({
		smd = 'supermd',
	})
	local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
	parser_config.supermd = {
		install_info = {
			url = 'https://github.com/kristoff-it/supermd',
			includes = { 'tree-sitter/supermd/src' },
			files = {
				'tree-sitter/supermd/src/parser.c',
				'tree-sitter/supermd/src/scanner.c'
			},
			branch = 'main',
			generate_requires_npm = false,
			requires_generate_from_grammar = false,
		},
		filetype = 'supermd',
	}
	parser_config.supermd_inline = {
		install_info = {
			url = 'https://github.com/kristoff-it/supermd',
			includes = { 'tree-sitter/supermd-inline/src' },
			files = {
				'tree-sitter/supermd-inline/src/parser.c',
				'tree-sitter/supermd-inline/src/scanner.c'
			},
			branch = 'main',
			generate_requires_npm = false,
			requires_generate_from_grammar = false,
		},
		filetype = 'supermd_inline',
	}
end

create_supermd_filetype()
