local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim"
		}
	},
	{
		"folke/tokyonight.nvim"
	}
})

require("neo-tree").setup {
	filesystem = {
		filtered_items = {
			visible = true
		}
	}
}

vim.cmd[[ set number ]]
vim.cmd[[ set background=dark ]]
vim.cmd[[ colorscheme tokyonight-moon ]]
vim.cmd[[ Neotree ]]
