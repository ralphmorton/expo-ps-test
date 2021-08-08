module EPT.App (
  app
) where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Tuple.Nested ((/\))
import React.Basic.Hooks as R
import React.Basic.Hooks (Component, component, useEffectOnce, useState)
import React.Basic.Native (string, text_, view)
import React.Native.Style (Style, style)

import Firebase (auth)
import Firebase.Auth (onAuthStateChanged)
import EPT.Component.Home (home)
import EPT.Component.Login (login)
import EPT.Context (Context)

app :: Component Context
app = do
  loginComponent <- login
  homeComponent <- home
  component "EPT" \ctx -> R.do
    user /\ setUser <- useState ctx.user
    loaded /\ setLoaded <- useState false
    useEffectOnce do
      a <- auth ctx.firebase
      onAuthStateChanged a \u -> do 
        setUser (const u)
        setLoaded (const true)
    pure $
      view {
        style: styles.container,
        children: [
          case loaded, user of
            _, Just u ->
              homeComponent ctx { user = u }
            false, Nothing ->
              text_ [string "loading"]
            true, Nothing ->
              loginComponent {
                ctx,
                setUser: setUser <<< const <<< pure
              }
        ]
      }

type Styles = {
  container :: Style
}

styles :: Styles
styles = {
  container: style {
    flex: 1,
    backgroundColor: "#999",
    alignItems: "center",
    justifyContent: "center"
  }
}
