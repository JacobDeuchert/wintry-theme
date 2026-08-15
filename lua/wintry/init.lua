local config = require("wintry.config")

local M = {}

M.config = config
M.setup = config.setup

--- Return the palette, with `on_colors` applied.
function M.colors()
  local palette = vim.deepcopy(require("wintry.palette"))
  if type(config.options.on_colors) == "function" then
    config.options.on_colors(palette)
  end
  return palette
end

local function set_terminal_colors(c)
  local t = c.term
  vim.g.terminal_color_0 = t.black
  vim.g.terminal_color_1 = t.red
  vim.g.terminal_color_2 = t.green
  vim.g.terminal_color_3 = t.yellow
  vim.g.terminal_color_4 = t.blue
  vim.g.terminal_color_5 = t.magenta
  vim.g.terminal_color_6 = t.cyan
  vim.g.terminal_color_7 = t.white
  vim.g.terminal_color_8 = t.bright_black
  vim.g.terminal_color_9 = t.bright_red
  vim.g.terminal_color_10 = t.bright_green
  vim.g.terminal_color_11 = t.bright_yellow
  vim.g.terminal_color_12 = t.bright_blue
  vim.g.terminal_color_13 = t.bright_magenta
  vim.g.terminal_color_14 = t.bright_cyan
  vim.g.terminal_color_15 = t.bright_white
end

--- Apply the colorscheme.
---@param opts table|nil options, merged into the current config
function M.load(opts)
  if opts then
    config.setup(opts)
  end

  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  vim.o.termguicolors = true
  vim.g.colors_name = "wintry"
  vim.o.background = "dark"

  local c = M.colors()
  local groups = require("wintry.highlights").get(c, config.options)

  for name, spec in pairs(groups) do
    vim.api.nvim_set_hl(0, name, spec)
  end

  if config.options.terminal_colors then
    set_terminal_colors(c)
  end
end

return M
