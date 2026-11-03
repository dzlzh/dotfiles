local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.front_end = "OpenGL" -- WebGpu|OpenGL
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {left = 0, right = 0, top = 0, bottom = 0}
config.send_composed_key_when_left_alt_is_pressed = false
config.freetype_load_target = 'HorizontalLcd'
config.freetype_render_target = 'HorizontalLcd'
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
config.unicode_version = 15
config.term = "xterm-256color"

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

config.font = wezterm.font_with_fallback {
  { family = 'Maple Mono Normal NF CN', weight = 'Regular'},
  { family = 'Google Sans Code', weight = 'Medium' },
  { family = 'LXGW WenKai Mono', weight = 'Medium', scale = 1.15 },
  { family = 'Noto Sans', scale = 0.95 },
  { family = 'Nirmala UI', scale = 0.9 },
  { family = 'Microsoft Sans Serif', scale = 0.9 },
  { family = 'Segoe UI', scale = 0.9 },
  { family = 'Symbols Nerd Font Mono', scale = 0.9 },

}
config.font_size = 12
-- config.line_height = 1.2
config.font_rules = {
  {
    intensity = 'Normal',
    italic = true,
    font = wezterm.font_with_fallback {
        {family = 'Maple Mono Normal NF CN', style = 'Italic', weight = 'Regular'},
        {family = 'Google Sans Code', style = 'Italic', weight = 'Medium'},
    }
  },
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font_with_fallback {
        {family = 'Maple Mono Normal NF CN', weight = 'Bold'},
        {family = 'Google Sans Code', weight = 'Bold'},
    }
  },
}

config.color_schemes = config.color_schemes or {}
config.color_schemes['Inkstone Xuanmo'] = {
  foreground = '#d4cec4',
  background = '#14131a',
  cursor_bg = '#619ac3',
  cursor_fg = '#14131a',
  cursor_border = '#619ac3',
  selection_bg = '#332f46',
  selection_fg = '#d4cec4',
  compose_cursor = '#f28e16',
  scrollbar_thumb = 'rgba(212,206,196,0.18)',
  split = '#2b2a36',
  visual_bell = '#f28e16',
  ansi = {
    '#3a3646',
    '#e1505d',
    '#2bae85',
    '#e2c027',
    '#619ac3',
    '#c08eaf',
    '#57c3c2',
    '#cfc8bb',
  },
  brights = {
    '#6b6478',
    '#ea586c',
    '#45b787',
    '#eed045',
    '#8fb2c9',
    '#d1c2d3',
    '#93d5dc',
    '#f4efe4',
  },
  tab_bar = {
    background = '#1a1922',
    inactive_tab_edge = '#1a1922',
    active_tab = {
      bg_color = '#302e3c',
      fg_color = '#d4cec4',
      intensity = 'Bold',
      underline = 'None',
      italic = false,
      strikethrough = false,
    },
    inactive_tab = {
      bg_color = '#1a1922',
      fg_color = '#ada599',
      intensity = 'Normal',
    },
    inactive_tab_hover = {
      bg_color = '#2b2a36',
      fg_color = '#d4cec4',
      italic = false,
    },
    new_tab = {
      bg_color = '#1a1922',
      fg_color = '#ada599',
    },
    new_tab_hover = {
      bg_color = '#2b2a36',
      fg_color = '#d4cec4',
    },
  },
}
config.color_scheme = 'Inkstone Xuanmo' -- Catppuccin Mocha|Gruvbox Dark|Tokyo Night|One Dark (Gogh)

config.keys = {
  {
    key = "o",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ShowLauncher,
  },
}

config.ssh_domains = {
  {
    name = 'ssh',
    remote_address = '127.0.0.1:22',
    username = 'root',
    multiplexing = 'None',
    assume_shell = 'Posix',
  },
}
config.default_domain = 'WSL:Arch'

return config
