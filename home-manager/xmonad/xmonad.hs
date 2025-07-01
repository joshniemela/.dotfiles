import Control.Monad (forM_)
import Data.List (isPrefixOf)
import qualified Data.Map as M
import System.Directory
import System.IO
import XMonad
import XMonad.Actions.WindowGo
import XMonad.Actions.WithAll
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Fullscreen
import qualified XMonad.Layout.ToggleLayouts as T (ToggleLayout (Toggle), toggleLayouts)
import XMonad.Prompt.RunOrRaise
import qualified XMonad.StackSet as W
import qualified XMonad.Util.ExtensibleState as XS
import XMonad.Util.NamedActions
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

myTerminal = "kitty"

myBrowser = "firefox"

myFocusFollowsMouse = True

myPersonalWorkspaces = map (\ws -> "p" ++ show ws) [1 .. 9]
myWorkWorkspaces = map (\ws -> "w" ++ show ws) [1 .. 9]

myWorkspaces = myPersonalWorkspaces ++ myWorkWorkspaces

myFocusedBorderColor = "#D16328"

myNormalBorderColor = "#402F65"

-- Keybindings

myModMask = mod1Mask -- 3 is right alt and 4 is super

myKeys :: XConfig Layout -> [((KeyMask, KeySym), NamedAction)]
myKeys c =
    let subKeys str ks = subtitle str : ks
     in subKeys
            "Essentials"
            [ ((myModMask, xK_q), addName "Recompile/restart XMonad" $ spawn "xmonad --recompile && pkill xmobar && xmonad --restart")
            , ((myModMask .|. shiftMask, xK_Return), addName "Open terminal" $ spawn myTerminal)
            , ((myModMask .|. shiftMask, xK_c), addName "Close window" kill)
            , ((myModMask, xK_p), addName "Open dmenu" $ spawn "dmenu_run -sb '#402F65'")
            , ((myModMask .|. shiftMask, xK_p), addName "Open passmenu" $ spawn "passmenu -sb '#D16328'")
            ]
            ++ subtitle "Switching workspaces"
            :
            -- mod-[1..9] %! Switch to workspace N
            -- mod-shift-[1..9] %! Move client to workspace N
            [ ((m .|. myModMask, k), addName (n ++ show i) $ handleWorkspaceKey i f)
            | (f, m, n) <-
                [ (W.greedyView, 0, "Switch to workspace ")
                , (W.shift, shiftMask, "Move client to workspace ")
                ]
            , (i, k) <- zip [1 .. 9] [xK_1 .. xK_9]
            ]
            ++ [
                   ( (myModMask, xK_z)
                   , addName "Swap workspace sets" $ do
                        currentSet <- XS.get
                        let newSet = switch currentSet
                        XS.put newSet

                        screens <- gets (W.screens . windowset)

                        let targetWs = case newSet of
                                Personal -> myPersonalWorkspaces
                                Work -> myWorkWorkspaces

                            workspaces = take (length screens) targetWs

                        -- For each screen, focus it and greedyView its new workspace
                        forM_ (zip screens workspaces) $ \(s, ws) -> do
                            windows (W.view (W.tag (W.workspace s))) -- focus the screen
                            windows (W.greedyView ws)
                   )
               ,
                   ( (myModMask .|. shiftMask, xK_z)
                   , addName "Move client to next workspace set" $ do
                        currentSet <- XS.get
                        -- The this is either p1 or w1, it is the opposite of our current set
                        let newWs = case currentSet of
                                Personal -> "w1"
                                Work -> "p1"

                        windows (W.shift newWs)
                   )
               ]
            ++ subtitle "Switching screens"
            :
            -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
            -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
            [ ((m .|. myModMask, key), addName (n ++ show sc) $ screenWorkspace sc >>= flip whenJust (windows . f))
            | (f, m, n) <- [(W.view, 0, "Switch to screen number "), (W.shift, shiftMask, "Move client to screen number ")]
            , (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..]
            ]
            ++ subKeys
                "Changing layouts"
                [ ((myModMask, xK_space), sendMessage' NextLayout)
                , ((myModMask .|. shiftMask, xK_space), addName "Reset the layout" $ setLayout $ XMonad.layoutHook c)
                ]
            ++ subKeys
                "Resizing"
                [ ((myModMask, xK_h), sendMessage' Shrink)
                , ((myModMask, xK_l), sendMessage' Expand)
                ]
            ++ subKeys
                "Focus"
                [ ((myModMask, xK_Tab), addName "Focus down" $ windows W.focusDown)
                , ((myModMask .|. shiftMask, xK_Tab), addName "Focus up" $ windows W.focusUp)
                , ((myModMask, xK_j), addName "Focus down" $ windows W.focusDown)
                , ((myModMask, xK_k), addName "Focus up" $ windows W.focusUp)
                , ((myModMask, xK_m), addName "Focus the master" $ windows W.focusMaster)
                ]
            ++ subKeys
                "Modifying window order"
                [ ((myModMask, xK_Return), addName "Swap with the master" $ windows W.swapMaster)
                , ((myModMask .|. shiftMask, xK_j), addName "Swap down" $ windows W.swapDown)
                , ((myModMask .|. shiftMask, xK_k), addName "Swap up" $ windows W.swapUp)
                ]
            ++ subKeys
                "Floating windows"
                [ ((myModMask, xK_t), addName "Push focused floating to tiled" $ withFocused $ windows . W.sink)
                , ((myModMask .|. shiftMask, xK_t), addName "Push all floating to tiled" sinkAll)
                , ((myModMask, xK_f), addName "Push focused to floating" $ sendMessage $ T.Toggle "floats")
                ]
            ++ subKeys
                "Other stuff"
                [ ((noModMask, xK_Print), addName "Take screenshot" $ spawn "flameshot gui")
                ]
            ++ subKeys
                "Scratchpads"
                [ ((myModMask, xK_Return), addName "Open terminal" $ namedScratchpadAction myScratchPads "term")
                ]

showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
    h <- spawnPipe "zenity --text-info --font=terminus"
    hPutStr h (unlines $ showKm x)
    hClose h
    return ()

myLogHook h = do
    state <- XS.get
    let filterWorkspaceByState = filterByPrefix (prefix state)

    dynamicLogWithPP $
        def
            { ppLayout = wrap "(<fc=#e4b63c>" "</fc>)"
            , ppHidden = filterWorkspaceByState id
            , -- , ppSort = getSortByXineramaRule  -- Sort left/right screens on the left, non-empty workspaces after those
              ppTitleSanitize = const "" -- Also about window's title
            , ppVisible = filterWorkspaceByState (wrap "(" ")") -- Non-focused (but still visible) screen
            , ppCurrent = wrap "<fc=#b8473d>[</fc><fc=#7cac7a>" "</fc><fc=#b8473d>]</fc>" -- Focused screen
            , ppOutput = hPutStrLn h
            }

myManageHook = (manageDocks <+> manageHook def) <+> namedScratchpadManageHook myScratchPads

myLayoutHook = avoidStruts $ layoutHook def

myStartupHook = do
    spawnOnce "autorandr -c"

myConfig statusPipe =
    def
        { -- simple stuff
          terminal = myTerminal
        , focusFollowsMouse = myFocusFollowsMouse
        , modMask = myModMask
        , workspaces = myWorkspaces
        , focusedBorderColor = myFocusedBorderColor
        , normalBorderColor = myNormalBorderColor
        , -- hooks, layouts
          logHook = myLogHook statusPipe
        , manageHook = myManageHook
        , layoutHook = myLayoutHook
        , startupHook = myStartupHook
        }

main = do
    statusPipe <- spawnPipe "xmobar -x 0 ~/.xmonad/xmobar.hs"
    xmonad $
        docks $
            ewmhFullscreen $
                ewmh $
                    addDescrKeys' ((myModMask, xK_F1), showKeybindings) myKeys $
                        myConfig statusPipe

myScratchPads =
    [ NS "term" spawnTerm findTerm manageTerm
    ]
  where
    spawnTerm = myTerminal ++ " --class=term"
    findTerm = className =? "term"
    manageTerm = defaultFloating

data WorkspacesType = Personal | Work deriving (Show, Read, Eq)

switch :: WorkspacesType -> WorkspacesType
switch Personal = Work
switch Work = Personal

prefix :: WorkspacesType -> String
prefix Personal = "p"
prefix Work = "w"

filterByPrefix :: String -> (String -> String) -> String -> String
filterByPrefix prefix wrapFunc ws =
    if prefix `isPrefixOf` ws
        then wrapFunc ws
        else ""

instance ExtensionClass WorkspacesType where
    initialValue = Personal
    extensionType = PersistentExtension

handleWorkspaceKey :: Int -> (WorkspaceId -> WindowSet -> WindowSet) -> X ()
handleWorkspaceKey i action = do
    currentSet <- XS.get
    let workspaces = case currentSet of
            Personal -> myPersonalWorkspaces
            Work -> myWorkWorkspaces
    let targetWs = workspaces !! (i - 1)
    windows $ action targetWs
