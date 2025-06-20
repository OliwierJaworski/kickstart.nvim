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
        config = function()
            local on_attach = function(client, bufnr)

                local buf_map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end

                buf_map("n", "K", vim.lsp.buf.hover, "Hover info")
                buf_map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostics")
                buf_map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
                buf_map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
                buf_map("n", "<leader>d", vim.lsp.buf.definition, "Go to definition")
            end

            local lspconfig = require("lspconfig")
            local servers = { "cmake", "rust_analyzer", "clangd", "lua_ls", "zls", "pyright", "jsonls", "yamlls" }

            for _, server in ipairs(servers) do
                lspconfig[server].setup {
                    on_attach = on_attach,
                    flags = { debounce_text_changes = 150 },
                }
            end

            vim.diagnostic.config({ virtual_text = true, signs = true, update_in_insert = false })
        end,
    },
}
