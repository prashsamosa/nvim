local keymap = vim.keymap

-- General
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode", silent = true })
keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights", silent = true })

-- Increment/Decrement
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number", silent = true })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number", silent = true })

-- Clipboard
keymap.set("v", "p", '"_dP', { desc = "Paste without replacing clipboard (clipboard content)", silent = true })

-- Clear search, diff update, and redraw
keymap.set("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / Clear hlsearch / Diff update", silent = true })

-- Additional diagnostic keymaps (supplement 0.11 defaults: [d, ]d, [D, ]D)
keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic loclist", silent = true })
keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostic quickfix", silent = true })
keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show diagnostic in float", silent = true })
keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic in float", silent = true })

-- File saving
keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file", silent = true })

-- Default keymaps for quickfix/location list
keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix item", silent = true })
keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix item", silent = true })
keymap.set("n", "]l", "<cmd>lnext<CR>", { desc = "Next location list item", silent = true })
keymap.set("n", "[l", "<cmd>lprev<CR>", { desc = "Previous location list item", silent = true })

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window", silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window", silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window", silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window", silent = true })

-- Window resizing
keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height", silent = true })
keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height", silent = true })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width", silent = true })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width", silent = true })

-- Window splitting
keymap.set("n", "sh", "<cmd>split<CR>", { desc = "Horizontal split", silent = true })
keymap.set("n", "sv", "<cmd>vsplit<CR>", { desc = "Vertical split", silent = true })

-- Files - Use Snacks picker if available, fallback to fzf-lua
keymap.set("n", "<leader><space>", function()
    if _G.Snacks and _G.Snacks.picker then
        _G.Snacks.picker.files()
    else
        require("fzf-lua").files()
    end
end, { desc = "Find Files (Snacks/FZF)", silent = true })

-- Terminal mode
keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })

-- Better terminal navigation
keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: Move to left window", silent = true })
keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: Move to lower window", silent = true })
keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: Move to upper window", silent = true })
keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: Move to right window", silent = true })

-- Visual mode keymaps for moving lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- Alt+j/k for visual mode (maintains selection)
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down (maintains selection)", silent = true })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up (maintains selection)", silent = true })

-- Better indenting
keymap.set("v", "<", "<gv", { desc = "Indent left and reselect", silent = true })
keymap.set("v", ">", ">gv", { desc = "Indent right and reselect", silent = true })

-- Buffer-related keymaps - Fixed to use correct API
keymap.set("n", "<leader>bl", function()
    vim.cmd.bprevious()
end, { desc = "Switch to last buffer", silent = true })

-- LSP Keymaps (Applied when LSP attaches to buffer)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

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
        keymap.set("n", "<C-k>", vim.lsp.buf.signature_help,
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
    end,
})
