-- lua/config/keymaps.lua - FIXED VERSION
local keymap = vim.keymap

-- General
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode", silent = true })
keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights", silent = true })

-- Increment/Decrement
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number", silent = true })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number", silent = true })

-- Clipboard - Fixed: Better paste behavior
keymap.set("v", "p", '"_dP', { desc = "Paste without replacing clipboard", silent = true })
keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard", silent = true })
keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard", silent = true })

-- Clear search, diff update, and redraw
keymap.set("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / Clear hlsearch / Diff update", silent = true })

-- Enhanced diagnostic keymaps (supplement 0.11 defaults)
keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic loclist", silent = true })
keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostic quickfix", silent = true })
keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show diagnostic in float", silent = true })
keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic in float", silent = true })

-- File saving - Enhanced
keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR><ESC>", { desc = "Save file", silent = true })
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file", silent = true })
keymap.set("n", "<leader>W", "<cmd>wa<CR>", { desc = "Save all files", silent = true })

-- Quickfix/Location list navigation
keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix item", silent = true })
keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix item", silent = true })
keymap.set("n", "]Q", "<cmd>clast<CR>", { desc = "Last quickfix item", silent = true })
keymap.set("n", "[Q", "<cmd>cfirst<CR>", { desc = "First quickfix item", silent = true })
keymap.set("n", "]l", "<cmd>lnext<CR>", { desc = "Next location list item", silent = true })
keymap.set("n", "[l", "<cmd>lprev<CR>", { desc = "Previous location list item", silent = true })

-- Window navigation - FIXED: Removed <C-k> conflict
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window", silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window", silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window", silent = true })

-- Window resizing
keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height", silent = true })
keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height", silent = true })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width", silent = true })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width", silent = true })

-- Window splitting - Enhanced
keymap.set("n", "<leader>-", "<cmd>split<CR>", { desc = "Horizontal split", silent = true })
keymap.set("n", "<leader>|", "<cmd>vsplit<CR>", { desc = "Vertical split", silent = true })
keymap.set("n", "sh", "<cmd>split<CR>", { desc = "Horizontal split", silent = true })
keymap.set("n", "sv", "<cmd>vsplit<CR>", { desc = "Vertical split", silent = true })

-- Window management
keymap.set("n", "<leader>wd", "<cmd>close<CR>", { desc = "Close window", silent = true })
keymap.set("n", "<leader>wo", "<cmd>only<CR>", { desc = "Close other windows", silent = true })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Equalize window sizes", silent = true })

-- Alternative window navigation using <leader>
keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Move to left window", silent = true })
keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move to lower window", silent = true })
keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move to upper window", silent = true })
keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Move to right window", silent = true })

-- Files - Use Snacks picker if available, fallback to fzf-lua
keymap.set("n", "<leader><space>", function()
    if package.loaded["snacks"] and require("snacks").picker then
        require("snacks").picker.files()
    elseif package.loaded["fzf-lua"] then
        require("fzf-lua").files()
    else
        vim.cmd("find")
    end
end, { desc = "Find Files", silent = true })

-- Terminal mode - Enhanced
keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })
keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: Move to left window", silent = true })
keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: Move to lower window", silent = true })
keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: Move to right window", silent = true })

-- Visual mode enhancements
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- Better indenting
keymap.set("v", "<", "<gv", { desc = "Indent left and reselect", silent = true })
keymap.set("v", ">", ">gv", { desc = "Indent right and reselect", silent = true })

-- Enhanced text manipulation
keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor", silent = true })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center", silent = true })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center", silent = true })
keymap.set("n", "n", "nzzzv", { desc = "Next search result and center", silent = true })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center", silent = true })

-- Buffer management - Enhanced
keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer", silent = true })
keymap.set("n", "<leader>bD", "<cmd>bdelete!<CR>", { desc = "Force delete buffer", silent = true })
keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer", silent = true })
keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer", silent = true })
keymap.set("n", "<leader>bl", function()
    vim.cmd.buffer("#")
end, { desc = "Switch to last buffer", silent = true })

-- Tab management
keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab", silent = true })
keymap.set("n", "<leader>td", "<cmd>tabclose<CR>", { desc = "Close tab", silent = true })
keymap.set("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Close other tabs", silent = true })
keymap.set("n", "]t", "<cmd>tabnext<CR>", { desc = "Next tab", silent = true })
keymap.set("n", "[t", "<cmd>tabprevious<CR>", { desc = "Previous tab", silent = true })

-- FZF-lua LSP keymaps - Available when both LSP and FZF-lua are loaded
keymap.set("n", "<leader>fgd", function()
    if package.loaded["fzf-lua"] then
        require("fzf-lua").lsp_definitions()
    else
        vim.lsp.buf.definition()
    end
end, { desc = "Go to Definition (FZF)", silent = true })

