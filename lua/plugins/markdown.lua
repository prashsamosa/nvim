return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },

  opts = {
    file_types = { "markdown" },
    heading = { enabled = true, icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " } },
    code = { enabled = true, style = "full", border = "thin" },
    bullet = { enabled = true, icons = { "•", "◦", "▸", "▹" } },
    checkbox = {
      enabled = true,
      unchecked = { icon = "☐ " },
      checked = { icon = "☑ " },
    },
  },

  config = function(_, opts)
    require("render-markdown").setup(opts)
    vim.keymap.set("n", "<leader>mt", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle markdown render" })
  end,
}
