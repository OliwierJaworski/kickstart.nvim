return{ 
    "natecraddock/workspaces.nvim",
    lazy = false,
    config = function()
        require("workspaces").setup({
            hooks = {
                open = { "Telescope find_files" },
            }
        })
        require("telescope").load_extension("workspaces")
    end,
}


