return {
	ns = "colorscheme",
	name = "main",
	f = function()
		vim.g.gruvbox_contrast_dark = 'dark'
		vim.cmd('colorscheme gruvbox')
		return true
	end
}

