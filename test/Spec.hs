module Main (main) where

import SecurityManager
import Test.HUnit
import Test.Framework.Providers.HUnit (hUnitTestToTests)
import Test.Framework (defaultMain)

main :: IO ()
main = defaultMain $ hUnitTestToTests $ TestList [
  "Matching passwords" ~:
    let actual = validatePassword "password" "password"
    in Right () ~=? actual
  ]