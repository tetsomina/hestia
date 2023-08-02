--  Nvim-Tree
-- -----------
vim.api.nvim_set_keymap("n", "<C-d>", "<cmd>NvimTreeToggle<cr>", { silent = true })
require("nvim-tree").setup({
    renderer = {
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
