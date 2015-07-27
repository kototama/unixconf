import qualified Data.Map as M
import System.Posix.Unistd (getSystemID, nodeName)

import XMonad.Config.Xfce
import XMonad
import XMonad.Config.Azerty
import XMonad.Util.EZConfig


myManageHook = composeAll [
  className =? "Galculator" --> doShift "2:programming",
  className =? "Emacs" --> doShift "2:programming",
  className =? "Firefox" --> doShift "3:web",
  className =? "Pidgin" --> doShift "4:chat",
  className =? "Tor Browser" --> doShift "5:private"
  ]

myKeys = [--  ((mod4Mask, xK_semicolon), sendMessage (IncMasterN (-1)))
         -- , ((mod4Mask, xK_l), sendMessage (IncMasterN 1))
         -- , ((mod4Mask, xK_f), sendMessage (IncMasterN 1))
          ((mod4Mask, xK_e), spawn "emacs")
         -- , ((mod4Mask .|. shiftMask, xK_e), spawn "galculator")
         ]

myConfig hostname = xfceConfig { terminal = "xfce4-terminal"
                      , workspaces = ["1:xfce","2:programming","3:web","4:chat","5:private","6","7","8","9","0"]
                      , modMask = mod4Mask
                      , borderWidth = 1
                      , focusedBorderColor = "#4099FF"
                      , normalBorderColor = "#474747"
                      , manageHook = theManageHook
                      , keys = \c -> azertyKeys c `M.union` keys xfceConfig c
                      } `additionalKeys` myKeys
                    where theManageHook = case hostname of
                            "adorno" -> myManageHook <+> manageHook xfceConfig
                            _ -> manageHook xfceConfig
           --       , modMask = mod1Mask -- sets to alt key

getHostName :: IO String
getHostName = fmap nodeName getSystemID

main = do
  hostname <- getHostName
  xmonad $ (myConfig hostname)
