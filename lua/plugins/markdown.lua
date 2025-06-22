return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- Required
    "echasnovski/mini.nvim",           -- For icons (or use another icon provider)
    "nvim-tree/nvim-web-devicons",     -- Optional alternative icon plugin
  },
  opts = {
    completions = {
      blink = { enabled = true },
    },
    appearance = {
      heading = {
        icon = "󰉫",
        border = "solid",
        padding = 1,
        width = "full",
        color = "Title",
      },
      bullet = {
        icon = "•",
        color = "Comment",
        padding = 1,
      },
      checkbox = {
        icons = {
          [" "] = "󰄱",
          ["x"] = "󰄵",
          ["-"] = "󰜺",
        },
        color = "Boolean",
      },
      code_block = {
        border = "rounded",
        padding = 1,
        width = "full",
        background = "Visual",
      },
      callout = {
        icon = "",
        border = "none",
        line_padding = 1,
        color = "String",
      },
      table = {
        border = "solid",
        color = "Type",
        align = true,
      },
      link = {
        icon = "",
        color = "Identifier",
      },
      latex_block = {
        enabled = true,
        color = "Special",
      },
    },
    performance = {
      max_lines = 5000,
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)

    local map = vim.keymap.set
    local function nmap(lhs, rhs, desc)
      map("n", lhs, rhs, { noremap = true, silent = true, desc = desc })
    end

    nmap("<leader>Mm", "<cmd>RenderMarkdown toggle<CR>",   "Markdown: Toggle Render")
    nmap("<leader>Me", "<cmd>RenderMarkdown expand<CR>",   "Markdown: Expand View")
    nmap("<leader>Mc", "<cmd>RenderMarkdown contract<CR>", "Markdown: Contract View")
    nmap("<leader>ML", "<cmd>RenderMarkdown log<CR>",      "Markdown: Open Log")
    nmap("<leader>Md", "<cmd>RenderMarkdown debug<CR>",    "Markdown: Debug Line")
    nmap("<leader>Ms", "<cmd>RenderMarkdown config<CR>",   "Markdown: Show Config")
  end,
}
