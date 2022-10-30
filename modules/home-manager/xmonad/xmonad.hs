import XMonad

main = xmonad def{
        modMask = mod1Mask -- Use Super instead of Alt
        , terminal = "alacritty"
        -- more changes
        }
