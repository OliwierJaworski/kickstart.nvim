return {
  "neovim/nvim-lspconfig",
  dependencies = {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "/usr/share/awesome/lib/", words = { "awesome" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  { "j-hui/fidget.nvim", opts = {} },
  { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
  "stevearc/conform.nvim",
  config = function()
    -- Setup Mason first
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls" },
    })
    
    -- Get lspconfig and capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    
    -- Server configurations
    local servers = {
      lua_ls = {
        Lua = {
          diagnostics = {
            globals = { "love", "vim" },          },
          workspace = {
            checkThirdParty = false,
            telemetry = { enable = false },
            library = {
              "${3rd}/love2d/library"
            }
          }
        }
      },
    }

    -- Setup each server
    require("mason-lspconfig").setup_handlers({
      function(server)
        local lspconfig = require("lspconfig")
        local server_opts = servers[server] or {}

        server_opts.capabilities = capabilities

        lspconfig[server].setup(server_opts)
      end,
    })

    -- Now setup the autocmd for keymaps when LSP attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
        local builtin = require "telescope.builtin"
        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Peek definition in floating window
        vim.keymap.set("n", "gp", function()
          local params = vim.lsp.util.make_position_params()
          return vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
            if err or not result or vim.tbl_isempty(result) then
              vim.notify("No definition found", vim.log.levels.INFO)
              return
            end
            
            local target = result[1] or result
            local target_uri = target.uri or target.targetUri
            local target_range = target.range or target.targetRange
            
            -- Load the target file
            local target_bufnr = vim.uri_to_bufnr(target_uri)
            vim.fn.bufload(target_bufnr)
            
            -- Get lines around the definition (e.g., 10 lines before and after)
            local start_line = math.max(0, target_range.start.line - 10)
            local end_line = target_range['end'].line + 10
            local lines = vim.api.nvim_buf_get_lines(target_bufnr, start_line, end_line, false)
            
            -- Create floating window
            local width = math.min(100, vim.o.columns - 10)
            local height = math.min(#lines, 30)
            
            local buf = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
            
            -- Set the filetype for syntax highlighting
            local ft = vim.bo[target_bufnr].filetype
            vim.api.nvim_buf_set_option(buf, 'filetype', ft)
            
            local opts = {
              relative = 'cursor',
              width = width,
              height = height,
              row = 1,
              col = 0,
              style = 'minimal',
              border = 'rounded',
            }
            
            local win = vim.api.nvim_open_win(buf, true, opts)
            
            -- Highlight the definition line
            local hl_line = target_range.start.line - start_line
            vim.api.nvim_buf_add_highlight(buf, -1, 'Visual', hl_line, 0, -1)
            
            -- Set cursor to definition line
            vim.api.nvim_win_set_cursor(win, {hl_line + 1, 0})
            
            -- Close with q or Esc
            vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf })
            vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf })
          end)
        end, { buffer = 0, desc = "Peek definition" })
        
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
        vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
        vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
        vim.keymap.set("n", "<space>wd", builtin.lsp_document_symbols, { buffer = 0 })
        vim.keymap.set("n", "<space>ww", function()
          builtin.diagnostics { root_dir = true }
        end, { buffer = 0 })
      end,
    })
  end
}
}
