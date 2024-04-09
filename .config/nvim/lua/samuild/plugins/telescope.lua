return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    branch = "0.1.x",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
        require("telescope").setup()
        require("telescope").load_extension("notify")
        require("telescope").load_extension("neoclip")
        require("telescope").load_extension("macroscope")
    end,
}
