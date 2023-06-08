local packer = require("usr/packer")
local wk = require("usr/whichkey")

return {
	packer = {
		ns = "lsp",
		name = "packer",
		f = function(ctx)
			packer.M.addPlugin(ctx, {'williamboman/mason.nvim'})
			packer.M.addPlugin(ctx, {'neovim/nvim-lspconfig'})
			packer.M.addPlugin(ctx, {'williamboman/mason-lspconfig.nvim'})
			return true
		end
	},
	main = {
		ns = "lsp",
		name = "main",
		f = function(ctx)
			require("mason").setup()
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers {
				function(server_name)
					local opts = {
						on_attach = nil,
						capabilities = nil,
						flags = {
							debounce_text_changes = 150,
						},
					}
					if ctx:getRet("cmp", "main") then
						opts.capabilities = require('cmp_nvim_lsp').default_capabilities()
					else
						opts.capabilities = vim.lsp.protocol.make_client_capabilities()
					end
					require("lspconfig")[server_name].setup(opts)
				end,
			}
			return true
		end
	},
	keymap = {
		ns = "lsp",
		name = "keymap",
		f = function(ctx)
			wk.M.group(ctx, "l", "lsp")
			-- [L]sp [C]onfig LC
			wk.M.group(ctx, "lc", "Config")
			wk.M.keymap(ctx, "lcr", "<Cmd>LspRestart<CR>", "Lsp restart")
			-- [L]sp [D]iagnostics LD
			wk.M.group(ctx, "ld", "Diagnostics")
			wk.M.keymap(ctx, "ldf", vim.diagnostic.open_float, "Diagnostics")
			wk.M.keymap(ctx, "lds", vim.diagnostic.show, "Show diagnostics")
			wk.M.keymap(ctx, "ldh", vim.diagnostic.hide, "Hide diagnostics")
			-- [L]sp [F]ind LF
			wk.M.group(ctx, "lf", "Find")
			wk.M.keymap(ctx, "lfc", vim.lsp.buf.declaration, "Find declaration")
			wk.M.keymap(ctx, "lff", vim.lsp.buf.definition, "Find definition")
			wk.M.keymap(ctx, "lfi", vim.lsp.buf.implementation, "Find implementation")
			wk.M.keymap(ctx, "lfr", vim.lsp.buf.references, "Find references")
			wk.M.keymap(ctx, "lft", vim.lsp.buf.type_definition, "Find type definition")
			wk.M.keymap(ctx, "lfsw", vim.lsp.buf.workspace_symbol, "Find workspace symbol")
			wk.M.keymap(ctx, "lfsd", vim.lsp.buf.document_symbol, "Find document symbol")
			-- [L]sp [R]efactor LR
			wk.M.group(ctx, "lr", "Refactor")
			wk.M.keymap(ctx, "lrf", vim.lsp.buf.format, "Format")
			wk.M.keymap(ctx, "lrr", vim.lsp.buf.rename, "Rename")
			wk.M.keymap(ctx, "lra", vim.lsp.buf.code_action, "Code action")
			-- [Lsp] other LR
			wk.M.keymap(ctx, "ls", vim.lsp.buf.signature_help, "Signature help")
			wk.M.keymap(ctx, "lh", vim.lsp.buf.hover, "Hover")
			return true
		end
	}
}

