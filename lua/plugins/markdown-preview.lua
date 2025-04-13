-- This file configures the 'markdown-preview.nvim' plugin, which allows you
-- to preview Markdown files in your web browser directly from Neovim. It
-- handles starting a local server and opening the preview.

return {
  "iamcco/markdown-preview.nvim", -- The plugin specification: name of the GitHub repository.
  ft = { "markdown" }, -- Specifies that this plugin should only be loaded when
                       -- a file of type "markdown" is opened.
  build = function() -- A function that is executed after the plugin is installed.
      vim.fn["mkdp#util#install"]() -- Calls a Vim function provided by the
                                   -- plugin to install necessary dependencies
                                   -- (likely a Markdown processor).
  end,
  cmd = { -- Defines the Neovim commands provided by this plugin.
      "MarkdownPreviewToggle", -- Toggles the Markdown preview in the browser.
      "MarkdownPreview",       -- Opens the Markdown preview in the browser.
      "MarkdownPreviewStop",   -- Stops the local server used for the preview.
  },
  init = function() -- Initialization function that runs when the plugin is loaded.
      -- Default global variables for 'markdown-preview.nvim'. These configure
      -- various aspects of the preview behavior.
      vim.g.mkdp_auto_start = 0           -- Do not automatically start the preview
                                           -- when a Markdown file is opened.
      vim.g.mkdp_auto_close = 1           -- Automatically close the preview when
                                           -- the Neovim buffer is closed.
      vim.g.mkdp_refresh_slow = 0         -- Do not use a slow refresh mechanism.
      vim.g.mkdp_command_for_global = 0   -- Use a buffer-local command by default.
      vim.g.mkdp_open_to_the_world = 0    -- Do not open the server to the network
                                           -- by default (localhost only).
      vim.g.mkdp_open_ip = ""             -- Specify the IP address to bind to (empty
                                           -- means localhost).
      vim.g.mkdp_browser = ""             -- Use the default system browser. You can
                                           -- specify a browser executable here (e.g., "firefox").
      vim.g.mkdp_echo_preview_url = 0     -- Do not echo the preview URL.
      vim.g.mkdp_browserfunc = ""         -- Use the default browser opening function.
      vim.g.mkdp_preview_options = {      -- Options passed to the Markdown processor.
          mkit = {},                      -- Options for the Markdown-it library.
          katex = {},                     -- Options for KaTeX (for math rendering).
          uml = {},                       -- Options for UML diagrams.
          maid = {},                      -- Options for Maid diagrams.
          disable_sync_scroll = 0,        -- Enable synchronized scrolling between
                                           -- the Neovim buffer and the preview.
          sync_scroll_type = "middle",    -- Scroll to keep the middle of the
                                           -- Neovim window in the middle of the preview.
          hide_yaml_meta = 1,             -- Hide YAML metadata at the beginning
                                           -- of the Markdown file.
          sequence_diagrams = {},         -- Options for sequence diagrams.
          flowchart_diagrams = {},        -- Options for flowchart diagrams.
          content_editable = false,       -- Make the preview non-editable.
          disable_filename = 0,           -- Show the filename in the preview.
          toc = {}                        -- Options for the Table of Contents.
      }
      vim.g.mkdp_markdown_css = ""        -- Custom CSS to apply to the Markdown.
      vim.g.mkdp_highlight_css = ""       -- Custom CSS for syntax highlighting.
      vim.g.mkdp_port = ""                -- Specify the port for the local server
                                           -- (empty means auto-selection).
      vim.g.mkdp_page_title = "「${name}」" -- Title format for the preview page.
                                           -- "${name}" will be replaced by the filename.
      vim.g.mkdp_images_path = vim.fn.expand("~/.markdown_images") -- Default path
                                           -- for images (you might want to adjust this).
      vim.g.mkdp_filetypes = { "markdown" } -- List of filetypes for which the
                                           -- preview is enabled.
      vim.g.mkdp_theme = "dark"           -- Default theme for the preview ("dark" or "light").
      vim.g.mkdp_combine_preview = 0      -- Do not combine multiple previews into one tab.
      vim.g.mkdp_combine_preview_auto_refresh = 1 -- Automatically refresh combined previews.
  end,
  keys = { -- Defines keybindings for interacting with the plugin.
      { "<C-s>", "<Plug>MarkdownPreview", mode = "n", desc = "Start Markdown Preview" },
      -- Ctrl+s in normal mode will trigger the MarkdownPreview command.
      { "<M-s>", "<Plug>MarkdownPreviewStop", mode = "n", desc = "Stop Markdown Preview" },
      -- Alt+s (or Meta+s) in normal mode will trigger the MarkdownPreviewStop command.
      { "<C-p>", "<Plug>MarkdownPreviewToggle", mode = "n", desc = "Toggle Markdown Preview" },
      -- Ctrl+p in normal mode will toggle the MarkdownPreviewToggle command.
      -- <Plug> mappings are special mappings defined by the plugin.
  },
}