--   Which-Key
-- ------------
require("which-key").setup()
require("which-key").register({
  ["<leader>"] = {
    l = {
      name = "+LSP",
      e = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Open floating diagnositc window" },
      p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Go to previous error" },
      n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Go to next error" },
      L = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Set local list" },
      D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declarations" },
      d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
      h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Open hover window" },
      i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
      s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help" },
      w = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add workspace folder" },
      W = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove workspace folder" },
      l = {
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
        "List Folders"
      },
      t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type definition" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action" },
      R = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
      f = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format" },
    },
    h = {
      name = "+Hop",
      c = { "<cmd>HopChar1<cr>", "Hop with one char" },
      C = { "<cmd>HopChar2<cr>", "Hop with two chars" },
      w = { "<cmd>HopWord<cr>", "Hop with words" },
      W = { "<cmd>HopPattern<cr>", "Hop with pattern" },
    },
    f = {
      name = "+Telescope",
      f = { "<cmd>Telescope find_files<cr>", "Open file" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open recent file" },
      g = { "<cmd>Telescope live_grep<cr>", "Search for word" },
      h = { "<cmd>Telescope help_tags<cr>", "Search help document" },
    },
    b = {
      name = "+Buffers",
      k = { '<cmd>bnext<cr>', "Next buffer" },
      j = { '<cmd>bprevious<cr>', "Previous buffer" },
      h = { "<cmd>bfirst<cr>", "First buffer" },
      l = { "<cmd>blast<cr>", "Last buffer" },
      d = { '<cmd>Bdelete<cr>', "Close buffer" },
      b = { "<cmd>Telescope buffers<cr>", "Pick a buffer" },
    },
    t = {
      name = "+Tabs",
      n = { "<cmd>tabnew<cr>", "New tab" },
      h = { "<cmd>tabfirst<cr>", "Go to first tab" },
      k = { "<cmd>tabnext<cr>", "Go to next tab" },
      j = { "<cmd>tabprev<cr>", "Go to previous tab" },
      l = { "<cmd>tablast<cr>", "Go to last tab" },
      t = { "<cmd>tabedit<cr>", "Edit tab" },
      d = { "<cmd>tabclose<cr>", "Close tab" },
    },
    p = {
      name = "+Auto-Pandoc",
      p = { "<cmd>lua require('auto-pandoc').run_pandoc()<cr>", "Format" },
    },
    m = {
      name = "+Mason",
      m = { "<cmd>Mason<cr>", "Open main Mason window" },
      u = { "<cmd>MasonUpdate<cr>", "Update Mason registries" },
      l = { "<cmd>Masonlog<cr>", "Open Mason log" },
      i = { "<cmd>MasonInstall<cr>", "Install package with Mason" },
      n = { "<cmd>MasonUninstall<cr>", "Uninstall package with Mason" },
      a = { "<cmd>MasonUninstallAll<cr>", "Uninstall all package with Mason" },

    },
    r = {
      name = "+Trouble",
      t = { "<cmd>TroubleToggle<cr>", "Toggle trouble" },
      r = { "<cmd>TroubleRefresh<cr>", "Refresh trouble" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Toggle document diagnostics" },
      w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Toggle workspace diagnostics" },
      l = { "<cmd>TroubleToggle loclist<cr>", "Toggle loclist" },
      q = { "<cmd>TroubleToggle quickfix<cr>", "Toggle quickfix" },
      f = { "<cmd>TroubleToggle lsp_references<cr>", "Toggle lsp references" },
    },
    g = { "<cmd>lua tig_toggle()<cr>", "Toggle Tig" },
    z = { "<cmd>ZenMode<cr>", "Toggle Zen Mode" },
  },
})
