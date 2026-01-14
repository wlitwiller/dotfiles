-- lua/core/plugin_config/lsp.lua

-- Mason (installs servers)
local mason_ok, mason = pcall(require, "mason")
if mason_ok then mason.setup() end

local mlsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mlsp_ok then
  mason_lspconfig.setup({
    ensure_installed = { "ts_ls", "eslint" },
  })
end

-- Capabilities for nvim-cmp (if you have it)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- Define configs using Neovim's built-in LSP config API (0.11+)
-- NOTE: server names here are Neovim's names; mason installs the binaries.
vim.lsp.config("ts_ls", {
  capabilities = capabilities,
})

vim.lsp.config("eslint", {
  capabilities = capabilities,
})

-- Enable them (attach when filetype matches)
vim.lsp.enable({ "ts_ls", "eslint" })

