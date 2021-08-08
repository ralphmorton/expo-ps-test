module Main where

import Prelude

import Effect (Effect)
import React.Basic.Hooks (JSX)

import EPT.App (app)
import EPT.Config (Config)
import EPT.Context (bootstrap)

--

main :: Config -> Effect JSX
main cfg = do
  ctx <- bootstrap cfg
  (_ $ ctx) <$> app
