local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use {
      "eoh-bse/minintro.nvim",
      config = function() require("minintro").setup({ color = "#98c379" }) end
  } use 'nvim-lualine/lualine.nvim'
  use({ "christoomey/vim-tmux-navigator"})
  use({
    "catppuccin/nvim",
    as = "catppuccin",
  })
  use({
    'nvim-treesitter/nvim-treesitter',
    branch = "master",
    run = ":TSUpdate",
  })

  use {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.0',
    requires = {{'nvim-lua/plenary.nvim'}}
  }
  use({ "windwp/nvim-autopairs" })
  use({
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
  })
  use({ "neovim/nvim-lspconfig"})
  use({ "williamboman/mason.nvim"})
  use({ "williamboman/mason-lspconfig.nvim"})
  
  use({ "hrsh7th/nvim-cmp"})
  use({ "hrsh7th/cmp-nvim-lsp"})
  use({ "L3MON4D3/LuaSnip"})
  use({ "saadparwaiz1/cmp_luasnip"})

  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
