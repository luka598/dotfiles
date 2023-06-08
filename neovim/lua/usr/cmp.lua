local namespace = "cmp"
return {
	packer = {
		ns = namespace,
		name = "packer",
		f = function(ctx)
			if ctx:getRet("packer", "init") then
				local packer = require("usr/packer")
				if ctx:getRet("lsp", "packer") then
					packer.M.addPlugin(ctx, {'hrsh7th/cmp-nvim-lsp'})
				end
				packer.M.addPlugin(ctx, {'hrsh7th/cmp-buffer'})
				packer.M.addPlugin(ctx, {'hrsh7th/cmp-path'})
				packer.M.addPlugin(ctx, {'hrsh7th/cmp-cmdline'})
				packer.M.addPlugin(ctx, {'hrsh7th/nvim-cmp'})
				packer.M.addPlugin(ctx, {'hrsh7th/cmp-vsnip'})
				packer.M.addPlugin(ctx, {'hrsh7th/vim-vsnip'})
			end
			return true
		end
	},
	main = {
		ns = namespace,
		name = "main",
		f = function(ctx)
			local cmp = require('cmp')

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				-- TODO: Move this to keymap
				mapping = cmp.mapping.preset.insert({
					['<Tab>'] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end,
					['<S-Tab>'] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end,
					['<C-Space>'] = cmp.mapping.complete(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
					['<C-e>'] = cmp.mapping.abort(),
					['<Esc>'] = cmp.mapping.close(),
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
				}
				),
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'vsnip' },
					{ name = 'nvim_lua' },
					{ name = 'path' },
					{ name = 'buffer', keyword_length = 999 },
					{ name = 'spell' },
					{ name = 'calc' },
					{ name = 'omni' },
					{ name = 'emoji', insert = true, }
				},
				completion = {
					keyword_length = 9999,
					completeopt = "menu,noselect",
					max_items = 5
				},
			})
			return true
		end
	},
	keymap = {
		ns = namespace,
		name = "keymap",
		f = function(ctx)
			if ctx:reqRet("which-key", "init") then
				local wk = require("usr/whichkey")
				-- wk.M.keymap(ctx, "cl", "gcc", "Comment line")
			end
			return true
		end
	}
}
