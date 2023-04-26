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
    ensure_installed = {"ruff_lsp", "jedi_language_server"},
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

--   null-ls.nvim settings
-- -------------------------
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    -- Code Actions
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.code_actions.proselint.with({
      filetypes = { "markdown", "tex", "mail" },
    }),
    -- Diagnostics
    null_ls.builtins.diagnostics.cppcheck,
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.proselint.with({
      filetypes = { "markdown", "tex", "mail" },
    }),
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.todo_comments,
    null_ls.builtins.diagnostics.trail_space.with({
      disabled_filetypes = { "mail" },
    }),
    null_ls.builtins.diagnostics.zsh,
    -- Formatting
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.uncrustify,
    -- Hover
    null_ls.builtins.hover.dictionary,
    null_ls.builtins.hover.printenv,
  },
})

--   fidget settings
-- ------------------
require "fidget".setup(
    {
        text = {
            spinner = "grow_vertical", -- animation shown when tasks are ongoing
            done = "✔", -- character shown when all tasks are complete
            commenced = "Started", -- message shown when task starts
            completed = "Completed", -- message shown when task completes
        },
    })
