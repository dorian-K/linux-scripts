-- Refer to the wiki: https://wiki.hypr.land/Configuring/Start/

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("GDK_BACKEND", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("ELECTRON_ENABLE_USE_WAYLAND", "1")
hl.env("SPOTIFY_USE_WAYLAND", "1")
-- hl.env("XDG_CURRENT_DESKTOP", "GNOME")
-- hl.env("XDG_SESSION_DESKTOP", "GNOME")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
    output = "desc:Samsung Electric Company LC32G5xT HNTT700231",
    mode = "preferred",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "desc:Acer Technologies Acer KA240H T6NEE0014201",
    mode = "preferred",
    position = "2560x360",
    scale = 1,
})

hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "0x0",
    scale = 1.566667,
})

hl.monitor({
    output = "desc:ORION ELECTRIC CO. LTD. CLB32B760S",
    mode = "preferred",
    position = "0x-768",
    scale = 1,
})

hl.monitor({
    output = "desc:Fujitsu Siemens Computers GmbH B27-8 TS Pro YVDM010910",
    mode = "preferred",
    position = "0x-1080",
    scale = 1,
})

hl.monitor({
    output = "desc:Samsung Electric Company SyncMaster H9XZ910334",
    mode = "preferred",
    position = "0x-1200",
    scale = 1,
})

-- Catch-all fallback. Keep this last; monitor calls are cumulative.
hl.monitor({
    output = "",
    mode = "highres",
    position = "auto-up",
    scale = 1,
})

-- HDR-capable monitor, disabled:
-- hl.monitor({
--     output            = "desc:AOC 24P3C AVPR29A000452",
--     mode              = "highrr",
--     position          = "auto-up",
--     scale             = 1,
--     supports_hdr      = true,
--     sdr_min_luminance = 0.005,
--     sdr_max_luminance = 300,
-- })

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "kitty"
local fileManager = "nautilus"
-- local menu = "wofi --show drun --insensitive"
local menu = "hyprlauncher"

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 0,
        border_size = 0,
        col = {
            active_border = "rgba(ffffff33)",
            inactive_border = "rgba(59595922)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 5,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },

    input = {
        kb_layout = "us,de",
        kb_variant = ",",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        -- sensitivity and accel_profile are set per-device below
        force_no_accel = false,
        touchpad = {
            scroll_factor = 0.3,
            natural_scroll = true,
        },
    },

    gestures = {
        workspace_swipe_invert = true,
        workspace_swipe_distance = 500,
    },
})

--------------------
---- ANIMATIONS ----
--------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.1, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = false, speed = 0.5, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 3, bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeLayersOut", enabled = false })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-------------------------
---- WORKSPACE RULES ----
-------------------------

hl.workspace_rule({
    workspace = "1",
    monitor = "desc:Samsung Electric Company LC32G5xT HNTT700231",
    default = true,
})

hl.workspace_rule({
    workspace = "2",
    monitor = "desc:Acer Technologies Acer KA240H T6NEE0014201",
    default = true,
})

-- "Smart gaps" / "No gaps when only" -- uncomment if you want it.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ match = { float = false, workspace = "f[1]"   }, border_size = 0, rounding = 0 })

----------------------
---- INPUT DEVICES ----
----------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/

hl.device({ name = "mchose-mchose-ax5-2.4g-1", accel_profile = "flat", sensitivity = -0.6 })
hl.device({ name = "realtek-mchose-a7-v2-ultra", accel_profile = "flat", sensitivity = -0.8 })
hl.device({ name = "razer-razer-mamba-wireless-receiver-1", accel_profile = "flat", sensitivity = -0.65 })
hl.device({ name = "pixa3854:00-093a:0274-touchpad", accel_profile = "adaptive", sensitivity = -0.15 })

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

---------------------
---- KEYBINDINGS ----
---------------------
-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
-- hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
-- hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Resize focused window with arrow keys.
-- `relative = true` makes x/y a delta; without it they are an absolute target
-- size and must both be >= 1, so the negative values below would be rejected.
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -80, y = 0,   relative = true }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x =  80, y = 0,   relative = true }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,   y = -40, relative = true }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,   y =  40, relative = true }))

-- Screenshot
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region -z"))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && ~/.config/mako/wp-vol.sh"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && ~/.config/mako/wp-vol.sh"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl s -e 8%+ && ~/.config/mako/brightness.sh"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl s -e 8%- && ~/.config/mako/brightness.sh"),
    { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- Rules are evaluated top to bottom, so order matters.

-- How long a one-shot workspace rule keeps applying once the app's first window
-- has appeared. Covers splash screens and multi-window startup.
local WS_ONCE_GRACE = 10000 -- ms

--- A window rule that places matching windows on a workspace, then stops.
--- The rule stays armed until the app's first window appears; from then on it
--- keeps applying for `grace` ms and disarms for good. If the app never opens,
--- the rule stays armed.
---
--- `class` is compared literally, both as the rule's regex and as the lua-side
--- test, so the two can't drift apart. Don't pass a regex.
---@param class string exact window class, e.g. "firefox"
---@param workspace integer|string target workspace
---@param opts? { grace?: integer, name?: string }
---@return HL.WindowRule
local function workspace_rule_once(class, workspace, opts)
    opts = opts or {}

    local rule = hl.window_rule({
        name = opts.name or ("ws_once_" .. class),
        match = { class = "^(" .. class .. ")$" },
        workspace = workspace,
    })

    local sub, timer

    local function disarm()
        if rule:is_enabled() then
            rule:set_enabled(false)
        end
        if sub then
            sub:remove()
            sub = nil
        end
        timer = nil
    end

    sub = hl.on("window.open", function(w)
        -- start the countdown on the first match only; later matches inside the
        -- grace window are placed by the rule and don't extend it
        if w.class == class and not timer then
            timer = hl.timer(disarm, { timeout = opts.grace or WS_ONCE_GRACE, type = "oneshot" })
        end
    end)

    return rule
end

-- Fix some dragging issues with XWayland
hl.window_rule({
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

-- One-shot placement rules.
workspace_rule_once("discord", 2)
workspace_rule_once("firefox", 1, { name = "w1_firefox" })
workspace_rule_once("Spotify", 2)

hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- NOT one-shot: this one also suppresses fullscreen events, which should keep
-- applying to every steam/wine window, not just the first.
hl.window_rule({
    match = { class = "^(steam_app_|wine|DXVK).*$" },
    suppress_event = "fullscreen",
    workspace = 9,
})

hl.window_rule({ match = { initial_title = "^(Godot)(.*)$" }, center = true })

hl.window_rule({ match = { class = "(pinentry-)(.*)" }, stay_focused = true })

hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, float = true })
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, center = true })
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, size = { 900, 500 } })

-------------------
---- AUTOSTART ----
-------------------
-- hyprland.start fires once per session; config reloads fire a separate event.

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    -- hl.exec_cmd(terminal)
    hl.exec_cmd("spotify")
    hl.exec_cmd("discord")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("flatpak run com.github.wwmm.easyeffects --gapplication-service")
    hl.exec_cmd("hypridle")
    -- hl.exec_cmd("~/.config/hypr/set_input_profile.sh")
    -- hl.exec_cmd("~/.config/hypr/gnome.sh")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("hyprlauncher -d")
    hl.exec_cmd("dunst")
    hl.exec_cmd("firefox")
end)
