module Firebase (
  Firebase,
  Firestore,
  Auth,
  initFirebase,
  name,
  firestore,
  auth
) where

import Prelude

import Effect.Class (class MonadEffect, liftEffect)
import Effect.Uncurried (EffectFn1, runEffectFn1)

import Firebase.Config (Config)

foreign import data Firebase :: Type
foreign import data Firestore :: Type
foreign import data Auth :: Type

--

initFirebase :: forall m. MonadEffect m => Config -> m Firebase
initFirebase = liftEffect <<< runEffectFn1 initFirebase_

foreign import initFirebase_ :: EffectFn1 Config Firebase

--

name :: forall m. MonadEffect m => Firebase -> m String
name = liftEffect <<< runEffectFn1 name_

foreign import name_ :: EffectFn1 Firebase String

--

firestore :: forall m. MonadEffect m => Firebase -> m Firestore
firestore = liftEffect <<< runEffectFn1 firestore_

foreign import firestore_ :: EffectFn1 Firebase Firestore

--

auth :: forall m. MonadEffect m => Firebase -> m Auth
auth = liftEffect <<< runEffectFn1 auth_

foreign import auth_ :: EffectFn1 Firebase Auth
