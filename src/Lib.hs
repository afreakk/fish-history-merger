module Lib
    ( decodeFishHistory
    , encodeFishHistory
    , Entry (..)
    ) where
import Data.List
import Control.DeepSeq
import Control.Exception (evaluate)


data Entry = Entry
    { cmd :: String
    , when :: Int
    , paths :: [String]
    }
  
instance Show Entry where
    show (Entry {cmd=cc, when=w, paths=p}) =
        "- cmd: " ++ cc ++ "\n" ++
        "  when: " ++ show w ++ "\n" ++
            if (length p) > 0 then "  paths:\n" ++ ( unlines p ) else ""

decodeFishHistory contents = extractEntryFromStr ('\n':contents) []

encodeFishHistory str = foldl (\x y -> (show y) ++ x) "" str

extractEntryFromStr :: String -> [Entry] -> [Entry]
extractEntryFromStr ""                                    b = b
extractEntryFromStr ('\n':'-':' ':'c':'m':'d':':':' ':xs) b =
    let
        (rest, thisCmd) = untilNextCmd xs ""
        entry = strToEntry (lines ("- cmd: " ++ thisCmd)) (Entry {cmd="", when=0, paths=[]})
    in
    extractEntryFromStr rest (entry:b)

untilNextCmd :: String -> String -> (String, String)
untilNextCmd "" b = ("", b)
untilNextCmd o@(x:xs) b
  | isPrefixOf "\n- cmd: " o = (o, b)
  | otherwise                = untilNextCmd xs (b ++ [x])

strToEntry :: [String] -> Entry -> Entry
strToEntry (('-':' ':'c':'m':'d':        ':':' ':xcmd ):restOfLines) b = strToEntry restOfLines (b {cmd=xcmd         })
strToEntry ((' ':' ':'w':'h':'e':'n':    ':':' ':xwhen):restOfLines) b = strToEntry restOfLines (b {when=read xwhen  })
strToEntry ((' ':' ':'p':'a':'t':'h':'s':':':[]):restOfLines)        b = strToEntry []          (b {paths=restOfLines})
strToEntry []                                                        b = b


