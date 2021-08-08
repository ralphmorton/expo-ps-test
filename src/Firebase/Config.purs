module Firebase.Config (
  Config
) where

type Config = {
  apiKey :: String,
  authDomain :: String,
  projectId :: String,
  storageBucket :: String,
  messagingSenderId :: String,
  appId :: String
}
