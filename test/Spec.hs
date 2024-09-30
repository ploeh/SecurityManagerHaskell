module Main (main) where

import SecurityManager
import Test.HUnit
import Test.Framework.Providers.HUnit (hUnitTestToTests)
import Test.Framework (defaultMain)

main :: IO ()
main = defaultMain $ hUnitTestToTests $ TestList [
  "Matching passwords" ~: do
    pw <- ["password", "12345678", "abcdefgh"]
    let actual = validatePassword pw pw
    return $ Right () ~=? actual
  ]