{...}:
let
    carbon = ''
background            #000000
foreground            #afc2c2
cursor                #ffffff
selection_background  #7cbeff
color0                #000000
color8                #000000
color1                #ff2f2f
color9                #ff2f2f
color2                #549a6f
color10               #549a6f
color3                #ccac00
color11               #ccac00
color4                #0099cc
color12               #0099cc
color5                #cc68c8
color13               #cc68c8
color6                #79c4cc
color14               #79c4cc
color7                #bccccc
color15               #bccccc
selection_foreground  #000000
'';
    batman = ''
background            #1b1d1e
foreground            #6e6e6e
cursor                #fcee0b
selection_background  #4d4f4c
color0                #1b1d1e
color8                #505354
color1                #e6db43
color9                #fff68d
color2                #c8be46
color10               #fff27c
color3                #f3fd21
color11               #feed6c
color4                #737074
color12               #909495
color5                #737271
color13               #9a999d
color6                #615f5e
color14               #a2a2a5
color7                #c5c5be
color15               #dadad5
selection_foreground  #1b1d1e
'';
    wez = ''
background            #000000
foreground            #b3b3b3
cursor                #52ad70
selection_background  #4c52f8
color0                #000000
color8                #555555
color1                #cc5555
color9                #ff5555
color2                #55cc55
color10               #55ff55
color3                #cdcd55
color11               #ffff55
color4                #5455cb
color12               #5555ff
color5                #cc55cc
color13               #ff55ff
color6                #7acaca
color14               #55ffff
color7                #cccccc
color15               #ffffff
selection_foreground  #000000
'';
    gruvbox = ''
background            #282828
foreground            #ebdbb2
cursor                #928374
selection_background  #3c3836
color0                #282828
color8                #928374
color1                #cc241d
color9                #fb4934
color2                #98971a
color10               #b8bb26
color3                #d79921
color11               #fabd2d
color4                #458588
color12               #83a598
color5                #b16286
color13               #d3869b
color6                #689d6a
color14               #8ec07c
color7                #a89984
color15               #928374
selection_foreground  #928374
'';
    # the messy edit i made
    comet = ''
background            #1b1d1e
foreground            #6e6e6e
cursor                #fcee0b
selection_background  #4d4f4c
color0                #282828
color8                #928374
color1                #cc241d
color9                #fb4934
color2                #98971a
color10               #b8bb26
color3                #d79921
color11               #fabd2d
color4                #458588
color12               #83a598
color5                #b16286
color13               #d3869b
color6                #689d6a
color14               #8ec07c
color7                #a89984
color15               #928374
selection_foreground  #1b1d1e
'';
in{
    programs.kitty = {
        enable = true;
        extraConfig = ''
shell_integration     no-title
shell                 fish

font_family JetBrains Mono
bold_font JetBrains Mono Bold
italic_font JetBrains Mono Italic
bold_italic_font JetBrains Mono Bold Italic
font_size 12.0
'' + comet;
    };
}
