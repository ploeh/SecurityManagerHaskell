module SecurityManager where

import Text.Printf (printf, PrintfArg)

comparePasswords :: String -> String -> Either String String
comparePasswords pw1 pw2 =
  if pw1 == pw2
  then Right pw1
  else Left "The passwords don't match"

validatePassword :: String -> Either String String
validatePassword pw =
  if length pw < 8
  then Left "Password must be at least 8 characters in length"
  else Right pw

createUser :: (Monad m, PrintfArg a)
           => (String -> m ()) -> m String -> (String -> a) -> m ()
createUser writeLine readLine encrypt = do
  writeLine "Enter a username"
  username <- readLine
  writeLine "Enter your full name"
  fullName <- readLine
  writeLine "Enter your password"
  password <- readLine
  writeLine "Re-enter your password"
  confirmPassword <- readLine

  writeLine $ either
    id
    (printf "Saving Details for User (%s, %s, %s)" username fullName . encrypt)
    (validatePassword =<< comparePasswords password confirmPassword)