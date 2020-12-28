module Main where

import Lib
import System.IO
import System.Environment
import Data.List

fishDeduplicate [] o = reverse o 
fishDeduplicate (x:[]) o = reverse (x:o) 
fishDeduplicate (x:y:xs) o 
  | x /= y = fishDeduplicate (y:xs) (x:o)
  | otherwise = fishDeduplicate (y:xs) o

main :: IO ()
main = do 
    a <- getArgs
    histories <- mapM (\x -> fmap decodeFishHistory (readFile x)) a
    let mergedHistories = concat histories
    let mergedHistoriesSorted = sortOn ((\x -> x*(-1)) . when) mergedHistories
    let mergedHistoriesDeduplicated = fishDeduplicate mergedHistoriesSorted []
    let encodedFishHistory = encodeFishHistory mergedHistoriesDeduplicated
    putStr encodedFishHistory
