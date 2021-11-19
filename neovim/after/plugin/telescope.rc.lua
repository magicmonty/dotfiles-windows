-- vim: foldlevel=99:
local status, telescope = pcall(require, "telescope")
if not status then return end

local map=require("vim_ext").map

telescope.setup {
  defaults = {
    prompt_prefix = "❯ ",
    selection_caret = "❯ ",
    sorting_strategy = "ascending",
    dynamic_preview_title = true,
    layout_config = {
      prompt_position = "bottom",
      horizontal = {
        width_padding = 0.04,
        height_padding = 0.1,
        preview_width = 0.6
      },
      vertical = {
        width_padding = 0.04,
        height_padding = 1,
        preview_height = 0.5
      }
    },
    winblend = 10,
    mappings = {
      -- i = {
      --   ["<Esc>"] = actions.close,
      -- }
    },
    preview = {
      timeout = 500,
      msg_bg_fillchar = ""
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden"
    },
  }
}

telescope.load_extension "file_browser"

local opts = { silent = true, noremap = true }
-- Find references
map("n", "<leader>fr", ":lua require('telescope.builtin').lsp_references()<cr>", opts)
map("n", "<leader>gd", ":lua require('telescope.builtin').lsp_definitions()<cr>", opts)

-- Find files in current project directory
map("n", "<leader>ff", ":lua require('magicmonty.telescope').project_files()<cr>", opts)
-- Find text in current buffer
map("n", "<leader>fb", ":lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", opts)
-- Help
map("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<cr>", opts)
-- Browse notification history
map("n", "<leader>fn", ":lua require('telescope').extensions.notify.notify()<cr>", opts)
-- Browse keymaps
map("n", "<leader>fk", ":lua require('telescope.builtin').keymaps({results_title='Key Maps Results'})<cr>", opts)
-- Browse marks
map("n", "<leader>fm", ":lua require('telescope.builtin').marks({results_title='Marks Results'})<cr>", opts)
-- Find word under cursor
map("n", "<leader>fw", ":lua require('telescope.builtin').grep_string()<cr>", opts)
-- Find word under cursor (exact word, case sensitive)
map("n", "<leader>fW", ":lua require('telescope.builtin').grep_string({word_match='-w'})<cr>", opts)
-- Find buffer
map("n", "<leader>bb", ":lua require('telescope.builtin').buffers({prompt_title = 'Find Buffer', results_title = 'Buffers', layout_strategy = 'vertical', layout_config = { width = 0.40, height = 0.55 }})<cr>", opts)
-- Live grep
map("n", "<leader>lg", ":Telescope live_grep<cr>", opts)
-- Find file in neovim config directory
map("n", "<leader>en", ":lua require('magicmonty.telescope').search_config()<cr>", opts)
-- Open file browser
map("n", "<leader>.", ":lua require('telescope').extensions.file_browser.file_browser()<cr>", opts)

