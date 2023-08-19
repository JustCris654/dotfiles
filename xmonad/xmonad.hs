import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Magnifier
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab

myLayout = tiled ||| threeCol
  where
    threeCol = renamed [Replace "ThreeCol"] $ magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled = Tall nmaster delta ratio
    nmaster = 1 -- number of windows in the master pane
    ratio = 1 / 2 -- default proportion of screen occupied by master pane
    delta = 3 / 100 -- % of screen to increment by when resizing

myXmobarPP :: PP
myXmobarPP =
  def
    { ppSep = red " • ",
      ppTitleSanitize = xmobarStrip,
      ppCurrent = wrap " " "" . xmobarBorder "Top" "#c4746e" 2,
      ppHidden = white . wrap " " "",
      ppHiddenNoWindows = lowWhite . wrap " " "",
      ppUrgent = red . wrap (yellow "!") (yellow "!"),
      ppOrder = \[ws, l, _, wins] -> [ws, l, wins],
      ppExtras = [logTitles formatFocused formatUnFocused]
    }
  where
    formatFocused = wrap (white "[ ") (white " ]") . red . ppWindow
    formatUnFocused = wrap (white "[ ") (white " ]") . blue . ppWindow

    -- windows should have some title that does not exceed a sane length
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta = xmobarColor "#a292a3" ""
    blue = xmobarColor "#8ba4b0" ""
    white = xmobarColor "#C8C093" ""
    yellow = xmobarColor "#c4b28a" ""
    red = xmobarColor "#c4746e" ""
    lowWhite = xmobarColor "#bbbbbb" ""
    green = xmobarColor "#8a9a7b" ""

main :: IO ()
main =
  xmonad
    . ewmhFullscreen
    . ewmh
    . withEasySB (statusBarProp "xmobar /home/justcris/.config/xmonad/xmobarrc" (pure myXmobarPP)) toggleStrutsKey
    $ myConfig
  where
    toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
    toggleStrutsKey XConfig {modMask = m} = (m, xK_b)

myConfig =
  def
    { modMask = mod4Mask, --bind Mod to super key
      layoutHook = spacingWithEdge 4 $ myLayout
    }
    `additionalKeysP` [ ("M-w", spawn "google-chrome-stable"),
                        ("M-e", spawn "emacsclient -c"),
                        ("M-<Return>", spawn "alacritty"),
                        ("M-r", spawn "rofi -combi-modi window,drun,ssh -show combi")
                      ]
