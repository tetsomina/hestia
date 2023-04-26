--   Dashboard (Alpha)
-- --------------------
require("alpha").setup(require("alpha.themes.dashboard").config)
local db = require("alpha.themes.dashboard")
db.section.header.val = {
	" ███▄    █ ██▒   █▓ ██▓ ███▄ ▄███▓",
	" ██ ▀█   █▓██░   █▒▓██▒▓██▒▀█▀ ██▒",
	"▓██  ▀█ ██▒▓██  █▒░▒██▒▓██    ▓██░",
	"▓██▒  ▐▌██▒ ▒██ █░░░██░▒██    ▒██ ",
	"▒██░   ▓██░  ▒▀█░  ░██░▒██▒   ░██▒",
	"░ ▒░   ▒ ▒   ░ ▐░  ░▓  ░ ▒░   ░  ░",
	"░ ░░   ░ ▒░  ░ ░░   ▒ ░░  ░      ░",
	"   ░   ░ ░     ░░   ▒ ░░      ░   ",
	"         ░      ░   ░         ░   ",
	"               ░                  ",
	"                                  ",
}
db.section.buttons.val = {
	db.button("e", "  New file", "<cmd>ene<cr>"),
	db.button("f", "  Search for file", "<cmd>Telescope find_files<cr>"),
	db.button("r", "  Open recent file", "<cmd>Telescope oldfiles<cr>"),
	db.button("n", "  Open file explorer", "<cmd>NvimTreeToggle ~/<cr>"),
	db.button("u", "  Update plugins", "<cmd>PackerSync<cr>"),
	db.button("q", "  Quit NVIM", "<cmd>qa<CR>"),
}

local function footer()
    local total_plugins = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))
    local version = vim.version()
    local v_info = " | v" .. version.major .. "." .. version.minor .. "." .. version.patch

    return total_plugins .. " plugins" .. v_info
end

db.section.footer.val = footer()
db.section.footer.opts.hl = "Constant"

-- Auto start Alpha on new tabs
-- local alpha_start_group = vim.api.nvim_create_augroup("AlphaStart", { clear = true })
-- vim.api.nvim_create_autocmd("TabNewEntered", {
--     callback = function()
--         require("alpha").start()
--     end,
--     group = alpha_start_group,
-- })
