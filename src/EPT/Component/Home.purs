module EPT.Component.Home (
  home
) where

import Prelude

import Data.Tuple.Nested ((/\))
import React.Basic.Hooks as R
import React.Basic.Hooks (Component, component, useEffectOnce, useState)
import React.Basic.Native (string, text_)

import Firebase (firestore)
import Firebase.Firestore (Doc, collection, onSnapshot)
import EPT.Context (AuthedContext)

type Foo = {
  foo :: String
}

home :: Component AuthedContext
home = component "Home" \ctx -> R.do
  docs /\ setDocs <- useState ([] :: Array (Doc Foo))
  useEffectOnce do
    db <- firestore ctx.firebase
    coll <- collection db "foos"
    onSnapshot coll (setDocs <<< const)
  pure <<< text_ $ foo <$> docs
  where
  foo = string <<< (_ <> " ") <<< _.body.foo
