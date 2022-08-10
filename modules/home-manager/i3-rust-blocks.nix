{
    blocks = [
    {
        block = "networkmanager";
        on_click = "alacritty -e nmtui";
        ap_format = "{ssid^10}";
    }
    {
        block = "disk_space";
        path = "/";
        alias = "/";
        info_type = "available";
        unit = "GB";
        interval = 60;
        warning = 20.0;
        alert = 10.0;
    }
    {
        block = "memory";
        format_mem = "{mem_avail}";
        format_swap = "{swap_avail}";
    }
    {
        block = "cpu";
        interval = 1;
        format="{barchart}";
    }
    { block = "sound"; }
    {
        block = "battery";
        interval = 15;
        format = "{percentage} {time}";
    }
    {
        block = "weather";
        format = "{weather} {temp}C {humidity}% {wind}m/s {direction}";
        service = {
        name = "openweathermap"; 
        api_key = "75913c9c48b7fcab3d9d9cae7c9dac7a";
        city_id = "2618425";
        units = "metric";
        };
    }
    {
        block = "time";
        interval = 60;
        format = "%a %d/%m %R";
        on_click = "thunderbird -calendar";
    }
    ];
    #settings = {
    #  theme =  {
    #    name = "solarized-dark";
    #    overrides = {
    #      idle_bg = "#123456";
    #      idle_fg = "#abcdef";
    #    };
    #  };
    #};
    icons = "awesome6";
    theme = "gruvbox-dark";
}
