{
  config,
  lib,
  ...
}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "(5, 5)";
        frame_width = 2;
        gap_size = 5;
        follow = "keyboard";
        origin = "top-right";

        frame_color = "#5F676A";
        font = "Droid Sans 9";

        sort = true;
        show_indicators = true;
        idle_threshold = 60;

        markup = "full";
      };

      urgency_low = {
        background = "#080808";
        foreground = "#888888";
        frame_color = "#222222";
        timeout = 10;
      };

      urgency_normal = {
        background = "#202020";
        foreground = "#FFFFFF";
        frame_color = "#402F65";
        timeout = 10;
      };

      urgency_critical = {
        background = "#900000";
        foreground = "#FFFFFF";
        frame_color = "#FF0000";
        timeout = 0;
      };
    };
  };
}
