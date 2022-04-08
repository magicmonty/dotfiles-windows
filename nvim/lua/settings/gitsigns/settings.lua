local icons = require("magicmonty.theme").icons.git

local config = {
	signs = {
		add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "|", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "-", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	},
	signcolumn = true,
	numhl = true,
	linehl = false,
	word_diff = false,

	on_attach = function(bufnr)
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- navigation
		map("n", "<leader>gdn", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>'", { expr = true })
		map("n", "<leader>gdp", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<cr>'", { expr = true })

		-- actions
		map({ "n", "v" }, "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>")
		map({ "n", "v" }, "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>")
		map("n", "<leader>hb", "<cmd>Gitsigns blame_line<cr>")
		map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>")
		map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>")
		map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<cr>")
		map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<cr>")
		map("n", "<leader>hU", "<cmd>Gitsigns reset_buffer_index<cr>")

		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<cr>")
	end,
}

local M = {}

M.setup = function()
	require("gitsigns").setup(config)
end

return M
