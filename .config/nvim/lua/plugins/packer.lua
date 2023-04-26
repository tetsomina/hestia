-- -------------------
--  Plugin Management
-- -------------------
-- Install packer.nvim if we don't already have it
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- Completion/LSP/Snippet plugins
    use({
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
    })
    use("L3MON4D3/LuaSnip")
    use("rafamadriz/friendly-snippets")
    use("neovim/nvim-lspconfig")
    use("j-hui/fidget.nvim")
    use("jose-elias-alvarez/null-ls.nvim")
    use({
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        run = ":MasonUpdate"
    })

    -- Programming plugins
    use("akinsho/toggleterm.nvim")
    use("lewis6991/gitsigns.nvim")
    use("lukas-reineke/indent-blankline.nvim")
    use("kyazdani42/nvim-tree.lua")
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    use("windwp/nvim-autopairs")
    use("numToStr/Comment.nvim")
    use("folke/trouble.nvim")

    -- Writing/Planning
    use("folke/zen-mode.nvim")
    use("folke/twilight.nvim")
    use("jghauser/auto-pandoc.nvim")
    use("jakewvincent/mkdnflow.nvim")

    -- Misc/Useful Plugins
    use("kyazdani42/nvim-web-devicons")
    use("folke/which-key.nvim")
    use("ethanholz/nvim-lastplace")
    use({ "AlessandroYorba/Alduin", branch = "nightly" })
    use("rebelot/heirline.nvim")
    use("goolord/alpha-nvim")
    use("phaazon/hop.nvim")
    use("famiu/bufdelete.nvim")
    use("norcalli/nvim-colorizer.lua")
    use("lewis6991/impatient.nvim")
    use("nvim-telescope/telescope.nvim")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use("nvim-lua/plenary.nvim")
    use("stevearc/dressing.nvim")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
