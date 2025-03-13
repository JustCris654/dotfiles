-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Kanagawa (Gogh)"
config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font("VictorMono Nerd Font", { weight = "Bold", style = "Italic" })
config.font_size = 15

config.window_frame = {
    font = wezterm.font({ family = "VictorMono Nerd Font", weight = "Bold", italic = false }),

    font_size = 12.0,

    -- The overall background color of the tab bar when
    -- the window is focused
    active_titlebar_bg = "#333333",

    -- The overall background color of the tab bar when
    -- the window is not focused
    inactive_titlebar_bg = "#333333",
}

config.colors = {
    tab_bar = {
        -- The color of the inactive tab bar edge/divider
        inactive_tab_edge = "#575757",
    },
}

-- and finally, return the configuration to wezterm
return config
