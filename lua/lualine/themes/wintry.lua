local c = require("wintry.palette")

local inactive = { fg = c.fg_darker, bg = c.bg_alt }
local middle = { fg = c.fg_dim, bg = c.bg_alt }
local section_b = { fg = c.fg_dim, bg = c.bg_line }

local function mode(color)
  return { a = { fg = c.bg_alt, bg = color, gui = "bold" }, b = section_b, c = middle }
end

return {
  normal = mode(c.pink),
  insert = mode(c.blue),
  visual = mode(c.purple),
  replace = mode(c.red),
  command = mode(c.cyan),
  terminal = mode(c.green),
  inactive = { a = inactive, b = inactive, c = inactive },
}
