import XMonad
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad.Util.NamedActions
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import System.IO
import XMonad.Actions.WithAll
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import XMonad.Util.NamedScratchpad
myTerminal = "alacritty"
myBrowser = "firefox"



myFocusFollowsMouse = True

myWorkspaces = map show [1..9]

myFocusedBorderColor = "#D16328"
myNormalBorderColor = "#402F65"



-- Keybindings

myModMask = mod1Mask -- 3 is right alt and 4 is super

myKeys :: XConfig Layout -> [((KeyMask, KeySym), NamedAction)]
myKeys c =
  let subKeys str ks = subtitle str : ks
  in
  subKeys "Essentials"
    [ ((myModMask              , xK_q     ), addName "Recompile/restart XMonad" $ spawn "xmonad --recompile && pkill xmobar && xmonad --restart")
    , ((myModMask .|. shiftMask, xK_Return), addName "Open terminal" $ spawn myTerminal)
    , ((myModMask .|. shiftMask, xK_c     ), addName "Close window" kill)
    , ((myModMask              , xK_p     ), addName "Open dmenu" $ spawn "dmenu_run -sb '#402F65'")]

  ++ subtitle "Switching workspaces":
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [ ((m .|. myModMask, k), addName (n ++ i) $ windows $ f i)
        | (f, m, n) <- [(W.greedyView, 0, "Switch to workspace "), (W.shift, shiftMask, "Move client to workspace ")]
        , (i, k) <- zip (XMonad.workspaces c) [xK_1 .. xK_9]]

  ++ subtitle "Switching screens" :
    -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
   [ ((m .|. myModMask, key), addName (n ++ show sc) $ screenWorkspace sc >>= flip whenJust (windows . f))
        | (f, m, n) <- [(W.view, 0, "Switch to screen number "), (W.shift, shiftMask, "Move client to screen number ")]
        , (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]]

  ++ subKeys "Changing layouts"
  [ ((myModMask , xK_space ), sendMessage' NextLayout)
  , ((myModMask .|. shiftMask  , xK_space ), addName "Reset the layout" $ setLayout $ XMonad.layoutHook c)]

  ++ subKeys "Resizing"
  [ ((myModMask                , xK_h     ), sendMessage' Shrink)
  , ((myModMask                , xK_l     ), sendMessage' Expand)]

  ++ subKeys "Focus"
  [ ((myModMask                , xK_Tab   ), addName "Focus down" $ windows W.focusDown)
  , ((myModMask .|. shiftMask  , xK_Tab   ), addName "Focus up"   $ windows W.focusUp)
  , ((myModMask                , xK_j     ), addName "Focus down" $ windows W.focusDown)
  , ((myModMask                , xK_k     ), addName "Focus up"   $ windows W.focusUp)
  , ((myModMask                , xK_m     ), addName "Focus the master" $ windows W.focusMaster)]

  ++ subKeys "Modifying window order"
  [ ((myModMask,xK_Return), addName "Swap with the master" $ windows W.swapMaster)
  , ((myModMask .|. shiftMask  , xK_j     ), addName "Swap down" $ windows W.swapDown)
  , ((myModMask .|. shiftMask  , xK_k     ), addName "Swap up"   $ windows W.swapUp)]


  ++ subKeys "Floating windows"
  [ ((myModMask                , xK_t     ), addName "Push focused floating to tiled" $ withFocused $ windows . W.sink)
  , ((myModMask .|. shiftMask  , xK_t     ), addName "Push all floating to tiled" sinkAll)
  , ((myModMask                , xK_f     ), addName "Push focused to floating" $ sendMessage $ T.Toggle "floats")]

  ++ subKeys "Other stuff"
  [ ((noModMask                , xK_Print ), addName "Take screenshot" $ spawn "flameshot gui")
  ]

  ++ subKeys "Scratchpads"
  [ ((myModMask                , xK_b     ), addName "Open sagemath" $ namedScratchpadAction myScratchPads "sage") 
  ]


showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
  h <- spawnPipe "zenity --text-info --font=terminus"
  hPutStr h (unlines $ showKm x)
  hClose h
  return ()




myLogHook h = dynamicLogWithPP $ def 
  { ppLayout = wrap "(<fc=#e4b63c>" "</fc>)"
  -- , ppSort = getSortByXineramaRule  -- Sort left/right screens on the left, non-empty workspaces after those
  , ppTitleSanitize = const ""  -- Also about window's title
  , ppVisible = wrap "(" ")"  -- Non-focused (but still visible) screen
  , ppCurrent = wrap "<fc=#b8473d>[</fc><fc=#7cac7a>" "</fc><fc=#b8473d>]</fc>"-- Non-focused (but still visible) screen
  , ppOutput = hPutStrLn h
  }
myManageHook = (manageDocks <+> manageHook def) <+> namedScratchpadManageHook myScratchPads
myLayoutHook = avoidStruts $ layoutHook def


myStartupHook = do
  spawnOnce "autorandr -c"

myConfig statusPipe = def {
  -- simple stuff
    terminal           = myTerminal
  , focusFollowsMouse  = myFocusFollowsMouse
  , modMask            = myModMask
  , workspaces         = myWorkspaces

  , focusedBorderColor = myFocusedBorderColor
  , normalBorderColor  = myNormalBorderColor
  -- hooks, layouts
  , logHook            = myLogHook statusPipe
  , manageHook         = myManageHook
  , layoutHook         = myLayoutHook
  , startupHook        = myStartupHook
}

main = do
  statusPipe <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
  --statusPipes <- mapM (\i -> spawnPipe "xmobar ~/.xmonad/xmobar.hs" ++ show i " --x" ++ show i) [0..n-1]
  xmonad
    $ docks 
    $ addDescrKeys' ((myModMask, xK_F1), showKeybindings) myKeys
    $ myConfig statusPipe


myScratchPads = [ NS "sage" spawnSage findSage manageSage]
  where
    spawnSage = myTerminal ++ " --class=sage -e sage"
    findSage = className =? "sage"
    manageSage = defaultFloating
      where
        h = 0.25
        w = 0.38
        t = 0.3-h
        l = 0.95-w
    



