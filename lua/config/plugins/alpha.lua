return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local dashboard = require("alpha.themes.dashboard")
        vim.cmd("source ~/.cache/wal/colors-wal.vim")
        local color9 = vim.g.color9 or "#ffffff"
        local color3 = vim.g.color3 or "#ffffff"
        local color4 = vim.g.color4 or "#ffffff"
        local color5 = vim.g.color5 or "#ffffff"
        local color6 = vim.g.color6 or "#ffffff"

        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            "                                                     ",
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
            "                                                     ",
        }

        dashboard.section.buttons.val = {
            dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
            dashboard.button( "f", "󰱼  > Find file", ":lua require('telescope.builtin').find_files({ find_command = { 'rg', '--files' } })<CR>"),
            dashboard.button( "F", "󰥨  > Find folder", ":lua search_and_scope_into_directory()<CR>"),
            dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
            dashboard.button( "c", "  > Config" , ":cd ~/.config/nvim | Telescope find_files<CR>"),
            dashboard.button( "l", "󰒲 > Lazy", ":Lazy<CR>"),
            dashboard.button( "h", "  > Settings" , ":cd ~/.config/hypr | Telescope find_files<CR>"),
            dashboard.button( "q", "  > Quit", ":qa<CR>"),


        }
        dashboard.section.footer.val = {
            "",
            "Welcome!",
        }
        -- Send config to alpha
        alpha.setup(dashboard.opts)

        -- Disable folding on alpha buffer
        vim.cmd([[
        autocmd FileType alpha setlocal nofoldenable
        ]])

    end,
}
