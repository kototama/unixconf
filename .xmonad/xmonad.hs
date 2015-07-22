import XMonad.Config.Xfce
import XMonad

import XMonad.Config.Azerty

import qualified Data.Map as M

import XMonad.Util.EZConfig

theManageHook = composeAll [
  className =? "Firefox" --> doShift "3:web",
  className =? "Pidgin" --> doShift "4:chat"
  ]

myKeys = [--  ((mod4Mask, xK_semicolon), sendMessage (IncMasterN (-1)))
         -- , ((mod4Mask, xK_l), sendMessage (IncMasterN 1))
         -- , ((mod4Mask, xK_f), sendMessage (IncMasterN 1))
          ((mod4Mask, xK_e), spawn "emacs")
         -- , ((mod4Mask .|. shiftMask, xK_c), spawn "emacsclient")
         ]

--       , modMask = mod1Mask -- sets to alt key
main = xmonad $ xfceConfig
       { terminal = "xfce4-terminal"
       , workspaces = ["1:xfce","2:work","3:web","4:chat","5:private","6","7","8","9","0"]
       , modMask = mod4Mask
       , borderWidth = 1 --was "3"
       , focusedBorderColor = "#4099FF"
       , normalBorderColor = "#474747"
       , manageHook = theManageHook <+> manageHook xfceConfig
       , keys = \c -> azertyKeys c `M.union` keys xfceConfig c
       } `additionalKeys` myKeys