keymap.set("n", "<leader>fgr", function()
    if package.loaded["fzf-lua"] then
        require("fzf-lua").lsp_references()
    else
        vim.lsp.buf.references()
    end
end, { desc = "Go to References (FZF)", silent = true })

keymap.set("n", "<leader>fgi", function()
    if package.loaded["fzf-lua"] then
        require("fzf-lua").lsp_implementations()
    else
        vim.lsp.buf.implementation()
    end
end, { desc = "Go to Implementation (FZF)", silent = true })

keymap.set("n", "<leader>fgt", function()
    if package.loaded["fzf-lua"] then
        require("fzf-lua").lsp_typedefs()
    else
        vim.lsp.buf.type_definition()
    end
end, { desc = "Type Definition (FZF)", silent = true })

keymap.set("n", "<leader>fds", function()
    if package.loaded["fzf-lua"] then
        require("fzf-lua").lsp_document_symbols()
    else
        vim.notify("FZF-lua not available for document symbols", vim.log.levels.WARN)
    end
end, { desc = "Document Symbols (FZF)", silent = true })

keymap.set("n", "<leader>fws", function()
    if package.loaded["fzf-lua"] then
        require("fzf-lua").lsp_workspace_symbols()
    else
        vim.notify("FZF-lua not available for workspace symbols", vim.log.levels.WARN)
    end
end, { desc = "Workspace Symbols (FZF)", silent = true })

-- LSP Keymaps (Applied when LSP attaches to buffer)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- Basic LSP navigation
        keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP: Go to Definition" }))
        keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "LSP: Go to Declaration" }))
        keymap.set("n", "gi", vim.lsp.buf.implementation,
            vim.tbl_extend("force", opts, { desc = "LSP: Go to Implementation" }))
        keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "LSP: References" }))
        keymap.set("n", "gt", vim.lsp.buf.type_definition,
            vim.tbl_extend("force", opts, { desc = "LSP: Type Definition" }))

        -- Documentation and help
        keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP: Hover Documentation" }))
        keymap.set("n", "<leader>k", vim.lsp.buf.signature_help,
            vim.tbl_extend("force", opts, { desc = "LSP: Signature Help" }))
        keymap.set("i", "<C-k>", vim.lsp.buf.signature_help,
            vim.tbl_extend("force", opts, { desc = "LSP: Signature Help" }))

        -- Code actions and refactoring
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
            vim.tbl_extend("force", opts, { desc = "LSP: Code Action" }))
        keymap.set("n", "<leader>cr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP: Rename Symbol" }))

        -- Workspace management
        keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,
            vim.tbl_extend("force", opts, { desc = "LSP: Add Workspace Folder" }))
        keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
            vim.tbl_extend("force", opts, { desc = "LSP: Remove Workspace Folder" }))
        keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, vim.tbl_extend("force", opts, { desc = "LSP: List Workspace Folders" }))

        -- Format on save for specific clients
        if client and client.supports_method("textDocument/formatting") then
            keymap.set("n", "<leader>lf", function()
                vim.lsp.buf.format({ async = true })
            end, vim.tbl_extend("force", opts, { desc = "LSP: Format Document" }))
        end

        -- Inlay hints toggle (if supported)
        if client and client.supports_method("textDocument/inlayHint") then
            keymap.set("n", "<leader>lh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
            end, vim.tbl_extend("force", opts, { desc = "LSP: Toggle Inlay Hints" }))
        end

        -- Codelens (if supported)
        if client and client.supports_method("textDocument/codeLens") then
            keymap.set("n", "<leader>cl", vim.lsp.codelens.run,
                vim.tbl_extend("force", opts, { desc = "LSP: Run CodeLens" }))
            keymap.set("n", "<leader>cL", vim.lsp.codelens.refresh,
                vim.tbl_extend("force", opts, { desc = "LSP: Refresh CodeLens" }))
        end
    end,
})

-- Better command-line editing
keymap.set("c", "<C-a>", "<Home>", { desc = "Beginning of line" })
keymap.set("c", "<C-e>", "<End>", { desc = "End of line" })
keymap.set("c", "<C-d>", "<Del>", { desc = "Delete character" })
keymap.set("c", "<C-h>", "<BS>", { desc = "Backspace" })
keymap.set("c", "<C-t>", "<C-R>=expand('%:p:h')<CR>/", { desc = "Current file path" })

-- Utility keymaps
keymap.set("n", "<leader>x", "<cmd>source %<CR>", { desc = "Source current file", silent = true })
keymap.set("n", "<leader>X", "<cmd>luafile %<CR>", { desc = "Source current Lua file", silent = true })

-- Improved marks navigation
keymap.set("n", "'", "`", { desc = "Jump to mark (column)", silent = true })
keymap.set("n", "`", "'", { desc = "Jump to mark (line)", silent = true })

-- Select all
keymap.set("n", "<C-a>", "ggVG", { desc = "Select all", silent = true })

-- Escape alternatives for different modes
keymap.set({ "i", "n", "s" }, "<C-c>", "<Esc>", { desc = "Escape alternative", silent = true })
