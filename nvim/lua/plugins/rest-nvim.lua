return {
  "rest-nvim/rest.nvim",
  ft = "http",
  depenedencies = { "luarocks.nvim" },
  config = {
    skip_ssl_verification = true,
    highlight = {
      enable = true,
      timeout = 150,
    },
    result = {
      show_info = {
        url = true,
        http_info = true,
        headers = true,
      },
      split = {
        horizontal = false,
        in_place = true,
      },
    },
  },
}
