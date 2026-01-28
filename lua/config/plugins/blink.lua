-- lsp completion plugin
return {
  "saghen/blink.cmp",
  lazy = false,
  build = "cargo build --release",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    {
      "saghen/blink.compat",
      optional = true,
      lazy = false,
    },
  },
  event = "InsertEnter",
  opts = {
    snippets = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = { 
        auto_show = true, 
        auto_show_delay_ms = 200 
      },
      ghost_text = { enabled = false },
    },
    sources = {
      compat = {},
      default = { "lsp", "path", "snippets", "buffer" },
    },
    signature = {
      enabled = true,  -- Show function signatures
    },
    keymap = {
      preset = "enter",
      ["<C-y>"] = { "select_and_accept" },
    },
  },
  config = function(_, opts)
    -- Setup compat sources if any
    local enabled = opts.sources.default
    for _, source in ipairs(opts.sources.compat or {}) do
      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers[source] = {
        name = source,
        module = "blink.compat.source",
      }
      if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
        table.insert(enabled, source)
      end
    end
    opts.sources.compat = nil
    
    -- Single setup call with merged opts
    require("blink.cmp").setup(opts)
  end,
}
