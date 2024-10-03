module Main (main) where

import Control.Monad.Trans.State.Lazy
import SecurityManager
import Test.HUnit ((~:), (~=?), Test(TestList))
import Test.Framework.Providers.HUnit (hUnitTestToTests)
import Test.Framework (defaultMain)
import Data.Bifunctor

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
  ,
  "Validate long password" ~: do
    pw <- ["12345678", "123456789", "abcdefghij", "elevenchars"]
    let actual = validatePassword pw
    return $ Right pw ~=? actual
  ,
  "Happy path" ~: flip evalState
      (["just.inhale", "Justin Hale", "12345678", "12345678"], []) $ do
    let writeLine x = modify (second (++ [x]))
    let readLine = state (\(i, o) -> (head i, (tail i, o)))
    let encrypt = reverse

    createUser writeLine readLine encrypt

    actual <- gets snd
    let expected = [
          "Enter a username",
          "Enter your full name",
          "Enter your password",
          "Re-enter your password",
          "Saving Details for User (just.inhale, Justin Hale, 87654321)"]
    return $ expected ~=? actual
  ,
  "Mismatched passwords" ~: flip evalState
      (["i.lean.right", "Ilene Wright", "password", "Password"], []) $ do
    let writeLine x = modify (second (++ [x]))
    let readLine = state (\(i, o) -> (head i, (tail i, o)))
    let encrypt = reverse

    createUser writeLine readLine encrypt

    actual <- gets snd
    let expected = [
          "Enter a username",
          "Enter your full name",
          "Enter your password",
          "Re-enter your password",
          "The passwords don't match"]
    return $ expected ~=? actual
  ]