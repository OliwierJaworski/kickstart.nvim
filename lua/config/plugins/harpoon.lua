
return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("harpoon"):setup()
        end,
        keys = {
            { "<C-A>", function() require("harpoon"):list():add() end, desc = "harpoon file", },
            { "<leader>a", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
            { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
            { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
            { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
            { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
            { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
        },
    },
    {
        "kiennt63/harpoon-files.nvim",
        dependencies = { { "ThePrimeagen/harpoon", branch = "harpoon2" } },
        opts = {
            max_length = 15,
            icon = '',
            show_icon = true,
            show_index = true,
            show_filename = true,
            separator_left = ' ',
            separator_right = ' '
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "kiennt63/harpoon-files.nvim"
        },
        config = function()
            local harpoon_files = require("harpoon_files")
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = '',
                    section_separators = { left = '', right = '' },
                    component_separators = {'', ''},
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    always_show_tabline = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 100,
                        tabline = 100,
                        winbar = 100,
                    }
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch'},
                    lualine_c = {harpoon_files.lualine_component},
                    lualine_x = {'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'},
                },

                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { require'tabline'.tabline_buffers },
                    lualine_x = { require'tabline'.tabline_tabs },
                    lualine_y = {},
                    lualine_z = {},
                },
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            })
        end,
    },
}

