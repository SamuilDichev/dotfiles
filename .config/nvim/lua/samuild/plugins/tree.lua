return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        git = {
            enable = true,
        },
        renderer = {
            group_empty = false,
            highlight_git = true,
            icons = {
                show = {
                    git = true,
                },
            },
        },
        view = {
            adaptive_size = true,
            width = 40,
        },
    }
}
