{
  global = {
    width = 300;
    height = 300;
    offset = "30x50";
    origin = "top-right";
    transparency = 10;
    frame_color = "#5F676A";
    font = "Droid Sans 9";
    separator_height = 2;
    padding = 8;
    frame_width = 3;
  };

  urgency_low = {
    background = "#222222";
    foreground = "#888888";
    timeout = 10;
  };
    
  urgency_normal = {
    background = "#402F65";
    foreground = "#FFFFFF";
    frame_color = "#5F676A";
    timeout = 10;
  };

  urgency_critical = {
    background = "#900000";
    foreground = "#FFFFFF";
    frame_color = "#FF0000";
    timeout = 0;
  };
}