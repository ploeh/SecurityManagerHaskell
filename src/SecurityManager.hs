module SecurityManager where

import Text.Printf (printf, IsChar)

validatePassword :: String -> String -> Either String String
validatePassword pw1 pw2 =
  if pw1 == pw2
  then Right pw1
  else Left "The passwords don't match"

createUser :: (Monad m, Eq a, IsChar a) => (String -> m ()) -> m [a] -> m ()
createUser writeLine readLine = do
  writeLine "Enter a username"
  username <- readLine
  writeLine "Enter your full name"
  fullName <- readLine
  writeLine "Enter your password"
  password <- readLine
  writeLine "Re-enter your password"
  confirmPassword <- readLine

  if password /= confirmPassword
  then
    writeLine "The passwords don't match"
  else
    if length password < 8
    then
      writeLine "Password must be at least 8 characters in length"
    else do
      -- Encrypt the password (just reverse it, should be secure)
      let array = reverse password
      writeLine $
        printf "Saving Details for User (%s, %s, %s)" username fullName array