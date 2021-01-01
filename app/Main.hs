{-# LANGUAGE OverloadedStrings #-}
module Main where

import Lib
import System.IO
import System.Environment
import Data.List
import Data.Containers.ListUtils
import qualified Data.Text.IO as TIO
import qualified Data.Text as T
import qualified Data.Text.Lazy as TL
import qualified Data.Text.Lazy.IO as TLIO

entryToUnique :: Entry -> TL.Text
entryToUnique entry = cmd entry <> "- paths: " <> (mconcat (paths entry))

main :: IO ()
main = do 
    a <- getArgs
    histories <- mapM (\x -> fmap decodeFishHistory (TLIO.readFile x)) a
    TLIO.putStr $ encodeFishHistory $ nubOrdOn entryToUnique $ sortOn when $ concat histories
