module SecurityManager (createUser) where

import Text.Printf (printf)

createUser :: IO ()
createUser = do
  putStrLn "Enter a username"
  username <- getLine
  putStrLn "Enter your full name"
  fullName <- getLine
  putStrLn "Enter your password"
  password <- getLine
  putStrLn "Re-enter your password"
  confirmPassword <- getLine

  if password /= confirmPassword
  then
    putStrLn "The passwords don't match"
  else
    if length password < 8
    then
      putStrLn "Password must be at least 8 characters in length"
    else do
      -- Encrypt the password (just reverse it, should be secure)
      let array = reverse password
      putStrLn $
        printf "Saving Details for User (%s, %s, %s)" username fullName array