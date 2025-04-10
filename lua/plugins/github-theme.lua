return {
	"projekt0n/github-nvim-theme",
	priority = 1000,
	config = function()
	  require("github-theme").setup({
		options = {
		  compile_path = vim.fn.stdpath("cache") .. "/github-theme",
		  compile_file_suffix = "_compiled",
		  hide_end_of_buffer = true,
		  hide_nc_statusline = true,
		  transparent = false, -- full control via highlights
		  terminal_colors = true,
		  dim_inactive = true,
		  module_default = true,
		  styles = {
			comments = "italic",
			functions = "bold",
			keywords = "italic",
			types = "bold",
			-- All others left unset (no style)
		  },
		  inverse = {
			match_paren = true,
			visual = false,
			search = true,
		  },
		  darken = {
			floats = true,
			sidebars = {
			  enable = true,
			  list = { "neo-tree", "qf", "help" },
			},
		  },
		  modules = {
			lsp_trouble = true,
			cmp = true,
			gitsigns = true,
			treesitter = true,
			telescope = true,
			dap = true,
			native_lsp = true,
		  },
		},
	  })
  
	  -- Set your preferred variant
	  vim.cmd("colorscheme github_dark_default")
  
	  -- Optional: Selective transparency
	  local hl = vim.api.nvim_set_hl
	  hl(0, "Normal", { bg = "none" })
	  hl(0, "NormalFloat", { bg = "none" })
	  hl(0, "FloatBorder", { bg = "none" })
	  hl(0, "TelescopeNormal", { bg = "none" })
	  hl(0, "TelescopeBorder", { bg = "none" })
	  hl(0, "Pmenu", { bg = "none" }) -- autocomplete menu
	end,
  }
  