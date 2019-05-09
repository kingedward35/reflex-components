{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

module Frontend.Button where

import Reflex.Dom.Core
import qualified Data.Text as T
  
data Variant
  = Contained
  | Text
  | Outlined

data Color
  = Default
  | Inherit
  | Primary
  | Secondary

data Size
  = Small
  | Medium
  | Large

data Props = Props { variant  :: Variant
                   , color    :: Color
                   , disabled :: Bool
                   , href     :: String
                   , size     :: Size
                   }

myButton :: DomBuilder t m => String -> Props -> m ()
myButton str props =
  elAttr "button" ("href" =: (T.pack newHref) <>
                    "class" =: T.pack (
                      newVariant ++
                      " " ++
                      newColor ++
                      " " ++
                      newDisabled ++
                      " " ++
                      newSize
                      )
                    ) $ text (T.pack str)
  where
    newVariant  = case variant props of
                    Contained -> "contained"
                    Text -> "text"
                    Outlined -> "outlined"
    newColor    = case color props of
                    Default -> "default"
                    Inherit -> "inherit"
                    Primary -> "primary"
                    Secondary -> "secondary"
    newDisabled = case disabled props of
                    True -> "disabled"
                    False -> ""
    newHref     = case href props of
                    val -> val
    newSize     = case size props of
                    Small -> "small"
                    Medium -> "medium"
                    Large -> "large"

