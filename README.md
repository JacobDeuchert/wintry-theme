# Wintry - Theme

Minimal dark theme with blueish and purple colors.

The theme is based of the [serendipity old](https://github.com/Serendipity-Theme/old-serendipity) theme and the great color work of [Miachel Andreuzza](https://github.com/michael-andreuzza)

### Typescript
<img src="./sceenshots/theme-typescript.png">

### Template
<img src="./sceenshots/theme-template.png">

### Style 
<img src="./sceenshots/theme-css.png">

## Neovim

The same palette ships as a Neovim colorscheme (requires Neovim 0.8+ and `termguicolors`).

**lazy.nvim**

```lua
{
  "JacobDeuchert/wintry-theme",
  lazy = false,
  priority = 1000,
  config = function()
    require("wintry").setup({})
    vim.cmd.colorscheme("wintry")
  end,
}
```

**packer.nvim**

```lua
use({ "JacobDeuchert/wintry-theme", config = function() vim.cmd.colorscheme("wintry") end })
```

Calling `setup()` is optional — `:colorscheme wintry` works on its own.

### Options

```lua
require("wintry").setup({
  transparent = false,     -- clear editor/float/sidebar backgrounds
  terminal_colors = true,  -- set g:terminal_color_*
  dim_inactive = false,    -- darken unfocused windows
  styles = {
    comments = { italic = true },
    keywords = {},
    functions = {},
    variables = {},
    strings = {},
    booleans = {},
  },
  on_colors = function(palette) end,       -- tweak colors before highlights are built
  on_highlights = function(hl, colors) end -- override highlight groups (table also accepted)
})
```

Covered out of the box: treesitter, LSP semantic tokens, diagnostics, gitsigns, telescope,
fzf-lua, nvim-cmp, blink.cmp, nvim-tree, neo-tree, oil, bufferline, indent-blankline,
which-key, noice/notify, mini.nvim, flash/hop/leap, nvim-dap, trouble and todo-comments.

The palette is importable for your own highlights:

```lua
local colors = require("wintry.palette")
```

### Palette generation

`lua/wintry/palette.lua` is generated from `themes/Wintry-color-theme.json`, so the
Neovim port cannot drift from the VS Code theme. Edit the JSON, then:

```sh
nvim -l scripts/gen_palette.lua          # regenerate
nvim -l scripts/gen_palette.lua --check  # exit 1 if out of date
```

Both editors ship from this repo under a single version, taken from `package.json`.

**lualine**

```lua
require("lualine").setup({ options = { theme = "wintry" } })
```


### Feedback
If you have suggestions, please open an [issue](https://github.com/JacobDeuchert/wintry/issues).

### Authors

Authored and maintained by [Jacob Deuchert](https://github.com/JacobDeuchert)

Base theme made by [Miachel Andreuzza](https://github.com/michael-andreuzza) 