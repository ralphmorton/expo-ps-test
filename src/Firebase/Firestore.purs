module Firebase.Firestore(
  Collection,
  Doc,
  collection,
  onSnapshot
) where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Traversable (traverse)
import Effect (Effect)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Uncurried (EffectFn2, runEffectFn2)
import Foreign (Foreign)
import Simple.JSON (class ReadForeign, read_)

import Firebase (Firestore)

foreign import data Collection :: Type

type Doc a = {
  id :: String,
  body :: a
}

--

collection :: forall m. MonadEffect m => Firestore -> String -> m Collection
collection store = liftEffect <<< runEffectFn2 collection_ store

foreign import collection_ :: EffectFn2 Firestore String Collection

--

onSnapshot :: forall m a. MonadEffect m => ReadForeign a => Collection -> (Array (Doc a) -> Effect Unit) -> m (Effect Unit)
onSnapshot coll f = liftEffect $ runEffectFn2 onSnapshot_ coll callback
  where
  callback fx = case traverse read_ fx of
    Just rx -> f rx
    Nothing -> pure unit -- TODO: what?

foreign import onSnapshot_ :: EffectFn2 Collection (Array Foreign -> Effect Unit) (Effect Unit)
