{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Frontend where

import qualified Data.Text as T
import Obelisk.Frontend
import Obelisk.Route
import Reflex.Dom.Core

import Common.Api
import Common.Route
import Obelisk.Generated.Static

import Frontend.Button 

-- dynButton :: MonadWidget t m => m ()
-- dynButton = el "div" $ do
--   el "h2" $ text "Button enabled / disabled"
--   cb <- el "label" $ do
--     cb1 <- checkbox True def
--     text "Enable or Disable the button"
--     return cb1
--   el "p" blank
--   counter :: Dynamic t Int <- count =<< disaButton (_checkbox_value cb) "Click me"
--   el "p" blank
--   display counter

-- disaButton :: MonadWidget t m
--             => Dynamic t Bool -- ^ enable or disable button
--             -> T.Text         -- ^ Label
--             -> m (Event t ())
-- disaButton enabled label = do
--     let attrs = ffor enabled $ \e -> monoidGuard (not e) $ "disabled" =: "disabled"
--     (btn, _) <- elDynAttr' "button" attrs $ text label
--     pure $ domEvent Click btn

-- monoidGuard :: Monoid a => Bool -> a -> a
-- monoidGuard p a = if p then a else mempty

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
      myButton "Click Me!!" $ Props Contained Primary False "" Small
      el "div" $ do
        t <- inputElement def
        dynText $ _inputElement_value t
  }
