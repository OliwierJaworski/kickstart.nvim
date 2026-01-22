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

      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }
      -- Add current working directory (prompt for name)
      map("n", "<leader>wa", "<cmd>WorkspacesAdd<CR>", opts)

      -- Add a directory you choose
      map("n", "<leader>wA", "<cmd>WorkspacesAddDir<CR>", opts)

      -- Open workspace (Telescope picker)
      map("n", "<leader>wo", "<cmd>WorkspacesOpen<CR>", opts)

      -- remove workspace 
      map("n", "<leader>wr", "<cmd>WorkspacesRemove<CR>", opts)

      -- remove workspace directory 
      map("n", "<leader>wR", "<cmd>WorkspacesRemoveDir<CR>", opts)
    end,
}