-- local keymap = vim.keymap.set
-- local api = vim.api
--
-- ----------------- LSP servers --------------------------
-- local servers = {
--   pyright = {
--     analysis = {
--       typeCheckingMode = "off",
--     },
--   },
--   sumneko_lua = {
--     settings = {
--       Lua = {
--         runtime = {
--           version = "LuaJIT",
--           path = vim.split(package.path, ";"),
--         },
--         diagnostics = {
--           globals = { "vim" },
--         },
--         workspace = {
--           library = api.nvim_get_runtime_file("", true),
--         },
--         telemetry = { enable = false },
--       },
--     },
--   },
-- }
--
-- -------------- LSP functions --------------------------
--
-- local function keymappings(_, bufnr)
--   local opts = { noremap = true, silent = true }
--
--   keymap("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
--   keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
--   keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
--   keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
--   keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
--
--   keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
--   keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--   keymap("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
--   keymap("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
--   keymap("n", "gb", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
--
--   api.nvim_set_keymap("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true })
--   api.nvim_set_keymap("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })
-- end
--
-- local function highlighting(client, bufnr)
--   if client.server_capabilities.documentHighlightProvider then
--     local lsp_highlight_grp = api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
--     api.nvim_create_autocmd("CursorHold", {
--       callback = function()
--         vim.schedule(vim.lsp.buf.document_highlight)
--       end,
--       group = lsp_highlight_grp,
--       buffer = bufnr,
--     })
--     api.nvim_create_autocmd("CursorMoved", {
--       callback = function()
--         vim.schedule(vim.lsp.buf.clear_references)
--       end,
--       group = lsp_highlight_grp,
--       buffer = bufnr,
--     })
--   end
-- end
--
-- local function lsp_handlers()
--   local signs = {
--     { name = "DiagnosticSignError", text = "[E]" },
--     { name = "DiagnosticSignWarn", text = "[W]"},
--     { name = "DiagnosticSignHint", text = "[H]"},
--     { name = "DiagnosticSignInfo", text = "[i]"},
--   }
--   for _, sign in ipairs(signs) do
--     vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
--   end
--
--   -- LSP handlers configuration
--   local config = {
--     float = {
--       focusable = true,
--       style = "minimal",
--       border = "rounded",
--     },
--
--     diagnostic = {
--       virtual_text = { severity = vim.diagnostic.severity.ERROR },
--       signs = {
--         active = signs,
--       },
--       underline = true,
--       update_in_insert = false,
--       severity_sort = true,
--       float = {
--         focusable = true,
--         style = "minimal",
--         border = "rounded",
--         source = "always",
--         header = "",
--         prefix = "",
--       },
--     },
--   }
--
--   vim.diagnostic.config(config.diagnostic)
--   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)
--   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
-- end
--
-- local function formatting(client, bufnr)
--   if client.server_capabilities.documentFormattingProvider then
--     local function format()
--       local view = vim.fn.winsaveview()
--       vim.lsp.buf.format({
--         async = true,
--         filter = function(attached_client)
--           return attached_client.name ~= ""
--         end,
--       })
--       vim.fn.winrestview(view)
--     end
--
--     local lsp_format_grp = api.nvim_create_augroup("LspFormat", { clear = true })
--     api.nvim_create_autocmd("BufWritePre", {
--       callback = function()
--         vim.schedule(format)
--       end,
--       group = lsp_format_grp,
--       buffer = bufnr,
--     })
--   end
-- end
--
-- local function on_attach(client, bufnr)
--   -- api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
--   -- api.nvim_buf_set_option(bufnr, "completefunc", "v:lua.vim.lsp.omnifunc")
--   api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.MiniCompletion.completefunc_lsp")
--   api.nvim_buf_set_option(bufnr, "completefunc", "v:lua.MiniCompletion.completefunc_lsp")
--
--   api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
--   if client.server_capabilities.definitionProvider then
--     api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
--   end
--
--   keymappings(client, bufnr)
--   highlighting(client, bufnr)
--   formatting(client, bufnr)
--   -- signature_help(client, bufnr)
-- end
--
-- ----------------------------- LSP Setup -------------------------
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
--
-- lsp_handlers()
--
-- local opts = {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   flags = {
--     debounce_text_changes = 150,
--   },
-- }
--
-- -- nvim-lsp-installer must be set up before nvim-lspconfig
-- require("nvim-lsp-installer").setup({
--   ensure_installed = vim.tbl_keys(servers),
--   automatic_installation = false,
-- })
--
-- local lspconfig = require("lspconfig")
-- for server_name, _ in pairs(servers) do
--   local extended_opts = vim.tbl_deep_extend("force", opts, servers[server_name] or {})
--   lspconfig[server_name].setup(extended_opts)
-- end


