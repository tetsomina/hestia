--   General LSP settings
-- ------------------------
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

--   Mason: install language servers
-- -----------------------------------
-- These steps must come BEFORE lspconfigs setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "ruff_lsp", "jedi_language_server" },
})

--   nvim-lspconfig settings
-- ----------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.jedi_language_server.setup {
  capabilities = capabilities,
}

require 'lspconfig'.ruff_lsp.setup {
  capabilities = capabilities,
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = {},
    }
  }
}

require("lspconfig").lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      format = {
        enable = true,
      },
    },
  },
})

--  nvim-lint settings
-- --------------------
require('lint').linters_by_ft = {
  markdown = { 'proselint' },
  mail = { 'proselint' },
  c = { 'cppcheck' },
  python = { 'mypy' },
  sh = { 'shellcheck' },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

--  formatter.nvim settings
-- -------------------------
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    python = {
      require("formatter.filetypes.python").black,
    },
    sh = {
      require("formatter.filetypes.sh").shfmt,
    },
    c = {
      require("formatter.filetypes.c").uncrustify,
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}

--  hover.nvim settings
-- ---------------------
require("hover").setup {
  init = function()
    -- Require providers
    require("hover.providers.lsp")
    -- require('hover.providers.gh')
    -- require('hover.providers.gh_user')
    -- require('hover.providers.jira')
    require('hover.providers.man')
    require('hover.providers.dictionary')
  end,
  preview_opts = {
    border = nil
  },
  -- Whether the contents of a currently open hover window should be moved
  -- to a :h preview-window when pressing the hover keymap.
  preview_window = false,
  title = true
}
