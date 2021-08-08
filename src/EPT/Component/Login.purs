module EPT.Component.Login (
  Props,
  login
) where

import Prelude

import Data.Foldable (for_)
import Data.Maybe (Maybe(..))
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import React.Basic.Hooks as R
import React.Basic.Hooks (Component, Hook, UseEffect, component, empty, fragment, useEffect, useEffectAlways, useState)
import React.Basic.Native (button, string, text_)
import React.Basic.Native.Events (capture_)

import Expo.Auth (launch, maybeCompleteAuthSession, useGoogleAuth)
import Firebase (auth)
import Firebase.Auth (User, googleSignIn)
import EPT.Context (Context)

type Props = {
  ctx :: Context,
  setUser :: User -> Effect Unit
}

login :: Component Props
login = component "Login" \{ ctx, setUser } -> R.do
  ensureAuthSessionCompleted
  errored /\ setErrored <- useState false
  token /\ setToken <- useState Nothing
  authCtx <- useGoogleAuth ctx.config.google (setToken <<< const <<< pure) (setErrored $ const true)
  useEffect token do
    a <- auth ctx.firebase
    for_ token \t ->
      googleSignIn a t setUser (setErrored $ const true)
    pure (pure unit)
  (pure <<< fragment) [
    button { onPress: capture_ $ launch authCtx, title: "login" },
    if errored
      then text_ [string "error occurred"]
      else empty
  ]

ensureAuthSessionCompleted :: Hook (UseEffect Unit) Unit
ensureAuthSessionCompleted = useEffectAlways do
  maybeCompleteAuthSession
  pure (pure unit)
