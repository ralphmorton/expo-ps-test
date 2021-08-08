module EPT.Config (
  Config
) where

import Firebase.Config as Firebase
import Google.Config as Google

type Config = {
  firebase :: Firebase.Config,
  google :: Google.Config
}
