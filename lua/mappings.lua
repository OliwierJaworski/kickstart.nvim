--mappings for movement from window to window
vim.keymap.set("n", "<C-j>", function() vim.cmd("wincmd j") end, { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", function() vim.cmd("wincmd k") end, { desc = "Move to window above" })
vim.keymap.set("n", "<C-h>", function() vim.cmd("wincmd h") end, { desc = "Move to window left" })
vim.keymap.set("n", "<C-l>", function() vim.cmd("wincmd l") end, { desc = "Move to window right" })

--create horizontal window
vim.keymap.set("n", "<leader>v", function()
    local cwd = vim.fn.expand("%:p:h") -- current file's directory
    vim.cmd("vsplit")                  -- vertical split new window
    vim.cmd("lcd " .. cwd)             -- set local cwd to current file dir
    --vim.cmd("edit .")                  -- open directory buffer (like ls)
    vim.cmd("Explore")
end, { desc = "Vertical split with current file's dir" })

--create vertical window
vim.keymap.set("n", "<leader>h", function()
    local cwd = vim.fn.expand("%:p:h")
    vim.cmd("split")
    vim.cmd("lcd " .. cwd)
    vim.cmd("Explore")
    --vim.cmd("edit .")
end, { desc = "Horizontal split with current file's dir" })

-- window closing mechanic
vim.keymap.set("n", "<C-c>", function()
    if vim.bo.modified  then
        local choice = vim.fn.confirm("save changes before closing?", "&Yes\n&No", 1)
        if choice == 1 then 
            vim.cmd("write")
        end
    end
    vim.cmd("q!")
end, { desc = "closing windows" })

-- adding opening of new filetree
vim.keymap.set("n","<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
