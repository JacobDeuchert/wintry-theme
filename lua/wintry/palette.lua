-- Wintry palette — v0.0.3
--
-- Generated from themes/Wintry-color-theme.json by scripts/gen_palette.lua.
-- Do not edit by hand; change the VS Code theme and regenerate:
--   nvim -l scripts/gen_palette.lua
--
-- Colors that are translucent in VS Code are pre-blended over the background
-- they sit on, since Neovim highlights have no alpha channel.

return {
  -- surfaces
  bg = "#1e2431", -- editor.background
  bg_alt = "#191f28", -- sidebar / statusline / panels
  bg_deep = "#141925", -- widget shadow, float borders
  bg_line = "#191e2a", -- cursorline / range highlight
  bg_sel = "#33415e", -- editor.selectionBackground
  bg_sel_dim = "#323a4c", -- inactive selection
  bg_inactive = "#1c2335", -- unfocused list selection
  border = "#22272e",
  border_light = "#434957",
  shadow = "#101521",

  -- text
  fg = "#f6f6f6",
  fg_dim = "#8c94a3",
  fg_dark = "#5f6878",
  fg_darker = "#525a69",
  comment = "#5c6773",
  gutter = "#3f4653",
  gutter_active = "#6b7381",
  punctuation = "#b6b7bb",
  hint = "#7892bf", -- inlay hints

  -- accents
  pink = "#f886c5",
  pink_dark = "#df6896",
  pink_deep = "#f06897", -- badge accent, alpha dropped
  purple = "#be95ff",
  purple_light = "#d4bfff",
  magenta = "#c594c5",
  blue = "#78a9ff",
  blue_light = "#73d0ff",
  blue_soft = "#77a8d9",
  blue_dim = "#4b6798",
  cyan = "#68dfdf",
  cyan_light = "#9ef0f0",
  cyan_pale = "#b5e7e7",
  mint = "#95e6cb",
  salmon = "#f28779",
  red = "#f27983",
  red_bright = "#ff3333",
  orange = "#f29e74",
  green = "#a6cc70",
  green_dark = "#748e4e",
  yellow = "#fad07b",
  yellow_dark = "#c8a662",
  cream = "#ffe6b3",

  -- blended backgrounds
  bg_search = "#39463e", -- green wash
  bg_search_cur = "#553d56", -- pink wash
  bg_word = "#303e53",
  bg_badge = "#483245",
  bg_add = "#323d3a",
  bg_change = "#363550",
  bg_delete = "#3e363b",
  bg_text = "#2e3c4f", -- diff text

  -- terminal
  term = {
    black = "#1c1c1c",
    bright_black = "#6b7280",
    red = "#be95ff",
    bright_red = "#d4bfff",
    green = "#748e4e",
    bright_green = "#a6cc70",
    yellow = "#c8a662",
    bright_yellow = "#fad07b",
    blue = "#78a9ff",
    bright_blue = "#8bb6ff",
    magenta = "#e879f9",
    bright_magenta = "#f0abfc",
    cyan = "#22d3ee",
    bright_cyan = "#67e8f9",
    white = "#9ca3af",
    bright_white = "#ffffff",
  },
}
