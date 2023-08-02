#!/usr/bin/env python3
import alduin.draw

# Lets keep all configs here
config.load_autoconfig(False)

# everforest.draw.konda(c, {"spacing": {"vertical": 5, "horizontal": 8}})
alduin.draw.konda(c)

c.fonts.default_size = "12pt"
c.fonts.default_family = "monospace"
c.fonts.prompts = "default_size default_family" # Only one whose default is sans-serif
c.url.start_pages = "~/.config/qutebrowser/startpage/index.html"
c.url.default_page = "~/.config/qutebrowser/startpage/index.html"
c.editor.command = ["alacritty", "--class", "qute", "-e", "/usr/bin/nvim", "{}"]

# External file selection
c.fileselect.handler = "external"
c.fileselect.folder.command = ["alacritty", "--class", "qute", "-e", "lf", "-selection-path", "{}"]
c.fileselect.multiple_files.command = ["alacritty", "--class", "qute", "-e", "lf", "-selection-path", "{}"]
c.fileselect.single_file.command = ["alacritty", "--class", "qute", "-e", "lf", "-selection-path", "{}"]

# Dark mode bay-bee
c.colors.webpage.darkmode.enabled =  False
c.colors.webpage.preferred_color_scheme = "dark"

# Settings
c.auto_save.session = True
c.content.blocking.method = "both"
c.completion.open_categories = ["searchengines", "quickmarks", "bookmarks", "history", "filesystem"]
c.downloads.remove_finished = 5000
c.tabs.show = "multiple"
c.tabs.favicons.show = "pinned"
c.tabs.indicator.width = 2
c.tabs.title.alignment = "center"
c.tabs.padding = {"bottom":15, "left": 8, "right": 8, "top": 15}
c.tabs.mousewheel_switching = False
c.statusbar.padding = {"bottom": 6, "left": 6, "right": 6, "top": 6}
c.hints.radius = 0
c.keyhint.radius = 0

# Tor browsing
# c.content.proxy = 'socks5://localhost:9050/'
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?ia=web&q={}",
    "!g": "https://google.com/search?hl=en&q={}",
    "!gh": "https://github.com/search?o=desc&q={}&s=stars",
    "!gi": "https://www.google.com/search?tbm=isch&q={}&tbs=imgo:1",
    "!m": "https://www.google.com/maps/search/{}",
    "!r": "https://www.reddit.com/search?q={}",
}

# Qute-pass keubindings
config.bind(
    ",pp",
    "spawn --userscript qute-pass",
)

config.bind(
    ",pP",
    "spawn --userscript qute-pass --password-only -d 'rofi -dmenu -p Qute-pass'",
)

config.bind(
    ",pu",
    "spawn --userscript qute-pass --username-only -d 'rofi -dmenu -p Qute-pass'",
)

# Open with mpv
config.bind(
    ",m",
    "spawn mpv {url}",
)

config.bind(
    ",M",
    "hint links spawn mpv {hint-url}",
)

# Swap J/K tab movement
config.bind(
    "J",
    "tab-prev",
)

config.bind(
    "K",
    "tab-next",
)
