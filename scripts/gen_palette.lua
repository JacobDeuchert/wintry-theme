-- Generates lua/wintry/palette.lua from themes/Wintry-color-theme.json so the
-- Neovim port can never drift from the VS Code theme.
--
--   nvim -l scripts/gen_palette.lua          write the palette
--   nvim -l scripts/gen_palette.lua --check  fail if it is out of date
--
-- Sources are written as:
--   ui:<key>     a key from the theme's "colors" block
--   tok:<name>   the foreground of the tokenColors entry with that name
--   lit:#rrggbb  a literal
--
-- `over` blends the source onto another color. VS Code colors carry an alpha
-- channel, Neovim highlights do not, so anything translucent is pre-blended
-- here. `alpha` overrides the alpha embedded in the source, which is useful
-- where VS Code's value is so faint it would vanish in a terminal.

local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
local theme_path = root .. "/themes/Wintry-color-theme.json"
local package_path = root .. "/package.json"
local out_path = root .. "/lua/wintry/palette.lua"

local function read(path)
  local fd = assert(io.open(path, "r"), "cannot read " .. path)
  local content = fd:read("*a")
  fd:close()
  return content
end

local theme = vim.json.decode(read(theme_path))
local version = vim.json.decode(read(package_path)).version

local function token(name)
  for _, entry in ipairs(theme.tokenColors) do
    if entry.name == name then
      return entry.settings.foreground
    end
  end
  error("no tokenColor named " .. name)
end

local function resolve(src)
  local kind, value = src:match("^(%a+):(.*)$")
  if kind == "ui" then
    return assert(theme.colors[value], "no theme color " .. value)
  elseif kind == "tok" then
    return token(value)
  elseif kind == "lit" then
    return value
  end
  error("bad source " .. src)
end

local function parse(hex)
  local r, g, b, a = hex:match("^#(%x%x)(%x%x)(%x%x)(%x?%x?)$")
  assert(r, "bad color " .. hex)
  return tonumber(r, 16), tonumber(g, 16), tonumber(b, 16), a ~= "" and tonumber(a, 16) / 255 or nil
end

local function blend(fg, bg, alpha)
  local fr, fg_, fb = parse(fg)
  local br, bg_, bb = parse(bg)
  local function mix(f, b)
    return math.floor(f * alpha + b * (1 - alpha) + 0.5)
  end
  return string.format("#%02x%02x%02x", mix(fr, br), mix(fg_, bg_), mix(fb, bb))
end

--- Resolve one spec entry to an opaque `#rrggbb`.
local function build(entry)
  local color = resolve(entry.src)
  local r, g, b, embedded = parse(color)
  local alpha = entry.alpha or embedded
  if entry.over then
    return blend(color, build({ src = entry.over }), alpha or 1)
  end
  return string.format("#%02x%02x%02x", r, g, b)
end

local BG = "ui:editor.background"
local BG_ALT = "ui:sideBar.background"

