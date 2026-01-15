local ok, lualine = pcall(require, "lualine")
if not ok then return end

local auto = require("lualine.themes.auto")

local colors = {
  rosewater = "#f2d5cf",
  flamingo = "#eebebe",
  pink = "#f4b8e4",
  mauve = "#ca9ee6",
  red = "#e78284",
  maroon = "#ea999c",
  peach = "#ef9f76",
  yellow = "#e5c890",
  green = "#a6d189",
  teal = "#81c8be",
  sky = "#99d1db",
  sapphire = "#85c1dc",
  blue = "#8caaee",
  lavender = "#babbf1",
  text = "#c6d0f5",
  subtext1 = "#b5bfe2",
  subtext0 = "#a5adce",
  overlay2 = "#949cbb",
  overlay1 = "#838ba7",
  overlay0 = "#737994",
  surface2 = "#626880",
  surface1 = "#51576d",
  surface0 = "#414559",
  base = "#303446",
  mantle = "#292c3c",
  crust = "#232634",
}

local function separator()
  return {
    function() return "│" end,
    color = { fg = colors.surface0, bg = "NONE", gui = "bold" },
    padding = { left = 1, right = 1 },
  }
end

local function custom_branch()
  local gitsigns = vim.b.gitsigns_head
  local fugitive = (vim.fn.exists("*FugitiveHead") == 1) and vim.fn.FugitiveHead() or ""
  local branch = gitsigns or fugitive
  if not branch or branch == "" then
    return ""
  end
  return " " .. branch
end

-- Make section C transparent in the auto theme
for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "inactive", "terminal" }) do
  if auto[mode] and auto[mode].c then
    auto[mode].c.bg = "NONE"
  end
end

lualine.setup({
  options = {
    theme = auto,
    component_separators = "",
    section_separators = "",
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(str) return str:sub(1, 1) end,
        color = function()
          local mode = vim.fn.mode()
          if mode == "\22" then
            return { fg = "none", bg = colors.red, gui = "bold" }
          elseif mode == "V" then
            return { fg = colors.red, bg = "none", gui = "underline,bold" }
          else
            return { fg = colors.red, bg = "none", gui = "bold" }
          end
        end,
        padding = { left = 0, right = 0 },
      },
    },
    lualine_b = {
      separator(),
      { custom_branch, color = { fg = colors.green, bg = "none", gui = "bold" }, padding = { left = 0, right = 0 } },
      {
        "diff",
        colored = true,
        diff_color = {
          added = { fg = colors.teal, bg = "none", gui = "bold" },
          modified = { fg = colors.yellow, bg = "none", gui = "bold" },
          removed = { fg = colors.red, bg = "none", gui = "bold" },
        },
        symbols = { added = "+", modified = "~", removed = "-" },
        padding = { left = 1, right = 0 },
      },
    },
    lualine_c = {
      separator(),
      { "filetype", icon_only = true, colored = false, color = { fg = colors.blue, bg = "none", gui = "bold" }, padding = { left = 0, right = 1 } },
      {
        "filename",
        file_status = true,
        path = 0,
        shorting_target = 20, -- if shortening doesn't work, we can adjust for your lualine version
        symbols = { modified = "[+]", readonly = "[-]", unnamed = "[?]", newfile = "[!]" },
        color = { fg = colors.blue, bg = "none", gui = "bold" },
        padding = { left = 0, right = 0 },
      },
      separator(),
      {
        function()
          local bufs = vim.fn.getbufinfo({ buflisted = 1 })
          local total = #bufs
          local cur = vim.api.nvim_get_current_buf()
          local idx = 0
          for i, b in ipairs(bufs) do
            if b.bufnr == cur then idx = i break end
          end
          return string.format(" %d/%d", idx, total)
        end,
        color = { fg = colors.yellow, bg = "none", gui = "bold" },
        padding = { left = 0, right = 0 },
      },
    },
    lualine_x = {
      { "fileformat", color = { fg = colors.yellow, bg = "none", gui = "bold" }, symbols = { unix = "", dos = "", mac = "" }, padding = { left = 0, right = 0 } },
      { "encoding", color = { fg = colors.yellow, bg = "none", gui = "bold" }, padding = { left = 1, right = 0 } },
      separator(),
      {
        function()
          local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
          if size < 0 then return "-" end
          if size < 1024 then return size .. "B" end
          if size < 1024 * 1024 then return string.format("%.1fK", size / 1024) end
          if size < 1024 * 1024 * 1024 then return string.format("%.1fM", size / (1024 * 1024)) end
          return string.format("%.1fG", size / (1024 * 1024 * 1024))
        end,
        color = { fg = colors.blue, bg = "none", gui = "bold" },
        padding = { left = 0, right = 0 },
      },
    },
    lualine_y = {
      separator(),
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn", "info", "hint" },
        symbols = { error = "󰅚 ", warn = "󰀪 ", info = "󰋽 ", hint = "󰌶 " },
        colored = true,
        update_in_insert = false,
        always_visible = true,
        padding = { left = 0, right = 0 },
      },
    },
    lualine_z = {
      separator(),
      { "progress", color = { fg = colors.red, bg = "none", gui = "bold" }, padding = { left = 0, right = 0 } },
      { "location", color = { fg = colors.red, bg = "none", gui = "bold" }, padding = { left = 1, right = 0 } },
    },
  },
})
