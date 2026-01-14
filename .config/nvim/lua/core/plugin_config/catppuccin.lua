vim.opt.termguicolors = true
vim.cmd.syntax("on")

local ok, catppuccin = pcall(require, "catppuccin")
if not ok then return end

require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = false,
  integrations = {
    treesitter = true,
    telescope = true,
    native_lsp = {
      enabled = true,
    },
    nvimtree = true,
    lualine = true,
  },
})

vim.cmd.colorscheme("catppuccin")

vim.api.nvim_set_hl(0, "@tag", { fg = "#89b4fa"})
vim.api.nvim_set_hl(0, "@tag.attribute", { fg = "#f9e2af"})

