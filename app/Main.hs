module Main where

import Lib
import System.IO
import System.Environment
import Data.List

main :: IO ()
main = do 
    a <- getArgs
    histories <- mapM (\x -> fmap decodeFishHistory (readFile x)) a
    let mergedHistories = concat histories
    let mergedHistoriesSorted = sortOn ((\x -> x*(-1)) . when) mergedHistories
    -- TODO depuplicate
    let encodedFishHistory = encodeFishHistory mergedHistoriesSorted
    putStr encodedFishHistory
