-- lua/config/keymaps.lua - Simplified for Neovim 0.11

local map = vim.keymap.set
local opts = { silent = true }

-- General
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Increment/Decrement
map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Clipboard
map("v", "p", '"_dP', { desc = "Paste without replacing clipboard" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })

-- File operations
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR><ESC>", { desc = "Save file" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- Navigation improvements
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Window navigation (no conflicts)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window splits
map("n", "<leader>|", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>-", "<cmd>split<CR>", { desc = "Horizontal split" })

-- Buffer management
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Visual mode enhancements
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Terminal
map("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Diagnostic navigation (Neovim 0.11 has better defaults, minimal additions)
map("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show diagnostic in float" })
map("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostic quickfix" })

-- Quickfix
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
map("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })

-- Files - Snacks picker with fallback
map("n", "<leader><space>", function()
    if package.loaded["snacks"] and require("snacks").picker then
        require("snacks").picker.files()
    elseif package.loaded["fzf-lua"] then
        require("fzf-lua").files()
    else
        vim.cmd("find .")
    end
end, { desc = "Find Files" })

-- LSP keymaps - Applied when LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
    callback = function(ev)
        local buffer_opts = { buffer = ev.buf, silent = true }

        -- Basic LSP navigation
        map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", buffer_opts, { desc = "Go to Definition" }))
        map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", buffer_opts, { desc = "References" }))
        map("n", "gi", vim.lsp.buf.implementation,
            vim.tbl_extend("force", buffer_opts, { desc = "Go to Implementation" }))
        map("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", buffer_opts, { desc = "Type Definition" }))

        -- Documentation and help
        map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", buffer_opts, { desc = "Hover Documentation" }))
        map("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", buffer_opts, { desc = "Signature Help" }))
        map("i", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", buffer_opts, { desc = "Signature Help" }))

        -- Code actions
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
            vim.tbl_extend("force", buffer_opts, { desc = "Code Action" }))
        map("n", "<leader>cr", vim.lsp.buf.rename, vim.tbl_extend("force", buffer_opts, { desc = "Rename Symbol" }))

        -- Inlay hints toggle (Neovim 0.11+)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.supports_method("textDocument/inlayHint") then
            map("n", "<leader>lh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
            end, vim.tbl_extend("force", buffer_opts, { desc = "Toggle Inlay Hints" }))
        end
    end,
})

-- Utility keymaps
map("n", "<leader>x", "<cmd>source %<CR>", { desc = "Source current file" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })
