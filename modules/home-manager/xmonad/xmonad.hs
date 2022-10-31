import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab



main :: IO ()
main = xmonad $ def
    { 
        modMask = mod1Mask,  -- Rebind Mod to the Alt key
        keys = \c -> mkKeymap c [ 
        ("M-d", spawn "dmenu_run -sb '#402F65'"),
        ("<Print>", unGrab *> spawn "flameshot gui"),
        ("M-f"  , spawn "firefox"),
        ("M-<Return>", spawn "alacritty")]
    }

