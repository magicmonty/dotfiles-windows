return {
  "norcalli/nvim-colorizer.lua",
  ft = { "html", "css", "scss", "javascript", "typescript", "vue", "svelte", "lua", "vim", "yaml", "json", "markdown" },
  lazy = true,
  main = "colorizer",
  config = function()
    require("colorizer").setup()
  end,
}
