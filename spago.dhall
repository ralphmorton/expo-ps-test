{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "expo-ps-test"
, dependencies = [
    "effect",
    "foldable-traversable",
    "foreign",
    "maybe",
    "nullable",
    "prelude",
    "psci-support",
    "react-basic-hooks",
    "react-basic-dom",
    "react-basic-native",
    "simple-json",
    "tuples",
    "unsafe-coerce"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
