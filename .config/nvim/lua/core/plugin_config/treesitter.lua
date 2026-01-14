require('nvim-treesitter.configs').setup({

  sync_installed = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
})

vim.treesitter.language.register("javascript", "javascriptreact")
vim.treesitter.language.register("typescript", "typescriptreact")

-- Auto-start Tree-sitter highlighting when a supported filetype opens
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "lua",
    "json",
    "bash",
    "vim",
  },
  callback = function(args)
    -- args.buf is the buffer number
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- Fallback: sometimes FileType fires before parser is available in certain setups
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function(args)
    -- Only try for common code buffers (avoid help, NvimTree, etc.)
    local ft = vim.bo[args.buf].filetype
    if ft == "" or ft == "NvimTree" or ft == "TelescopePrompt" or ft == "help" then
      return
    end
    pcall(vim.treesitter.start, args.buf)
  end,
})
