module Lib
    ( decodeFishHistory
    , encodeFishHistory
    , Entry (..)
    ) where
import Data.List
import Data.Word


data Entry = Entry
    { cmd :: String
    , when :: Word
    , paths :: String
    }

emptyEntry :: Entry
emptyEntry = Entry {cmd=mempty, when=0, paths=mempty}

instance Show Entry where
    show (Entry {cmd=cc, when=w, paths=p}) =
        "- cmd: " ++ cc ++ 
        "\n  when: " ++ show w ++
            if null p then "\n" else "\n  paths:\n" ++ p

decodeFishHistory :: String -> [Entry]
decodeFishHistory contents = extractEntryFromStr ('\n':contents) []

encodeFishHistory :: [Entry] -> String
encodeFishHistory = foldr (\x y -> show x ++ y) ""

extractEntryFromStr :: String -> [Entry] -> [Entry]
extractEntryFromStr ('\n':'-':' ':'c':'m':'d':':':' ':xs) b =
    let
        (rest, thisCmd) = untilNextCmd xs ""
        entry = strToEntry (lines thisCmd) emptyEntry
    in
    extractEntryFromStr rest (entry:b)
extractEntryFromStr ""                                    b = b

untilNextCmd :: String -> String -> (String, String)
untilNextCmd "" b = ("", reverse b)
untilNextCmd o@(x:xs) b
  | isPrefixOf "\n- cmd: " o = (o, reverse b)
  | otherwise                = untilNextCmd xs (x:b)

strToEntry :: [String] -> Entry -> Entry
strToEntry ((' ':' ':'w':'h':'e':'n':    ':':' ':xwhen):restOfLines) b = strToEntry restOfLines (b {when=read xwhen          })
strToEntry ((' ':' ':'p':'a':'t':'h':'s':':':[]):restOfLines)        b = strToEntry []          (b {paths=unlines restOfLines})
strToEntry (xcmd:restOfLines)                                        b = strToEntry restOfLines (b {cmd=xcmd                 })
strToEntry []                                                        b = b


