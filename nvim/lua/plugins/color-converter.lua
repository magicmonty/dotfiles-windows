return {
  "NTBBloodbath/color-converter.nvim",
  config = function()
    vim.keymap.set("n", "<leader>cc", "<Plug>ColorConvertCycle", { desc = "Color Convert" })
  end,
}
