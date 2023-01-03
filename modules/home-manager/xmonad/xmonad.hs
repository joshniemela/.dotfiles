
------------------------------------------------------------------------
-- Base                                                              {{{
------------------------------------------------------------------------
import XMonad
import XMonad.Layout
import System.Directory
import System.IO as SysIO
import System.Exit
import qualified XMonad.StackSet as W

---------------------------------------------------------------------}}}
-- Actions                                                           {{{
------------------------------------------------------------------------
import XMonad.Actions.Navigation2D as Nav2d
import XMonad.Actions.CopyWindow
import XMonad.Actions.PerLayoutKeys
import XMonad.Actions.CycleWS
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves
import XMonad.Actions.WindowGo
import XMonad.Actions.WithAll

---------------------------------------------------------------------}}}
-- Data                                                              {{{
------------------------------------------------------------------------
import Data.Maybe
import qualified Data.Map as M

---------------------------------------------------------------------}}}
-- Hooks                                                             {{{
------------------------------------------------------------------------
import XMonad.Hooks.EwmhDesktops as Ewmh
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers as ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory
import XMonad.Hooks.OnPropertyChange

---------------------------------------------------------------------}}}
-- Layouts                                                           {{{
------------------------------------------------------------------------
import XMonad.Layout.SubLayouts
import XMonad.Layout.Fullscreen
import XMonad.Layout.Master
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

---------------------------------------------------------------------}}}
-- Layouts Modifier                                                  {{{
------------------------------------------------------------------------
import XMonad.Layout.MultiToggle as MT
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.WindowNavigation
import XMonad.Layout.LayoutModifier
import XMonad.Layout.SubLayouts
import XMonad.Layout.Simplest
import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Reflect
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps

---------------------------------------------------------------------}}}
-- Utilities                                                         {{{
------------------------------------------------------------------------
import qualified XMonad.Util.Hacks as Hacks
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.NamedWindows
import XMonad.Util.NamedScratchpad

---------------------------------------------------------------------}}}
-- Prompt                                                            {{{
------------------------------------------------------------------------
import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt

---------------------------------------------------------------------}}}
-- ColorScheme                                                       {{{
------------------------------------------------------------------------
import Colors.GruvboxMaterialDark

---------------------------------------------------------------------}}}
-- Theme                                                             {{{
------------------------------------------------------------------------
myTabTheme = def { fontName            = myTabFont
                 , activeColor         = colorOrange
                 , inactiveColor       = colorBg
                 , activeBorderColor   = colorOrange
                 , inactiveBorderColor = colorBg
                 , activeTextColor     = colorBg
                 , inactiveTextColor   = colorFg
                 , decoHeight          = 18
                 }

myTopBarTheme = def { fontName              = myFont
                    , inactiveBorderColor   = colorBg
                    , inactiveColor         = colorBg
                    , inactiveTextColor     = colorBg
                    , activeBorderColor     = colorOrange
                    , activeColor           = colorOrange
                    , activeTextColor       = colorOrange
                    , urgentBorderColor     = colorBgRed
                    , urgentTextColor       = colorBgRed
                    , decoHeight            = 8
                    }

myPromptTheme = def { font                  = myFont
                    , bgColor               = colorBg
                    , fgColor               = colorFg
                    , fgHLight              = colorFg
                    , bgHLight              = colorBgRed
                    , borderColor           = colorBg
                    , promptBorderWidth     = myBorderWidth
                    , height                = myPromptWidth
                    , position              = myPromptPosition
                    }

warmPromptTheme = myPromptTheme { bgColor               = colorGreen
                                , fgColor               = colorBg
                                , position              = myPromptPosition
                                }

hotPromptTheme = myPromptTheme  { bgColor               = colorBgRed
                                , fgColor               = colorBg
                                , position              = myPromptPosition
                                }

myPromptPosition = Top
myTabFont = "xft:monospace:regular:size=8:antialias=true:hinting=true"
myFont = "xft:monospace:regular:size=10:antialias=true:hinting=true"
myPromptWidth = 20
myBorderWidth = 1
myNormColor  = colorBg
myFocusColor = colorGrey0

---------------------------------------------------------------------}}}
-- Applications                                                      {{{
------------------------------------------------------------------------
myTerminal = "alacritty"
myBrowser = "brave-browser"
myLockscreen = "physlock"
myModMask = mod4Mask
myEditor = myTerminal ++ " -e nvim "
myResourceManager = myTerminal ++ " -e htop "

---------------------------------------------------------------------}}}
-- Startup                                                           {{{
------------------------------------------------------------------------

myStartupHook :: X ()
myStartupHook = do
    setWMName "LG3D"
    spawn "xsetroot -cursor_name left_ptr"
    spawn "~/.config/xmonad/audioProfile.sh"
    spawn "killall trayer"
    spawn ("sleep 2 && trayer --edge top --align right --widthtype request --SetDockType true --SetPartialStrut true --expand true  --transparent true --alpha 0 " ++ colorTrayer ++ " --height 24 --padding 3 --iconspacing 3")
    spawnOnce "conky"
    spawnOnce "bash ~/.config/conky/conky-spotify/start.sh"
    spawn "picom --experimental-backends"
    spawnOnce "plank"
    spawn "feh --bg-fill ~/.config/xmonad/Gruv-wallpapers/Gruv-houses.jpg"
  -- spawn "feh --bg-fill --randomize ~/.config/xmonad/Gruv-wallpapers/*"
    spawnOnce "numlockx"
    spawnOnce "blueman-applet"
    --spawnOnce "volumeicon"
    spawnOnce "nm-applet"
    spawnOnce "xbacklight -set 25"
    spawn "redshift -x && redshift -O 3500"

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "mocp" spawnMocp findMocp manageMocp
                , NS "calculator" spawnCalc findCalc manageCalc
                ]
  where
    spawnTerm  = myTerminal ++ " -t scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnMocp  = myTerminal ++ " -t mocp -e mocp"
    findMocp   = title =? "mocp"
    manageMocp = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnCalc  = "qalculate-gtk"
    findCalc   = className =? "Qalculate-gtk"
    manageCalc = customFloating $ W.RationalRect l t w h
               where
                 h = 0.5
                 w = 0.4
                 t = 0.75 -h
                 l = 0.70 -w

mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Single windows have gaps;
--mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True

myNav2DConf = def
    { defaultTiledNavigation    = sideNavigation
    , floatNavigation           = centerNavigation
    , screenNavigation          = lineNavigation
    , layoutNavigation          = [("Full", centerNavigation), ("ReflectX Full", centerNavigation)]
    , unmappedWindowRect        = [("Full", singleWindowRect), ("ReflectX Full", singleWindowRect)]
    }

---------------------------------------------------------------------}}}
-- Main                                                              {{{
------------------------------------------------------------------------
main :: IO ()
main = do
    xmonad
      $ Hacks.javaHack
      $ fullscreenSupportBorder
      $ ewmh
      $ withUrgencyHook NoUrgencyHook
      $ docks
      $ withNavigation2DConfig myNav2DConf
      $ withSB (statusBarProp "xmobar ~/.config/xmobar/xmobar.hs" (copiesPP (xmobarColor colorFg colorBg . wrap
               ("<box type=Bottom width=3 mb=2 color=" ++ colorBlue ++ ">") "</box>") myXmobarPP))
      $ myConfig

myConfig = def
    { manageHook         = insertPosition Below Newer <+> myManageHook
    , handleEventHook    = myHandleEventHook <+> Hacks.trayerAboveXmobarEventHook <+> Hacks.trayerPaddingXmobarEventHook
    , modMask            = myModMask
    , terminal           = myTerminal
    , focusFollowsMouse  = False
    , clickJustFocuses   = False
    , startupHook        = myStartupHook
    , layoutHook         = configurableNavigation noNavigateBorders $ withBorder myBorderWidth $ myLayoutHook
    , workspaces         = myWorkspaces
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormColor
    , focusedBorderColor = myFocusColor
    }
  `additionalKeysP`

---------------------------------------------------------------------}}}
-- Bindings                                                          {{{
------------------------------------------------------------------------
------------------------------------------------------------------------
-- Key Bindings
------------------------------------------------------------------------
    [
    -- KB_GROUP Prompts
      ("M-S-w", confirmPrompt hotPromptTheme "kill all windows in this workspace?" $ killAll)
    , ("M-S-e", confirmPrompt hotPromptTheme "Quit Xmonad?" $ io exitSuccess)
    , ("M-S-r", spawn "xmonad --recompile && xmonad --restart")
    , ("M-c", toggleCopyToAll)

    -- KB_GROUP Launch Programs
    , ("M-<Return>", spawn $ myTerminal)
    , ("M-S-<Return>", spawn (myTerminal ++ " --working-directory \"`xcwd`\""))
    , ("C-S-<Esc>", spawn $ myResourceManager)
    , ("M1-<Space>", spawn "rofi -modi drun -show drun -config ~/.config/rofi/rofidmenu.rasi")
    , ("M1-<Tab>", spawn "rofi -modi window -show window -config ~/.config/rofi/rofidmenu.rasi")
    , ("M-b", spawn $ myBrowser)
    , ("M-d", spawn "dmenu_run")

    -- KB_GROUP Workspaces
    , ("C-M1-l", shiftTo Next nonNSP >> moveTo Next nonNSP)
    , ("C-M1-h", shiftTo Prev nonNSP >> moveTo Prev nonNSP)

    -- KB_GROUP Increase/decrease spacing (gaps)
    , ("C-M1-j", incWindowSpacing 4)
    , ("C-M1-k", decWindowSpacing 4)

    -- KB_GROUP Increase/decrease windows in the master pane or the stack
    , ("M1-S-j", sendMessage $ IncMasterN (-1))
    , ("M1-S-k", sendMessage $ IncMasterN 1)

    -- KB_GROUP WM
    , ("M1-S-l", spawn $ myLockscreen)
    , ("M-q", (withFocused $ windows . W.sink) >> kill1)
    , ("M-S-q", killAll)
    , ("M-x", sendMessage $ MT.Toggle REFLECTX)
    , ("M-y", withFocused toggleFloat)
    , ("M-S-y", sinkAll)
    , ("M-<Backspace>", promote)
    , ("M-<Tab>", rotSlavesDown)
    , ("M-S-<Tab>", rotAllDown)

    -- KB_GROUP Windows navigation
    , ("M-j",   Nav2d.windowGo D False)
    , ("M-k",   Nav2d.windowGo U False)
    , ("M-h",   Nav2d.windowGo L False)
    , ("M-l",   Nav2d.windowGo R False)
    , ("M-S-j",   Nav2d.windowSwap D False)
    , ("M-S-k",   Nav2d.windowSwap U False)
    , ("M-S-h",   Nav2d.windowSwap L False)
    , ("M-S-l",   Nav2d.windowSwap R False)
    , ("M-m", windows W.focusDown)
    , ("M-S-m", windows W.focusUp)

    -- KB_GROUP Layouts
    , ("M-<Space>", sendMessage NextLayout)
    , ("M-f", (sinkAll) >> sendMessage (MT.Toggle FULL) >> sendMessage (ToggleStruts))

    -- KB_GROUP Sublayouts
    , ("M-C-h", sendMessage $ pullGroup L)
    , ("M-C-j", sendMessage $ pullGroup D)
    , ("M-C-k", sendMessage $ pullGroup U)
    , ("M-C-l", sendMessage $ pullGroup R)
    , ("M-C-m", withFocused (sendMessage . MergeAll))
    , ("M-C-u", withFocused (sendMessage . UnMerge))
    , ("M-M1-l", bindByLayout [("Tabbed", windows W.focusDown), ("", onGroup W.focusUp')])
    , ("M-M1-h", bindByLayout [("Tabbed", windows W.focusUp), ("", onGroup W.focusDown')])

    -- KB_GROUP Scratchpads
    , ("M-s t", namedScratchpadAction myScratchPads "terminal")
    , ("M-s m", namedScratchpadAction myScratchPads "mocp")
    , ("M-s c", namedScratchpadAction myScratchPads "calculator")

    -- KB_GROUP Audio
    , ("M-a h", spawn "playerctl previous")
    , ("M-a j", spawn "amixer set Master 5%- unmute")
    , ("M-a k", spawn "amixer set Master 5%+ unmute")
    , ("M-a l", spawn "playerctl next")
    , ("M-a <Space>", spawn "playerctl --play-pause")
    , ("M-a m", spawn "amixer set Master toggle")

    -- KB_GROUP Notifications
    , ("M-n <Space>", spawn "dunstctl close-all")
    , ("M-n c", spawn "dunstctl close")
    , ("M-n h", spawn "dunstctl history-pop")

    -- KB_GROUP Multimedia Keys
    , ("<XF86AudioPlay>", spawn "playerctl play-pause")
    , ("<XF86AudioPrev>", spawn "playerctl previous")
    , ("<XF86AudioNext>", spawn "playerctl next")
    -- Let volumeicon bind these keys
    , ("<XF86AudioMute>", spawn "amixer set Master toggle")
    , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
    , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
    , ("<XF86HomePage>", spawn "qutebrowser")
    , ("<XF86Search>", spawn "dm-websearch")
    , ("<XF86Mail>", runOrRaise "thunderbird" (resource =? "thunderbird"))
    , ("<XF86Calculator>", runOrRaise "qalculate-gtk" (resource =? "qalculate-gtk"))
    , ("<XF86Eject>", spawn "toggleeject")
    , ("<Print>", spawn "scrot")
    , ("M1-m", spawn "amixer -q sset Capture toggle")
    ]

------------------------------------------------------------------------
-- Mouse Bindings
------------------------------------------------------------------------
  `additionalMouseBindings`
    [ ((0, 8), (\_ -> spawn "amixer set Master 5%- unmute"))
    , ((0, 9), (\_ -> spawn "amixer set Master 5%+ unmute"))
    ]

------------------------------------------------------------------------
-- ScratchPads
------------------------------------------------------------------------
  -- The following lines are needed for named scratchpads.
      where nonNSP          = WSIs (return (\ws -> W.tag ws /= "NSP"))
            nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))

------------------------------------------------------------------------
-- Custom Bindings Helpers
------------------------------------------------------------------------
toggleFloat :: Window -> X ()
toggleFloat w =
  windows
    ( \s ->
        if M.member w (W.floating s)
          then W.sink w s
          else (W.float w (W.RationalRect (1 / 3) (1 / 4) (1 / 2) (1 / 2)) s)
    )

toggleCopyToAll = wsContainingCopies >>= \ws -> case ws of
                [] -> windows copyToAll
                _ -> killAllOtherCopies

---------------------------------------------------------------------}}}
-- workspaces                                                        {{{
------------------------------------------------------------------------
myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
--myWorkspaces = ["  01  ", "  02  ", "  03  ", "  04  ", "  05  ", "  06  ", "  07  ", "  08  ", "  09  "]
--myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

---------------------------------------------------------------------}}}
-- The Manage Hook                                                   {{{
------------------------------------------------------------------------
myManageHook :: ManageHook
myManageHook =
        manageDocks
    <+> fullscreenManageHook
    <+> composeAll
    [ checkDock                      --> doLower
    , className =? "confirm"         --> doFloat
    , className =? "confirm"         --> doFloat
    , className =? "file_progress"   --> doFloat
    , className =? "dialog"          --> doFloat
    , className =? "download"        --> doFloat
    , className =? "error"           --> doFloat
    , className =? "Gimp"            --> doFloat
    , className =? "notification"    --> doFloat
    , className =? "pinentry-gtk-2"  --> doFloat
    , className =? "splash"          --> doFloat
    , className =? "toolbar"         --> doFloat
    , className =? "zoom"            --> doFloat
    , className =? "Yad"             --> doCenterFloat
    -- , className =? "Firefox-esr"     --> doShift " 3 "
    , isFullscreen                   --> doFullFloat
    ] <+> namedScratchpadManageHook myScratchPads

---------------------------------------------------------------------------
-- X Event Actions
---------------------------------------------------------------------------
myHandleEventHook = XMonad.Layout.Fullscreen.fullscreenEventHook
                <+> Hacks.windowedFullscreenFixEventHook

myXPropertyChange = onXPropertyChange "WM_NAME" (title =? "Spotify" --> doShift " 2 ")

---------------------------------------------------------------------------
-- Custom Hook Helpers
---------------------------------------------------------------------------
forceCenterFloat :: ManageHook
forceCenterFloat = doFloatDep move
  where
    move :: W.RationalRect -> W.RationalRect
    move _ = W.RationalRect x y w h

    w, h, x, y :: Rational
    w = 1/3
    h = 1/2
    x = (1-w)/2
    y = (1-h)/2

---------------------------------------------------------------------}}}
-- The Layout Hook                                                   {{{
------------------------------------------------------------------------
myLayoutHook =   avoidStruts
               $ fullscreenFloat
               $ mouseResize
               $ mkToggle (single REFLECTX)
               $ mkToggle (single FULL)
               $ myLayouts
             where
             myLayouts =       grid
                           ||| threeColMid
                           ||| tall
                           ||| threeCol
                           ||| tabs

tall     = renamed [Replace "MasterStack"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 3
           $ Tall 1 (3/100) (1/2)
grid     = renamed [Replace "Grid"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 3
           $ Grid (16/10)
threeCol = renamed [Replace "CenteredFloatingMaster"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 3
           $ ThreeCol 1 (3/100) (1/2)
threeColMid = renamed [Replace "CenteredMaster"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 3
           $ ThreeColMid 1 (3/100) (1/2)
tabs     = renamed [Replace "Tabbed"]
           $ tabbed shrinkText myTabTheme

---------------------------------------------------------------------}}}
-- The XmobarPP                                                      {{{
------------------------------------------------------------------------
myXmobarPP :: PP
myXmobarPP = def
    { ppSep = xmobarColor colorBg "" "  "
    , ppCurrent = xmobarColor colorBg1 colorBlue . wrap ("<box type=Bottom>") "</box>"
    , ppHidden = xmobarColor colorFg colorBg1
    , ppHiddenNoWindows = xmobarColor colorBg5 colorBg1
    , ppUrgent = xmobarColor colorBgRed colorBg1 . wrap ("<box type=Bottom width=4 mb=2 color=" ++ colorBgRed ++ ">") "</box>"
    , ppLayout = xmobarColor colorFg colorBg1
    , ppTitle = xmobarColor colorFg "" . wrap
    (xmobarColor colorFg "" "[") (xmobarColor colorFg "" "]") . xmobarColor colorRed "" . shorten 11
    }

-- }}}
-- vim: ft=haskell:foldmethod=marker:expandtab:ts=4:shiftwidth=4
