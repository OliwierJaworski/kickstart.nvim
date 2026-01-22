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
      local treesitter = require("nvim-treesitter")
      treesitter.setup()
      treesitter.install { 'java', 'c', 'lua', 'vim', 'vimdoc',
                           'query','javascript',
                           'typescript', 'html', 'yaml' }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'java', 'c', 'lua', 'vim', 'vimdoc', 'query', 'javascript', 'typescript', 'html', 'yaml' },
        callback = function()
          -- syntax highlight
          vim.treesitter.start()

          -- indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
