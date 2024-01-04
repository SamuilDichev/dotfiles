return {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = function()
        local custom_keymap = require("samuild.keymap")
        require("marks").setup({
            default_mappings = false,
            mappings = custom_keymap.marks_mappings,
        })
    end
}
