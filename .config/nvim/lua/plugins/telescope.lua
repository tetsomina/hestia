--   Telescope
-- -----------
require("telescope").setup({
    defaults = require("telescope.themes").get_ivy({}),
    pickers = {
        find_files = {
            find_command = {
                "fd",
                "--hidden",
                "--strip-cwd-prefix",
                "-i",
                "-tf",
                "-E",
                "\\.cache",
                "-E",
                "\\.ssh",
                "-E",
                "\\.pki",
                "-E",
                "\\.steam",
                "-E",
                "\\.dbus",
            },
        },
    },
})
require("telescope").load_extension("fzf")
-- require("telescope").load_extension("ui-select")
