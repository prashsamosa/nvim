
# 🧠 Zshrc Shortcuts & Custom Configs

This markdown explains custom `.zshrc` configuration, shortcuts, and clipboard integration with Neovim using `clip.exe` on Ubuntu.

---

## 🔄 Aliases and Their Purpose
+
| Alias     | Command                                                                 | Purpose                                             |
|-----------|-------------------------------------------------------------------------|-----------------------------------------------------|
| `vim`     | `nvim`                                                                  | Uses Neovim as the default Vim                      |
| `python`  | `python3`                                                               | Default Python command                              |
| `pip`     | `pip3`                                                                  | Default pip for Python3                             |
| `:q`      | `exit`                                                                  | Mimics Vim exit for terminal                        |
| `c`       | `clear`                                                                 | Clears the terminal                                 |
| `h`       | `history`                                                               | Shows command history                               |
| `reload`  | `source ~/.zshrc`                                                       | Reloads the shell configuration                     |
| `cat`     | `bat` (if available)                                                    | Pretty print file viewer                            |
| `ls`      | `eza` (with icons)                                                      | Enhanced `ls`                                       |
| `la`, `ll`, `l`, `lt`, `ltree` | Variants of `eza` commands for different listings | Directory listing in various formats with `eza`     |

---

## 🧠 Custom Functions

| Function  | Description                                                                                  |
|-----------|----------------------------------------------------------------------------------------------|
| `cx`      | Changes directory and lists contents                                                         |
| `fcd`     | Fuzzy directory finder and changer                                                           |
| `f`       | Fuzzy find a file and copy its path to clipboard                                             |
| `fv`      | Fuzzy find and open a file in the editor                                                     |
| `mkcd`    | Make a directory and `cd` into it                                                            |
| `extract` | Extracts most common archive types                                                           |

---

## 📋 Clipboard Integration with Neovim

### Purpose
Copy text yanked in Neovim (inside Ubuntu or WSL) directly to Windows clipboard using `clip.exe`.

### What It Does
Overrides the default `nvim` command to create an autocommand:
```lua
if vim.fn.executable("clip.exe") == 1 then
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      if vim.v.event.operator == "y" then
        vim.fn.system("clip.exe", vim.fn.getreg('"'))
      end
    end
  })
end
```

### How It's Injected
In `.zshrc` as a multi-line alias:
```sh
alias nvim='nvim -c "lua if vim.fn.executable("clip.exe") == 1 then   vim.api.nvim_create_autocmd("TextYankPost", {     callback = function()       if vim.v.event.operator == "y" then         vim.fn.system("clip.exe", vim.fn.getreg("\""))       end     end   }) end"'
```

---

## ⚙️ Pro Tips

- Clipboard copies only on `yank` (`y`) operations.
- You don’t need `"+y` or `"*y` every time.
- Works seamlessly when integrated in alias.

---

## 🧪 Recommended Tools (Optional)
- `eza`: Modern replacement for `ls`
- `bat`: Better `cat`
- `fd`: Simpler alternative to `find`
- `fzf`: Fuzzy Finder
- `zoxide`: Smarter `cd`
- `starship`: Minimal, blazing-fast shell prompt

