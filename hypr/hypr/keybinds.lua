-- open menu
hl.bind("SUPER + space", hl.dsp.exec_cmd("wofi --show drun"))
-- open browser
hl.bind("SUPER + B", hl.dsp.exec_cmd("firefox"))
-- full-screen screenshot
hl.bind("SUPER + P", hl.dsp.exec_cmd("grim ~/Pictures/Screenshot/$(date +%Y%m%d_%H%M%S).png | wl-copy"))
-- select area screeshot
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("grim -g \"$(slurp)\" ~/Pictures/Screenshot/$(date +%Y%m%d_%H%M%S).png | wl-copy"))
