module Main (main) where

import SecurityManager (createUser)

main :: IO ()
main = createUser putStrLn getLine
