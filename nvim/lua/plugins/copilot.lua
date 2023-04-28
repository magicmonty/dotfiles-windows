return {
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = false },
            panel = {
                enabled = true,
                auto_refresh = false,
                keymap = {
                    jump_prev = "gp",
                    jump_next = "gn",
                    accept = "<CR>",
                    refresh = "gr",
                    open = "<M-CR>"
                },
                layout = {
                    position = "bottom", -- | top | left | right
                    ratio = 0.4
                },
            },
        }
    },
    {
        "zbirenbaum/copilot-cmp",
        event = "InsertEnter",
        dependencies = {
            "zbirenbaum/copilot.lua"
        },
        config = function()
            require("copilot_cmp").setup()
        end
    }
}
