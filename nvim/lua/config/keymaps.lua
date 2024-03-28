-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local map = vim.keymap.set
local unmap = vim.keymap.del

unmap("n", "<leader>e")
map("n", "<leader>.", function()
  require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
end, { desc = "Explorer NeoTree (root dir)", remap = true })

unmap("n", "<leader>|")
map("n", "<leader>#", "<C-W>v", { desc = "Split window right", remap = true })

unmap("n", "<leader>w|")
map("n", "<leader>w#", "<C-W>v", { desc = "Split window right", remap = true })

unmap("n", "<leader>`")
map("n", "<leader>,", "<cmd>e #<cr>", { desc = "Switch to Other Buffer", remap = true })

unmap("n", "<leader><tab>[")
map("n", "<leader><tab>ö", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
unmap("n", "<leader><tab>]")
map("n", "<leader><tab>ä", "<cmd>tabnext<cr>", { desc = "Next tab" })

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

unmap("n", "]d")
map("n", "äd", diagnostic_goto(true), { desc = "Next diagnostic", remap = true, silent = true })
unmap("n", "[d")
map("n", "öd", diagnostic_goto(false), { desc = "Previous diagnostic", remap = true, silent = true })
unmap("n", "]e")
map("n", "äe", diagnostic_goto(true, "ERROR"), { desc = "Previous error", remap = true, silent = true })
unmap("n", "[e")
map("n", "öe", diagnostic_goto(false, "ERROR"), { desc = "Previous error", remap = true, silent = true })
unmap("n", "]w")
map("n", "äw", diagnostic_goto(true, "WARN"), { desc = "Previous warning", remap = true, silent = true })
unmap("n", "[w")
map("n", "öw", diagnostic_goto(false, "WARN"), { desc = "Previous warning", remap = true, silent = true })
unmap("n", "]b")
map("n", "äb", "<cmd>bnext<cr>", { desc = "Next buffer", remap = true, silent = true })
unmap("n", "[b")
map("n", "öb", "<cmd>bprevious<cr>", { desc = "Previous buffer", silent = true, remap = true })

unmap("n", "]q")
map("n", "äq", vim.cmd.cnext, { desc = "Next quickfix", remap = true, silent = true })
unmap("n", "[q")
map("n", "öq", vim.cmd.cprev, { desc = "Previous quickfix", silent = true, remap = true })

-- Unmap Lazy keybinds
unmap("n", "<leader>l")
unmap("n", "<leader>L")
