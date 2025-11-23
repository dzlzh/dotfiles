local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.front_end = "OpenGL" -- WebGpu|OpenGL
config.default_domain = 'WSL:Arch'
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {left = 0, right = 0, top = 0, bottom = 0}
config.send_composed_key_when_left_alt_is_pressed = false
config.freetype_load_target = 'HorizontalLcd'
config.freetype_render_target = 'HorizontalLcd'
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
config.color_scheme = 'Catppuccin Mocha' -- Catppuccin Mocha|Gruvbox Dark|Tokyo Night|One Dark (Gogh)

config.font = wezterm.font_with_fallback {
  { family = 'Google Sans Code', weight = 'Medium' },
  { family = 'Maple Mono Normal NF CN', weight = 'Regular', scale = 1.1 },
  { family = 'LXGW WenKai Mono', weight = 'Medium', scale = 1.15 },
  { family = 'Symbols Nerd Font Mono', scale = 0.9 },
}
config.font_size = 12
-- config.line_height = 1.2
config.font_rules = {
  {
    intensity = 'Normal',
    italic = true,
    font = wezterm.font_with_fallback {
        {family = 'Google Sans Code', style = 'Italic', weight = 'Medium'},
        {family = 'Maple Mono Normal NF CN', style = 'Italic', weight = 'Regular'},
    }
  },
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font_with_fallback {
        {family = 'Google Sans Code', weight = 'Bold'},
        {family = 'Maple Mono Normal NF CN', weight = 'Bold'},
    }
  },
}

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return config
