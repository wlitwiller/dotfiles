-- ~/.config/nvim/lua/core/cheatsheet.lua
local M = {}

local function open_floating_text(lines, opts)
  opts = opts or {}
  local title = opts.title or "Cheatsheet"
  local width = math.floor(vim.o.columns * (opts.width_pct or 0.72))
  local height = math.floor(vim.o.lines * (opts.height_pct or 0.72))
  local row = math.floor((vim.o.lines - height) / 2 - 1)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = "markdown"

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " " .. title .. " ",
    title_pos = "center",
  })

  -- Make it feel like a popup
  vim.wo[win].wrap = false
  vim.wo[win].cursorline = false
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = "no"

  -- Close keys
  local function close()
    pcall(vim.api.nvim_win_close, win, true)
  end

  vim.keymap.set("n", "q", close, { buffer = buf, silent = true })
  vim.keymap.set("n", "<Esc>", close, { buffer = buf, silent = true })
end

function M.nvim()
  local lines = {
    "# Neovim Cheatsheet",
    "",
    "## Basics",
    "- `:w` save   `:q` quit   `:wq` save+quit   `:q!` force quit",
    "- `u` undo   `<C-r>` redo",
    "- `.` repeat last change",
    "",
    "## Movement",
    "- `h j k l` move   `w/b` word   `0/^` line start   `$` line end",
    "- `gg` top   `G` bottom   `{` / `}` paragraph",
    "- `f{char}` find char on line   `t{char}` to before char",
    "",
    "## Editing",
    "- `i/a/o` insert/append/newline   `dd` delete line   `yy` yank line",
    "- `p/P` paste after/before",
    "- Visual: `v` char   `V` line   `<C-v>` block",
    "",
    "## Search",
    "- `/` search   `n` next   `N` prev",
    "- `*` search word under cursor",
    "",
    "## Splits & Windows",
    "- `:vsplit` vertical   `:split` horizontal",
    "- `:close` close split",
    "- Your setup: `<C-h/j/k/l>` moves across nvim + tmux panes",
    "",
    "## Telescope (based on your binds)",
    "- `<C-p>` find files",
    "- `<Space>fg` live grep",
    "- `<Space>fh` help tags",
    "",
    "## LSP",
    "- `:LspInfo` status",
    "- `gd` definition   `gr` references   `K` hover",
    "",
    "---",
    "Press `q` or `<Esc>` to close.",
  }

  open_floating_text(lines, { title = "Neovim Cheatsheet" })
end

return M

