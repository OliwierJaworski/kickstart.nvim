return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        build = ":TSUpdate",
        lazy = false,
        config = function()
            require'nvim-treesitter.configs'.setup ({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "cpp", "cmake" },
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<Leader>s",
                        node_incremental = "<Leader>si",
                        scope_incremental = "<Leader>ss",
                        node_decremental= "<Leader>sd",
                    }
                },
            })
        end
    },
}
