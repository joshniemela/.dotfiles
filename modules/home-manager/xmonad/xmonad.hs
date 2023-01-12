import           XMonad
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad.Util.NamedActions
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import System.IO
myTerminal = "alacritty"
myBrowser = "firefox"



myFocusFollowsMouse = True

myWorkspaces = map show [1..9]



myMainColor = "#333333"
myBgColor = "#FEFEFE"
myTextColor = "#282828"
myLowColor = "#999999"
myLowerColor = "#DDDDDD"
greenColor = "#75b92d"

myActiveColor = greenColor
myInactiveColor = myTextColor


-- Keybindings

myModMask = mod1Mask -- 3 is right alt and 4 is super

myKeys :: XConfig l0 -> [((KeyMask, KeySym), NamedAction)]
myKeys c =
  let subKeys str ks = subtitle str : ks
  in
  subKeys "XMonad essentials"
    [ ((myModMask .|. shiftMask, xK_r), addName "Recompile XMonad" $ spawn "xmonad --restart")
    , ((myModMask, xK_Return), addName "Open terminal" $ spawn myTerminal)
    , ((myModMask .|. shiftMask, xK_q), addName "Close window" kill)
    ]


showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
  h <- spawnPipe "zenity --text-info --font=terminus"
  hPutStr h (unlines $ showKm x)
  hClose h
  return ()




myLogHook h = dynamicLogWithPP $ def { ppOutput = hPutStrLn h }
myManageHook = manageDocks <+> manageHook defaultConfig
myLayoutHook = avoidStruts $ layoutHook defaultConfig

myEventHook = mconcat
  [ docksEventHook -- this is needed to properly get xmobar struts working
  , fullscreenEventHook
  ]

myStartupHook = do
  spawnOnce "autorandr -c"

myConfig statusPipe = def {
  -- simple stuff
    terminal           = myTerminal
  , focusFollowsMouse  = myFocusFollowsMouse
  , modMask            = myModMask
  , workspaces         = myWorkspaces

  -- hooks, layouts
  , logHook            = myLogHook statusPipe
  , manageHook         = myManageHook
  , layoutHook         = myLayoutHook
  , startupHook        = myStartupHook
  , handleEventHook          = myEventHook
}

main = do
  statusPipe <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
  xmonad
    $ addDescrKeys ((myModMask, xK_F1), showKeybindings) myKeys
    $ myConfig statusPipe
