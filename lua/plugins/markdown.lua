return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons", -- Primary icon provider
  },
  opts = {
    -- Enable render-markdown for specific file types
    file_types = { "markdown" },

    -- Completion integration
    completion = {
      -- Updated key name from 'completions'
      blink = { enabled = true },
    },

    -- Rendering configuration
    render = {
      -- Maximum file size to render (in bytes)
      max_file_size = 10.0, -- 10MB
      -- Debounce rendering updates
      debounce = 100,
    },

    -- Visual appearance settings
    heading = {
      -- Heading styles for different levels
      enabled = true,
      sign = true,
      position = "overlay",
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      signs = { "󰫎 " },
      width = "full",
      left_pad = 0,
      right_pad = 0,
      min_width = 0,
      border = true,
      border_virtual = false,
      border_prefix = false,
      above = "▄",
      below = "▀",
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
    },

    -- Code block rendering
    code = {
      enabled = true,
      sign = true,
      style = "full",
      position = "left",
      language_pad = 0,
      disable_background = { "diff" },
      width = "full",
      left_pad = 0,
      right_pad = 0,
      min_width = 0,
      border = "thin",
      above = "▄",
      below = "▀",
      highlight = "RenderMarkdownCode",
      highlight_inline = "RenderMarkdownCodeInline",
    },

    -- Bullet point configuration
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
      left_pad = 0,
      right_pad = 0,
      highlight = "RenderMarkdownBullet",
    },

    -- Checkbox rendering
    checkbox = {
      enabled = true,
      position = "inline",
      unchecked = {
        icon = "󰄱 ",
        highlight = "RenderMarkdownUnchecked",
        scope_highlight = nil,
      },
      checked = {
        icon = "󰱒 ",
        highlight = "RenderMarkdownChecked",
        scope_highlight = nil,
      },
      custom = {
        todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
      },
    },

    -- Quote/blockquote rendering
    quote = {
      enabled = true,
      icon = "▎",
      repeat_linebreak = false,
      highlight = "RenderMarkdownQuote",
    },

    -- Pipe table configuration
    pipe_table = {
      enabled = true,
      preset = "none",
      style = "full",
      cell = "padded",
      border = {
        "┌", "┬", "┐",
        "├", "┼", "┤",
        "└", "┴", "┘",
        "│", "─",
      },
      alignment_indicator = "━",
      head = "RenderMarkdownTableHead",
      row = "RenderMarkdownTableRow",
      filler = "RenderMarkdownTableFill",
    },

    -- Callout blocks (admonitions)
    callout = {
      note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
      tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
      important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
      warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
      caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
      -- Custom callouts
      abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 Abstract", highlight = "RenderMarkdownInfo" },
      summary = { raw = "[!SUMMARY]", rendered = "󰨸 Summary", highlight = "RenderMarkdownInfo" },
      info = { raw = "[!INFO]", rendered = "󰋽 Info", highlight = "RenderMarkdownInfo" },
      todo = { raw = "[!TODO]", rendered = "󰗡 Todo", highlight = "RenderMarkdownWarn" },
      hint = { raw = "[!HINT]", rendered = "󰌶 Hint", highlight = "RenderMarkdownSuccess" },
      success = { raw = "[!SUCCESS]", rendered = "󰄬 Success", highlight = "RenderMarkdownSuccess" },
      check = { raw = "[!CHECK]", rendered = "󰄬 Check", highlight = "RenderMarkdownSuccess" },
      done = { raw = "[!DONE]", rendered = "󰄬 Done", highlight = "RenderMarkdownSuccess" },
      question = { raw = "[!QUESTION]", rendered = "󰘥 Question", highlight = "RenderMarkdownWarn" },
      help = { raw = "[!HELP]", rendered = "󰘥 Help", highlight = "RenderMarkdownWarn" },
      faq = { raw = "[!FAQ]", rendered = "󰘥 FAQ", highlight = "RenderMarkdownWarn" },
      attention = { raw = "[!ATTENTION]", rendered = "󰀪 Attention", highlight = "RenderMarkdownWarn" },
      failure = { raw = "[!FAILURE]", rendered = "󰅖 Failure", highlight = "RenderMarkdownError" },
      fail = { raw = "[!FAIL]", rendered = "󰅖 Fail", highlight = "RenderMarkdownError" },
      missing = { raw = "[!MISSING]", rendered = "󰅖 Missing", highlight = "RenderMarkdownError" },
      danger = { raw = "[!DANGER]", rendered = "󱐌 Danger", highlight = "RenderMarkdownError" },
      error = { raw = "[!ERROR]", rendered = "󰅖 Error", highlight = "RenderMarkdownError" },
      bug = { raw = "[!BUG]", rendered = "󰨰 Bug", highlight = "RenderMarkdownError" },
      example = { raw = "[!EXAMPLE]", rendered = "󰉹 Example", highlight = "RenderMarkdownHint" },
      quote = { raw = "[!QUOTE]", rendered = "󱆨 Quote", highlight = "RenderMarkdownQuote" },
      cite = { raw = "[!CITE]", rendered = "󱆨 Cite", highlight = "RenderMarkdownQuote" },
    },

    -- Link rendering
    link = {
      enabled = true,
      image = "󰥶 ",
      email = "󰀓 ",
      hyperlink = "󰌹 ",
      highlight = "RenderMarkdownLink",
      custom = {
        web = { pattern = "^http[s]?://", icon = "󰖟 ", highlight = "RenderMarkwindowarkdownLink" },
      },
    },

    -- Sign configuration
    sign = {
      enabled = true,
      highlight = "RenderMarkdownSign",
    },

    -- Inline code
    inline_code = {
      enabled = true,
      corner_left = " ",
      corner_right = " ",
      highlight = "RenderMarkdownCodeInline",
    },

    -- HTML rendering
    html = {
      enabled = true,
      comment = {
        text = "󰅲",
        highlight = "RenderMarkdownHtml",
      },
    },

    -- LaTeX support
    latex = {
      enabled = true,
      converter = "latex2text",
      highlight = "RenderMarkdownMath",
      top_pad = 0,
      bottom_pad = 0,
    },

    -- Performance settings
    max_file_size = 10.0, -- MB
    debounce = 100, -- ms

    -- Anti-conceal for better editing experience
    anti_conceal = {
      enabled = true,
      ignore = {
        code_background = true,
        sign = false,
      },
    },

    -- Window options
    win_options = {
      conceallevel = {
        default = vim.o.conceallevel,
        rendered = 3,
      },
      concealcursor = {
        default = vim.o.concealcursor,
        rendered = "",
      },
    },
  },

  config = function(_, opts)
    require("render-markdown").setup(opts)

    -- Create autocommand group for markdown keymaps
    local markdown_group = vim.api.nvim_create_augroup("RenderMarkdownKeymaps", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      group = markdown_group,
      callback = function(ev)
        local map_opts = { buffer = ev.buf, silent = true, noremap = true }

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", map_opts, { desc = "Markdown: " .. desc }))
        end

        -- Toggle and view controls
        map("n", "<leader>mt", "<cmd>RenderMarkdown toggle<CR>", "Toggle render")
        map("n", "<leader>me", "<cmd>RenderMarkdown enable<CR>", "Enable render")
        map("n", "<leader>md", "<cmd>RenderMarkdown disable<CR>", "Disable render")

        -- Debugging and configuration
        map("n", "<leader>ml", "<cmd>RenderMarkdown log<CR>", "Show log")
        map("n", "<leader>mD", "<cmd>RenderMarkdown debug<CR>", "Debug current line")
        map("n", "<leader>mc", "<cmd>RenderMarkdown config<CR>", "Show config")

        -- Expand/contract view
        map("n", "<leader>mE", "<cmd>RenderMarkdown expand<CR>", "Expand view")
        map("n", "<leader>mC", "<cmd>RenderMarkdown contract<CR>", "Contract view")
      end,
    })
  end,
}
