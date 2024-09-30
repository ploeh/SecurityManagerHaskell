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
  ,
  "Validate short password" ~: do
    pw <- ["", "1", "12", "abc", "1234", "gtrex", "123456", "1234567"]
    let actual = validatePassword pw
    return $ Left "Password must be at least 8 characters in length" ~=? actual
  ]