-- return {
--   "echasnovski/mini.statusline",
--   version = false,
--   config = function()
--     local statusline = require("mini.statusline")

--     statusline.setup({
--       use_icons = true,
--       content = {
--         active = function()
--           local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })

--           -- Section B: Branch and Diff (like lualine_b)
--           local git = statusline.section_git({ trunc_width = 40 })
--           local diff = statusline.section_diff({
--             trunc_width = 75,
--             symbols = { add = " ", change = " ", delete = " " }
--           })

--           -- Section C: Filetype icon + filename (like lualine_c)
--           local function get_filetype_icon()
--             local filetype = vim.bo.filetype
--             if filetype == "" then return "" end
--             local ok, devicons = pcall(require, "nvim-web-devicons")
--             if ok then
--               local icon = devicons.get_icon_by_filetype(filetype)
--               return icon and (icon .. " ") or ""
--             end
--             return ""
--           end

--           local filename = statusline.section_filename({ trunc_width = 140 })
--           local filetype_icon = get_filetype_icon()

--           -- Section X: Diagnostics + LSP + encoding + fileformat (like lualine_x)
--           local diagnostics = statusline.section_diagnostics({
--             trunc_width = 75,
--             signs = { ERROR = " ", WARN = " ", INFO = " ", HINT = " " }
--           })

--           -- Custom LSP section to match your lualine config exactly
--           local function get_lsp_clients()
--             local clients = vim.lsp.get_clients({ bufnr = 0 })
--             if vim.tbl_isempty(clients) then return "" end

--             local names, added = {}, {}
--             for _, client in ipairs(clients) do
--               if client.name and not added[client.name] then
--                 table.insert(names, client.name)
--                 added[client.name] = true
--               end
--             end

--             return #names > 0 and "󰒍 LSP: " .. table.concat(names, ", ") or ""
--           end

--           local function get_encoding()
--             local encoding = vim.bo.fileencoding
--             if encoding == "" then encoding = vim.o.encoding end
--             return encoding:upper()
--           end

--           local function get_fileformat()
--             local format = vim.bo.fileformat
--             local icons = { unix = "", dos = "", mac = "" }
--             return icons[format] or format
--           end

--           -- Section Y: Progress (like lualine_y)
--           local function get_progress()
--             local cur = vim.fn.line(".")
--             local total = vim.fn.line("$")
--             if cur == 1 then
--               return "Top"
--             elseif cur == total then
--               return "Bot"
--             else
--               return string.format("%2d%%%%", math.floor(cur / total * 100))
--             end
--           end

--           -- Section Z: Location (like lualine_z)
--           local location = statusline.section_location({ trunc_width = 75 })

--           -- Combine all sections like lualine layout
--           return statusline.combine_groups({
--             -- Section A: Mode
--             { hl = mode_hl, strings = { mode } },

--             -- Section B: Git branch and diff
--             { hl = "MiniStatuslineDevinfo", strings = { git, diff } },

--             -- Section C: Filetype icon + filename
--             { hl = "MiniStatuslineFilename", strings = { filetype_icon .. filename } },

--             "%<", -- Truncate point
--             "%=", -- Right align from here

--             -- Section X: Diagnostics, LSP, encoding, fileformat
--             { hl = "MiniStatuslineDevinfo", strings = {
--               diagnostics,
--               get_lsp_clients(),
--               get_encoding(),
--               get_fileformat()
--             }},

--             -- Section Y: Progress
--             { hl = "MiniStatuslineFileinfo", strings = { get_progress() } },

--             -- Section Z: Location
--             { hl = mode_hl, strings = { location } },
--           })
--         end,

--         inactive = function()
--           -- Match your lualine inactive_sections
--           local filename = statusline.section_filename({ trunc_width = 140 })
--           local location = statusline.section_location({ trunc_width = 75 })

--           return statusline.combine_groups({
--             { hl = "MiniStatuslineInactive", strings = { filename } },
--             "%=",
--             { hl = "MiniStatuslineInactive", strings = { location } },
--           })
--         end,
--       },
--     })

--     -- Custom highlight groups to match github_dark theme colors
--     local colors = {
--       normal = "#0969da",
--       insert = "#1a7f37",
--       visual = "#8250df",
--       replace = "#cf222e",
--       command = "#fb8500",
--       other = "#656d76",
--       bg = "#0d1117",
--       fg = "#f0f6fc",
--       inactive = "#21262d",
--     }

--     vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { fg = "#ffffff", bg = colors.normal, bold = true })
--     vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { fg = "#ffffff", bg = colors.insert, bold = true })
--     vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { fg = "#ffffff", bg = colors.visual, bold = true })
--     vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { fg = "#ffffff", bg = colors.replace, bold = true })
--     vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { fg = "#ffffff", bg = colors.command, bold = true })
--     vim.api.nvim_set_hl(0, "MiniStatuslineModeOther", { fg = "#ffffff", bg = colors.other, bold = true })

--     -- Additional highlight groups for better theming
--     vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { fg = colors.fg, bg = colors.inactive })
--     vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = colors.fg, bg = colors.bg })
--     vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { fg = colors.fg, bg = colors.inactive })
--     vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { fg = "#656d76", bg = colors.bg })
--   end,
--   desc = "Status line matching lualine style",
-- }
