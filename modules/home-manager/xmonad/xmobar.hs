Config 
  { font = "xft:Anonymice Nerd Font:size=9"
  , bgColor = "#FEFEFE"
  , fgColor = "#999999"
  , position = Static { xpos = 1, ypos = 1, width = 3838, height = 20 }
  , lowerOnStart = False
  , commands = [
    --, Run Battery ["-t", "<left><acstatus>"
                  --, "--"
                  --, "-O", "+", "-i", "", "-o", " <timeleft>"
                  --, "-L", "15", "-l", "red"
                  --, "-A", "2", "-a", "notify-send -u critical 'battery very low\nplug in now'"
                  --] 60
      Run MultiCpu ["-t", "<total>"] 30
    , Run Date "%_d %#B %Y <fc=#333333>|</fc> %H:%M" "date" 600
    , Run Alsa "default" "Master" ["-t", "<volume> <status>"]
    --, Run Kbd []
    , Run StdinReader
    ]
  }
