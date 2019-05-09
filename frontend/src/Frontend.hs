{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
module Frontend where

import qualified Data.Text as T
import Obelisk.Frontend
import Obelisk.Route
import Reflex.Dom.Core

import Common.Api
import Common.Route
import Obelisk.Generated.Static

import Frontend.Button --(myButton, Props, Variant(..), Size(..), Color(..))


frontend :: Frontend (R FrontendRoute)
frontend = Frontend
  { _frontend_head = do
      el "title" $ text "Obelisk Minimal Example with Reflex Components"
      elAttr "link" ("href" =: "../../static/css/styles.css" <>
                      "rel" =: "stylesheet" <>
                      "type" =: "text/css"
                      ) $ return ()
  , _frontend_body = do
      text "Welcome to Obelisk!"
      el "p" $ text $ T.pack commonStuff
      elAttr "img" ("src" =: static @"obelisk.jpg") blank
      elAttr "h1" ("class" =: "test") $
        el "div" $ text "This should be a child element"
      el "ul" $ do
        el "li" $ text "one"
        el "li" $ text "two"
        el "li" $ text "three"
      myButton "Click Me!!" $Props Contained Primary False "" Small
      el "div" $ do
        t <- inputElement def
        dynText $ _inputElement_value t
  }
