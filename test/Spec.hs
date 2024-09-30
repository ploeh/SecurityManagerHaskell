module Main (main) where

import SecurityManager
import Test.HUnit
import Test.Framework.Providers.HUnit (hUnitTestToTests)
import Test.Framework (defaultMain)

main :: IO ()
main = defaultMain $ hUnitTestToTests $ TestList [
  "Matching passwords" ~: do
    pw <- ["password", "12345678", "abcdefgh"]
    let actual = comparePasswords pw pw
    return $ Right pw ~=? actual
  ,
  "Non-matching passwords" ~: do
    (pw1, pw2) <-
      [
        ("password", "PASSWORD"),
        ("12345678", "12345677"),
        ("abcdefgh", "bacdefgh"),
        ("aaa", "bbb")
      ]
    let actual = comparePasswords pw1 pw2
    return $ Left "The passwords don't match" ~=? actual
  ]