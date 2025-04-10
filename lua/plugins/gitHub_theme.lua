return {
	"projekt0n/github-nvim-theme",
	config = function()
		require("github-theme").setup({
			options = {
				transparent = true,
				styles = {
					comments = "italic",
					keywords = "bold",
					functions = "italic,bold",
					variables = "none",
				},
			},
		})
		vim.cmd("colorscheme github_dark_default") -- you can choose github_dark, github_light, github_dimmed, etc.
	end,
	build = function()
		-- No build step needed for this theme, but you can reload or reapply config here if needed
	end,
}

