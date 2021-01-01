module Main where

import Lib
import System.IO
import System.Environment
import Data.List
import Data.Containers.ListUtils
import Data.Functor
import Control.Arrow

entryToUnique :: Entry -> String
entryToUnique entry = cmd entry ++ "- paths: " ++ paths entry

readNdecode :: String -> IO [Entry]
readNdecode a = (readFile a) <&> decodeFishHistory

main :: IO ()
main = getArgs >>= mapM readNdecode <&> (concat >>> sortOn when >>> nubOrdOn entryToUnique >>> encodeFishHistory) >>= putStr
