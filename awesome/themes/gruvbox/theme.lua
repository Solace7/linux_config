---------------------------
-- Gruvbox Awesome Theme
-- Edited by: Solace_Greyowl
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local xrdb = xresources.get_current_theme()
local gfs = require("gears.filesystem")
local themes_path = gfs.get_xdg_config_home() .. "awesome/themes/"
local themes_dir = themes_path .. "gruvbox"

local theme = {}
theme.panel_height = 26 
theme.wallpaper = themes_dir.."/background.png"

theme.font          = "Fira Code 8"

theme.color = {
    background      = xrdb.background,
    selected        = xrdb.foreground,
    alert           = xrdb.color11,
    focused         = "#1f1f1f",
    selected_text   = xrdb.foreground
}

theme.bg_normal     = theme.color.background
theme.bg_focus      = theme.color.focused
theme.bg_urgent     = theme.color.alert
theme.bg_minimize   = theme.color.focused
theme.bg_systray    = theme.color.bg_normal

theme.fg_normal     = theme.color.selected_text 
theme.fg_focus      = theme.color.selected.text
theme.fg_urgent     = theme.color.background
theme.fg_minimize   = theme.color.selected_text
theme.fg_systray    = theme.color.selected_text 

--theme.useless_gap   = dpi(0)
theme.border_width  = dpi(1)
theme.border_normal = theme.color.bg_normal
theme.border_focus  = theme.color.bg_focus
theme.border_marked = theme.bg_urgent

theme.titlebar_bg_focus = theme.color.bg_focus
theme.titlebar_fg_focus = theme.color.fg_focus

theme.taglist_bg_focus = "png:"..themes_dir .. "/taglist/taglist_sel.png"
theme.taglist_fg_urgent = theme.fg_urgent
theme.taglist_fg_focus = theme.color.selected_text
theme.taglist_fg_urgent = theme.fg_urgent

theme.tasklist_bg_focus = "png:"..themes_dir .. "/taglist/tasklist_sel.png"
theme.tasklist_fg_focus = theme.color.fg_normal
theme.tasklist_disable_icon = true
theme.tasklist_plain_task_name = true

theme.hotkeys_modifiers_fg = xrdb.color7

theme.tooltip_border_color = theme.fg_normal
theme.tooltip_fg = theme.fg_normal

notification_font = "Fira Code 8" 
notification_width = 7
notification_height = 7 
notification_icon_size = 1

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_dir.."/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- Define the image to load
theme.titlebar_close_button_normal = themes_dir.."/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_dir.."/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_dir.."/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_dir.."/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_dir.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_dir.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_dir.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_dir.."/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_dir.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_dir.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_dir.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_dir.."/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_dir.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_dir.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_dir.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_dir.."/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_dir.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_dir.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_dir.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_dir.."/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
--theme.layout_fairh = themes_dir.."/layouts/fairhw.png"
--theme.layout_fairv = themes_dir.."/layouts/fairvw.png"
--theme.layout_floating  = themes_dir.."/layouts/floatingw.png"
--theme.layout_magnifier = themes_dir.."/layouts/magnifierw.png"
--theme.layout_max = themes_dir.."/layouts/maxw.png"
--theme.layout_fullscreen = themes_dir.."/layouts/fullscreenw.png"
--theme.layout_tilebottom = themes_dir.."/layouts/tilebottomw.png"
--theme.layout_tileleft   = themes_dir.."/layouts/tileleftw.png"
--theme.layout_tile = themes_dir.."/layouts/tilew.png"
--theme.layout_tiletop = themes_dir.."/layouts/tiletopw.png"
--theme.layout_spiral  = themes_dir.."/layouts/spiralw.png"
--theme.layout_dwindle = themes_dir.."/layouts/dwindlew.png"
--theme.layout_cornernw = themes_dir.."/layouts/cornernww.png"
--theme.layout_cornerne = themes_dir.."/layouts/cornernew.png"
--theme.layout_cornersw = themes_dir.."/layouts/cornersww.png"
--theme.layout_cornerse = themes_dir.."/layouts/cornersew.png"

-- Panel Widgets
theme.widget = {}

-- Layoutbox
theme.widget.layoutbox = {
    micon = themes_path.."submenu.png",
    color = theme.color
}

theme.widget.layoutbox.icon = {
--	floating          = theme.path .. "/layouts/floating.svg",
--	max               = theme.path .. "/layouts/max.svg",
--	fullscreen        = theme.path .. "/layouts/fullscreen.svg",
--	tilebottom        = theme.path .. "/layouts/tilebottom.svg",
--	tileleft          = theme.path .. "/layouts/tileleft.svg",
--	tile              = theme.path .. "/layouts/tile.svg",
--	tiletop           = theme.path .. "/layouts/tiletop.svg",
--	fairv             = theme.path .. "/layouts/fair.svg",
--	fairh             = theme.path .. "/layouts/fair.svg",
--	grid              = theme.path .. "/layouts/grid.svg",
--	usermap           = theme.path .. "/layouts/map.svg",
--	magnifier         = theme.path .. "/layouts/magnifier.svg",
--	cornerne          = theme.path .. "/layouts/cornerne.svg",
--	cornernw          = theme.path .. "/layouts/cornernw.svg",
--	cornerse          = theme.path .. "/layouts/cornerse.svg",
--	cornersw          = theme.path .. "/layouts/cornersw.svg",
--	unknown           = theme.path .. "/common/unknown.svg",
}

theme.widget.layoutbox.name_alias = {
    floating    = "Floating",
    magnifier   = "Magnifier",
    fairv       = "Fair Tile",
    max         = "Maximized",
}
-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.color.bg_focus, theme.color.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Numix"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
