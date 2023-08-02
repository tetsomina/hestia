-- ------------------------------------
--
--  ███▄    █ ██▒   █▓ ██▓ ███▄ ▄███▓
--  ██ ▀█   █▓██░   █▒▓██▒▓██▒▀█▀ ██▒
-- ▓██  ▀█ ██▒▓██  █▒░▒██▒▓██    ▓██░
-- ▓██▒  ▐▌██▒ ▒██ █░░░██░▒██    ▒██
-- ▒██░   ▓██░  ▒▀█░  ░██░▒██▒   ░██▒
-- ░ ▒░   ▒ ▒   ░ ▐░  ░▓  ░ ▒░   ░  ░
-- ░ ░░   ░ ▒░  ░ ░░   ▒ ░░  ░      ░
--    ░   ░ ░     ░░   ▒ ░░      ░
--          ░      ░   ░         ░
--                ░
-- ------------------------------------

--  Bootstrap paq
-- ----------------
local function clone_paq()
  local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
  local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
  if not is_installed then
    vim.fn.system { "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path }
    return true
  end
end

local function bootstrap_paq(packages)
  local first_install = clone_paq()
  vim.cmd.packadd("paq-nvim")
  local paq = require("paq")
  if first_install then
    vim.notify("Installing plugins... If prompted, hit Enter to continue.")
  end

  -- Read and install packages
  paq(packages)
  paq.install()
end

-- Call helper function with our plugin list
bootstrap_paq {
  -- Paq can manage itself
  "savq/paq-nvim",

  -- Completion/LSP/Snippet plugins
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-nvim-lsp-document-symbol",
  "hrsh7th/cmp-nvim-lua",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "octaltree/cmp-look",
  "hrsh7th/nvim-cmp",
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  "neovim/nvim-lspconfig",
  "arkav/lualine-lsp-progress",
  "mfussenegger/nvim-lint",
  "mhartington/formatter.nvim",
  "lewis6991/hover.nvim",
  "williamboman/mason.nvim",
  { "williamboman/mason-lspconfig.nvim", run = ":MasonUpdate" },

  -- Programming plugins
  "akinsho/toggleterm.nvim",
  "lewis6991/gitsigns.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "kyazdani42/nvim-tree.lua",
  { "nvim-treesitter/nvim-treesitter",   run = ":TSUpdate" },
  "windwp/nvim-autopairs",
  "numToStr/Comment.nvim",
  "folke/trouble.nvim",
  "NMAC427/guess-indent.nvim",

  -- Writing/Planning
  "folke/zen-mode.nvim",
  "folke/twilight.nvim",
  "jghauser/auto-pandoc.nvim",
  "jakewvincent/mkdnflow.nvim",

  -- Misc/Useful Plugins
  "folke/which-key.nvim",
  "ethanholz/nvim-lastplace",
  { "AlessandroYorba/Alduin",                   branch = "nightly" },
  'nvim-lualine/lualine.nvim',
  "goolord/alpha-nvim",
  "phaazon/hop.nvim",
  "famiu/bufdelete.nvim",
  "NvChad/nvim-colorizer.lua",
  "nvim-telescope/telescope.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
  "nvim-lua/plenary.nvim",
  "stevearc/dressing.nvim",
}

-- ------------
--  Initialize
-- ------------
require("options")
require("plugins")
