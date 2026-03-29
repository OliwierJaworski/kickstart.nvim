return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- { dir = "~/plugins/tree-sitter-lua" },
      { "reasonml-editor/tree-sitter-reason" },
    },
    build = ":TSUpdate",
    branch = "main",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          'java', 'c', 'lua', 'vim', 'vimdoc',
          'query', 'javascript', 'typescript', 'html', 'yaml'
        },
        -- Use a C compiler directly — skips the need for tree-sitter CLI
        compilers = { "gcc", "clang" },
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'java', 'c', 'lua', 'vim', 'vimdoc', 'query', 'javascript', 'typescript', 'html', 'yaml' },
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
    })
  end,
  },
}
