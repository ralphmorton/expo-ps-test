module Firebase.Auth (
  User',
  User,
  PersistenceMode(..),
  googleSignIn,
  setPersistenceMode,
  currentUser,
  onAuthStateChanged
) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn4, runEffectFn1, runEffectFn2, runEffectFn4)
import Foreign (Foreign)

import Firebase (Auth)

type User' f = {
  uid :: String,
  displayName :: f String,
  email :: f String,
  photoURL :: f String
}

type User = User' Maybe

--

data PersistenceMode
  = None
  | Session
  | Local

--

googleSignIn :: forall m. MonadEffect m => Auth -> String -> (User -> Effect Unit) -> (Effect Unit) -> m Unit
googleSignIn auth token setUser setError = liftEffect $ runEffectFn4 googleSignIn_ auth token (setUser <<< toUser) setError

foreign import googleSignIn_ :: EffectFn4 Auth String (User' Nullable -> Effect Unit) (Effect Unit) Unit

--

setPersistenceMode :: forall m. MonadEffect m => Auth -> PersistenceMode -> m Unit
setPersistenceMode auth = liftEffect <<< runEffectFn2 setPersistenceMode_ auth <<< toPersistenceMode

foreign import setPersistenceMode_ :: EffectFn2 Auth Foreign Unit

foreign import persistenceModeNone :: Foreign
foreign import persistenceModeSession :: Foreign
foreign import persistenceModeLocal :: Foreign

toPersistenceMode :: PersistenceMode -> Foreign
toPersistenceMode None =
  persistenceModeNone
toPersistenceMode Session =
  persistenceModeSession
toPersistenceMode Local =
  persistenceModeLocal

--

currentUser :: forall m. MonadEffect m => Auth -> m (Maybe User)
currentUser = liftEffect <<< map (map toUser <<< toMaybe) <<< runEffectFn1 currentUser_

foreign import currentUser_ :: EffectFn1 Auth (Nullable (User' Nullable))

--

onAuthStateChanged :: forall m. MonadEffect m => Auth -> (Maybe User -> Effect Unit) -> m (Effect Unit)
onAuthStateChanged auth setUser = liftEffect $ runEffectFn2 onAuthStateChanged_ auth (setUser <<< map toUser <<< toMaybe)

foreign import onAuthStateChanged_ :: EffectFn2 Auth (Nullable (User' Nullable) -> Effect Unit) (Effect Unit)

--

toUser :: User' Nullable -> User
toUser u =
  u {
    displayName = toMaybe u.displayName,
    email = toMaybe u.email,
    photoURL = toMaybe u.photoURL
  }
