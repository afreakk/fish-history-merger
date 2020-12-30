module Main where

import Lib
import System.IO
import System.Environment
import Data.List
import Data.Containers.ListUtils

entryToUnique entry = cmd entry ++ "- paths: " ++ concat (paths entry)

main :: IO ()
main = do 
    a <- getArgs
    histories <- mapM (\x -> fmap decodeFishHistory (readFile x)) a
    putStr $ encodeFishHistory $ reverse $ nubOrdOn entryToUnique $ sortOn when $ concat histories