-- Ordered so the generated file stays readable and diffs stay small.
local spec = {
  { section = "surfaces" },
  { key = "bg", src = BG, note = "editor.background" },
  { key = "bg_alt", src = BG_ALT, note = "sidebar / statusline / panels" },
  { key = "bg_deep", src = "ui:widget.shadow", note = "widget shadow, float borders" },
  { key = "bg_line", src = "ui:editor.lineHighlightBackground", note = "cursorline / range highlight" },
  { key = "bg_sel", src = "ui:editor.selectionBackground", note = "editor.selectionBackground" },
  { key = "bg_sel_dim", src = "ui:editor.inactiveSelectionBackground", note = "inactive selection" },
  { key = "bg_inactive", src = "ui:list.inactiveSelectionBackground", over = BG_ALT, note = "unfocused list selection" },
  { key = "border", src = "ui:activityBar.border" },
  { key = "border_light", src = "ui:dropdown.border" },
  { key = "shadow", src = "ui:editorSuggestWidget.border" },

  { section = "text" },
  { key = "fg", src = "ui:editor.foreground" },
  { key = "fg_dim", src = "ui:foreground" },
  { key = "fg_dark", src = "ui:input.placeholderForeground" },
  { key = "fg_darker", src = "ui:pickerGroup.foreground" },
  { key = "comment", src = "tok:Comment" },
  { key = "gutter", src = "ui:editorIndentGuide.background", over = BG },
  { key = "gutter_active", src = "ui:editorIndentGuide.activeBackground", over = BG },
  { key = "punctuation", src = "tok:Separators like ; or ,", over = BG },
  { key = "hint", src = "ui:editorInlayHint.foreground", over = BG, note = "inlay hints" },

  { section = "accents" },
  { key = "pink", src = "ui:editorCursor.foreground" },
  { key = "pink_dark", src = "tok:Number" },
  { key = "pink_deep", src = "ui:badge.background", note = "badge accent, alpha dropped" },
  { key = "purple", src = "tok:String" },
  { key = "purple_light", src = "tok:Function arguments" },
  { key = "magenta", src = "tok:diff.header" },
  { key = "blue", src = "ui:sideBarTitle.foreground" },
  { key = "blue_light", src = "tok:Entity name" },
  { key = "blue_soft", src = "ui:settings.modifiedItemIndicator" },
  { key = "blue_dim", src = "tok:Tag start/end", over = BG },
  { key = "cyan", src = "tok:Function call" },
  { key = "cyan_light", src = "tok:Tag attribute" },
  { key = "cyan_pale", src = "tok:Function name" },
  { key = "mint", src = "tok:Regular Expressions and Escape Characters" },
  { key = "salmon", src = "tok:Member Variable" },
  { key = "red", src = "ui:list.errorForeground" },
  { key = "red_bright", src = "ui:errorForeground" },
  { key = "orange", src = "ui:editorWarning.foreground" },
  { key = "green", src = "tok:Markup added" },
  { key = "green_dark", src = "ui:terminal.ansiGreen" },
  { key = "yellow", src = "ui:terminal.ansiBrightYellow" },
  { key = "yellow_dark", src = "ui:terminal.ansiYellow" },
  { key = "cream", src = "tok:Decorators/annotation" },

  { section = "blended backgrounds" },
  { key = "bg_search", src = "tok:Markup added", over = BG, alpha = 0.2, note = "green wash" },
  { key = "bg_search_cur", src = "ui:editorCursor.foreground", over = BG, alpha = 0.25, note = "pink wash" },
  { key = "bg_word", src = "ui:editor.wordHighlightBackground", over = BG, alpha = 0.2 },
  { key = "bg_badge", src = "ui:badge.background", over = BG },
  { key = "bg_add", src = "tok:Markup added", over = BG, alpha = 0.15 },
  { key = "bg_change", src = "ui:diffEditor.insertedTextBackground", over = BG },
  { key = "bg_delete", src = "ui:diffEditor.removedTextBackground", over = BG },
  { key = "bg_text", src = "ui:settings.modifiedItemIndicator", over = BG, alpha = 0.18, note = "diff text" },
}

local terminal = {
  { key = "black", src = "ui:terminal.ansiBlack" },
  { key = "bright_black", src = "ui:terminal.ansiBrightBlack" },
  { key = "red", src = "ui:terminal.ansiRed" },
  { key = "bright_red", src = "ui:terminal.ansiBrightRed" },
  { key = "green", src = "ui:terminal.ansiGreen" },
  { key = "bright_green", src = "ui:terminal.ansiBrightGreen" },
  { key = "yellow", src = "ui:terminal.ansiYellow" },
  { key = "bright_yellow", src = "ui:terminal.ansiBrightYellow" },
  { key = "blue", src = "ui:terminal.ansiBlue" },
  { key = "bright_blue", src = "ui:terminal.ansiBrightBlue" },
  { key = "magenta", src = "ui:terminal.ansiMagenta" },
  { key = "bright_magenta", src = "ui:terminal.ansiBrightMagenta" },
  { key = "cyan", src = "ui:terminal.ansiCyan" },
  { key = "bright_cyan", src = "ui:terminal.ansiBrightCyan" },
  { key = "white", src = "ui:terminal.ansiWhite" },
  { key = "bright_white", src = "ui:terminal.ansiBrightWhite" },
}

local out = {
  "-- Wintry palette — v" .. version,
  "--",
  "-- Generated from themes/Wintry-color-theme.json by scripts/gen_palette.lua.",
  "-- Do not edit by hand; change the VS Code theme and regenerate:",
  "--   nvim -l scripts/gen_palette.lua",
  "--",
  "-- Colors that are translucent in VS Code are pre-blended over the background",
  "-- they sit on, since Neovim highlights have no alpha channel.",
  "",
  "return {",
}

for _, entry in ipairs(spec) do
  if entry.section then
    table.insert(out, (#out > 10 and "" or nil))
    table.insert(out, "  -- " .. entry.section)
  else
    local line = string.format("  %s = %q,", entry.key, build(entry))
    if entry.note then
      line = line .. " -- " .. entry.note
    end
    table.insert(out, line)
  end
end

table.insert(out, "")
table.insert(out, "  -- terminal")
table.insert(out, "  term = {")
for _, entry in ipairs(terminal) do
  table.insert(out, string.format("    %s = %q,", entry.key, build(entry)))
end
table.insert(out, "  },")
table.insert(out, "}")
table.insert(out, "")

local generated = table.concat(out, "\n")

if _G.arg and _G.arg[1] == "--check" then
  local current = read(out_path)
  if current ~= generated then
    io.stderr:write("lua/wintry/palette.lua is out of date; run: nvim -l scripts/gen_palette.lua\n")
    os.exit(1)
  end
  print("palette is up to date (v" .. version .. ")")
  os.exit(0)
end

local fd = assert(io.open(out_path, "w"))
fd:write(generated)
fd:close()
print("wrote lua/wintry/palette.lua (v" .. version .. ")")
