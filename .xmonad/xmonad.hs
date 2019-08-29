import Control.Monad (liftM2)
import qualified Data.Map as M
import System.IO
import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Grid
import XMonad.Layout.IndependentScreens
import qualified XMonad.Layout.IndependentScreens as LIS
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import qualified XMonad.StackSet as W
import XMonad.Util.Run (spawnPipe)

term = "urxvt"

base03 = "#002b36"

base02 = "#073642"

base01 = "#586e75"

base00 = "#657b83"

base0 = "#839496"

base1 = "#93a1a1"

base2 = "#eee8d5"

base3 = "#fdf6e3"

yellow = "#b58900"

orange = "#cb4b16"

red = "#dc322f"

magenta = "#d33682"

violet = "#6c71c4"

blue = "#268bd2"

cyan = "#2aa198"

green = "#859900"

ws =
  [ "1:term"
  , "2:web"
  , "3:dev"
  , "4:mail"
  , "5:irc"
  , "6:ssh"
  , "7:news"
  , "8:df"
  , "9:util"
  ]

darkSolarized = [base03, base02, base01, base00, base0, base1, base2, base3]

lightSolarized = [base3, base2, base1, base0, base00, base01, base02, base03]

taskbar = "xmobar"

myPP =
  xmobarPP
    { ppTitle = xmobarColor base00 "" . shorten 50
    , ppCurrent = xmobarColor base1 "" . wrap "< " " >"
    , ppSep = xmobarColor base1 "" " | "
    , ppUrgent = xmobarColor cyan ""
    }

bWidth = 2

myNormalBorderColor = base02

myFocusedBorderColor = yellow

xmobarCurrentWorkspaceColor = base0 --current workspace color

myModMask = mod4Mask

myLayoutHook =
  avoidStruts $
  layoutHook defaultConfig |||
  emptyBSP ||| noBorders (tabbed shrinkText tabConfig) ||| Grid

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myNumRow =
  [ xK_ampersand
  , xK_bracketleft
  , xK_braceleft
  , xK_braceright
  , xK_parenleft
  , xK_equal
  , xK_asterisk
  , xK_parenright
  , xK_plus
  ]

tabConfig =
  defaultTheme
    { activeBorderColor = "#657b83"
    , activeTextColor = "#b58900"
    , activeColor = "#002b36"
    , inactiveBorderColor = "#1c1c1c"
    , inactiveTextColor = "#b58900"
    , inactiveColor = "#002b36"
    }

xK_XF86VolumeUp = 0x1008ff13

xK_XF86VolumeDown = 0x1008ff11

xK_XF86VolumeMute = 0x1008ff12

xK_XF86MonBrightnessUp = 0x1008ff02

xK_XF86MonBrightnessDown = 0x1008ff03

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {modMask = modm}) =
  M.fromList $
  [ ((m .|. modm, k), windows $ onCurrentScreen f i)
  | (i, k) <- zip (workspaces' conf) myNumRow
  , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
  ] ++
  [ ((0, xK_Print), spawn "scrot -e 'mv $f ~/Pictures/shots")
  , ((modm, xK_f), spawn "firefox")
  , ((modm, xK_d), spawn "rofi -show run")
  , ((modm, xK_s), spawn "rofi -show ssh")
  , ((modm, xK_p), spawn "rofi -show drun")
  , ((modm, xK_o), spawn "rofi -show run")
  , ((modm, xK_m), spawn "~/.bin/themeswitch light")
  , ((modm .|. shiftMask, xK_m), spawn "~/.bin/themeswitch dark")
  , ((0, xK_XF86MonBrightnessDown), spawn "xbacklight -dec 5")
  , ((0, xK_XF86MonBrightnessUp), spawn "xbacklight -inc 5")
  , ((0, xK_XF86VolumeMute), spawn "~/.bin/mute")
  , ((0, xK_XF86VolumeUp), spawn "amixer set 'Master' 10%+")
  , ((0, xK_XF86VolumeDown), spawn "amixer set 'Master' 10%-")
  ]

myStartupHook = do
  setWMName "LG3D"
  spawn "tmux new-session -s devel -d"
  spawnOn "1:term" "urxvt"
  spawnOn "2:web" "firefox"
  spawnOn "3:dev" "urxvt -e sh -c 'tmux a -t devel'"
  spawnOn "4:mail" "urxvt -e sh -c 'tmux a -t mail'"
  spawnOn "5:irc" "urxvt -e sh -c 'tmux a -t irc'"
  spawnOn "6:ssh" "urxvt"
  spawnOn "7:news" "urxvt -e sh -c 'tmux a -t news'"
  spawnOn "8:df" "dwarf-fortress"
  spawnOn "9:comm" "firefox --new-window https://web.whatsapp.com"

settings screens =
  defaultConfig
    { terminal = term
    , modMask = myModMask
    , workspaces = withScreens screens ws
    , manageHook = manageSpawn <+> manageHook def
    , borderWidth = bWidth
    , layoutHook = myLayoutHook
    , normalBorderColor = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , keys = \c -> myKeys c `M.union` (keys defaultConfig c)
    , startupHook = myStartupHook
    , focusFollowsMouse = False
    }

main = do
  screens <- LIS.countScreens
  xmonad =<< statusBar taskbar myPP toggleStrutsKey (settings screens)
