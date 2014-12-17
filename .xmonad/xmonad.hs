import XMonad.Config.Xfce
import XMonad

import XMonad.Config.Azerty

import qualified Data.Map as M
 
main = xmonad xfceConfig
       { terminal = "xfce4-terminal"
       , modMask = mod1Mask -- sets to alt key
--       , modMask = mod4Mask
       , borderWidth = 1 --was "3"
       , focusedBorderColor = "#4099FF"
       , normalBorderColor = "#474747"
       , keys = \c -> azertyKeys c `M.union` keys xfceConfig c
       }
