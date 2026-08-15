local M = {}

M.defaults = {
  -- clear the background of the editor, floats and sidebars so the
  -- terminal shows through
  transparent = false,
  -- set g:terminal_color_* from the palette
  terminal_colors = true,
  -- darken windows that are not focused
  dim_inactive = false,
  styles = {
    comments = { italic = true },
    keywords = {},
    functions = {},
    variables = {},
    strings = {},
    booleans = {},
  },
  -- fun(highlights, palette) or table of highlight overrides applied last
  on_highlights = nil,
  -- fun(palette) to tweak colors before highlights are built
  on_colors = nil,
}

M.options = vim.deepcopy(M.defaults)

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), opts or {})
  return M.options
end

return M
