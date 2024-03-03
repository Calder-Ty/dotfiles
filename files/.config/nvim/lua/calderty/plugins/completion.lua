return {
	{
		"hrsh7th/nvim-cmp", 
		commit = "1cad30fcffa282c0a9199c524c821eadc24bf939",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require 'cmp'
			local lspkind = require 'lspkind'


			function formatting()
				return {
					format = lspkind.cmp_format({
						with_text = true,
						maxwidth = 50,
						mode = "text",
						menu = ({
							buffer = "󰈔 ",
							nvim_lsp = "λ ",
							path = " ",
							luasnip = " ",
						})
					})
				}
			end

			cmp.setup {
				-- Enable LSP snippets

				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				mapping = {
					['<C-n>'] = cmp.mapping.select_next_item(
						{ behaviour = cmp.SelectBehavior.Select }
					),
					['<C-p>'] = cmp.mapping.select_prev_item(
						{ behaviour = cmp.SelectBehavior.Select }
					),
					['<C-s>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.close(),
					['<C-y>'] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					})
				},

				-- Installed sources
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'vsnip' },
					{ name = 'path' },
					{ name = 'nvim_lua' },
					{ name = 'buffer', keyword_length = 5 },
				},

				formatting = formatting(),

				experimental = {
					ghost_text = true
				}
			}
		end
	}
}
