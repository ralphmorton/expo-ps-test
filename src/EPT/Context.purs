module EPT.Context (
  Context',
  Context,
  AuthedContext,
  bootstrap
) where

import Prelude

import Data.Maybe (Maybe)
import Effect.Class (class MonadEffect)

import EPT.Config (Config)
import Firebase (Firebase, auth, initFirebase)
import Firebase.Auth (User, currentUser)

type Context' u = {
  config :: Config,
  firebase :: Firebase,
  user :: u
}

type Context = Context' (Maybe User)
type AuthedContext = Context' User

bootstrap :: forall m. MonadEffect m => Config -> m Context
bootstrap config = do
  firebase <- initFirebase config.firebase
  user <- currentUser =<< auth firebase
  pure {
    config,
    firebase,
    user
  }
