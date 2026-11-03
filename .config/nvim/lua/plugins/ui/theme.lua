return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("catppuccin-mocha")
		vim.cmd.colorscheme("inkstone-xuanmo")
	end,
}
