return {
    {
        "mason-org/mason-lspconfig.nvim"
    },
    {
        "mason-org/mason.nvim",
        opts = {
            check_outdated_packages_on_open = true,

            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            },
            pip = {
                upgrade_pip = false,
            },
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "cmake", "rust_analyzer","clangd", "lua_ls", "zls","zls","pyright" ,"jsonls","yamlls" },
                dependencies = {
                    { "mason-org/mason.nvim", opts = {} },
                    "neovim/nvim-lspconfig",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
    },
}
