return {
	"marko-cerovac/material.nvim",
	name = "material",
	lazy = false,
	priority = 1000,
	config = function()
		-- ensure a dark background and pick the dark variant
		vim.o.background = "dark"
		vim.g.material_style = "darker" -- other options: "palenight", "oceanic", "lighter", etc.

		require("material").setup({
			-- your custom setup here
		})

		vim.cmd("colorscheme material")
	end,
}
