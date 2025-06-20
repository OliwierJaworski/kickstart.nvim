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
                        init_selection = "<leader>s",
                        node_incremental = "<leader>si",
                        scope_incremental = "<leader>ss",
                        node_decremental= "<leader>sd",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,

                        -- automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- you can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            -- you can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ["ic"] = { query = "@class.inner", desc = "select inner part of a class region" },
                            -- you can also use captures from other query groups like `locals.scm`
                            ["as"] = { query = "@local.scope", query_group = "locals", desc = "select language scope" },
                        },
                        -- you can choose the select mode (default is charwise 'v')
                        --
                        -- can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'v', or '<c-v>') or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'v', -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                        -- if you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true or false
                        include_surrounding_whitespace = true,
                    },
                },
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects"
    }
}
