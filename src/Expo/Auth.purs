module Expo.Auth (
  GoogleAuthContext,
  UseGoogleAuth,
  useGoogleAuth,
  launch,
  maybeCompleteAuthSession
) where

import Prelude

import Effect (Effect)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Uncurried (EffectFn1, EffectFn3, runEffectFn1, runEffectFn3)
import React.Basic.Hooks (Hook, unsafeHook)

import Google.Config (Config)

foreign import data GoogleAuthContext :: Type
foreign import data UseGoogleAuth :: Type -> Type

--

useGoogleAuth :: Config -> (String -> Effect Unit) -> (Effect Unit) -> Hook UseGoogleAuth GoogleAuthContext
useGoogleAuth config setToken = unsafeHook <<< runEffectFn3 useGoogleAuth_ config setToken

foreign import useGoogleAuth_ :: EffectFn3 Config (String -> Effect Unit) (Effect Unit) GoogleAuthContext

--

launch :: forall m. MonadEffect m => GoogleAuthContext -> m Unit
launch = liftEffect <<< runEffectFn1 launch_

foreign import launch_ :: EffectFn1 GoogleAuthContext Unit

--

maybeCompleteAuthSession :: forall m. MonadEffect m => m Unit
maybeCompleteAuthSession = liftEffect maybeCompleteAuthSession_

foreign import maybeCompleteAuthSession_ :: Effect Unit
