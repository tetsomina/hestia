--  Nvim-Tree
-- -----------
vim.api.nvim_set_keymap("n", "<C-d>", "<cmd>NvimTreeToggle<cr>", { silent = true })
require("nvim-tree").setup({
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = false,
      }
    },
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        item = "│ ",
        none = "  ",
      },
    },
  },
})
