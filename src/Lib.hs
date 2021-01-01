{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( decodeFishHistory
    , encodeFishHistory
    , Entry (..)
    ) where
import Data.List
import qualified Data.Text as T
import qualified Data.Text.Read as TR
import qualified Data.Text.Lazy.Builder as B
import qualified Data.Text.Lazy as TL


data Entry = Entry
    { cmd :: TL.Text
    , when :: TL.Text
    , paths :: [TL.Text]
    }
  
entryToStr :: Entry -> B.Builder
entryToStr (Entry {cmd=cc, when=w, paths=p}) =
    B.fromLazyText "- cmd: " <> B.fromLazyText cc <> B.singleton '\n' <>
    B.fromLazyText "  when: " <> B.fromLazyText w <> B.singleton '\n' <>
    if (null p) then
        B.fromLazyText "  paths:\n" <> B.fromLazyText (TL.unlines p) else mempty

encodeFishHistory :: [Entry] -> TL.Text
encodeFishHistory = B.toLazyText . foldr (\x y -> y <> entryToStr x) mempty

decodeFishHistory contents = extractEntryFromStr (TL.cons '\n' contents) []

extractEntryFromStr :: TL.Text -> [Entry] -> [Entry]
extractEntryFromStr ""  listOfEntries = listOfEntries
extractEntryFromStr str listOfEntries = extractEntryFromStr rest (entry:listOfEntries) where
    (rest, thisCmd) = untilNextCmd (TL.tail str) ""
    entry = strToEntry (TL.lines thisCmd) (Entry {cmd="", when="", paths=[]})

untilNextCmd :: TL.Text -> TL.Text -> (TL.Text, TL.Text)
untilNextCmd "" thisCmd = ("", TL.reverse thisCmd)
untilNextCmd rest thisCmd
  | TL.isPrefixOf "\n- cmd: " rest = (rest, TL.reverse thisCmd)
  | otherwise                     = untilNextCmd tail (TL.cons head thisCmd)
    where Just (head, tail) = TL.uncons rest

strToEntry :: [TL.Text] -> Entry -> Entry
strToEntry [] entry = entry
strToEntry (thisLine:restOfLines) entry
  | TL.isPrefixOf "- cmd: "   thisLine = strToEntry restOfLines (entry {cmd=TL.drop 7 thisLine})
  | TL.isPrefixOf "  when: "  thisLine = strToEntry restOfLines (entry {when=TL.drop 8 thisLine})
  | TL.isPrefixOf "  paths:"  thisLine = strToEntry []          (entry {paths=restOfLines})
  | otherwise                          = entry
