local ok, lualine = pcall(require, "lualine")
if not ok then return end

local theme_ok, theme = pcall(require, "lualine.themes.catppuccin")
if not theme_ok then
  theme = "auto"
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = theme, -- ✅ theme table (or "auto" fallback)
  },
  sections = {
    lualine_a = {
      { "filename", path = 1 },
    },
  },
})
