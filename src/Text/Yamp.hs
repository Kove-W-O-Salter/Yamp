
--
-- Copyright (c) Kove W. Ochre-Salter, 6th of July, 2018.
--

module Text.Yamp where
    --
    -- For the Parser data-structure.
    --
    import Data.Yamp

    --
    -- For Char predicates.
    --
    import Data.Char

    --
    -- For use of Alternative.
    --
    import Control.Applicative

    --
    -- Parse a Parser.
    --
    parse           :: Parser a -> Stream -> [a]
    parse p stream0  = case apply p stream0 of
        []            -> []
        [(x,stream1)] -> [x]

    --
    -- Parse a Parser then fail if
    -- the Stream isn't empty.
    --
    parsePedantic           :: Parser a -> Stream -> [a]
    parsePedantic p stream0  = case apply p stream0 of
        []            -> []
        [(x,stream1)] ->
            if null stream1
                then [x]
                else []

    --
    -- Check if a character in the parser
    -- stream satisfies a predicate.
    --
    satisfy   :: (Char -> Bool) -> Parser Char
    satisfy p  = Parser (\stream0 ->
        case stream0 of
            ([])   -> []
            (c:cs) ->
                if p c
                    then [(c,cs)]
                    else [])

    --
    -- Check if a Char is an ASCII letter.
    --
    isAsciiLetter   :: Char -> Bool
    isAsciiLetter c  = isAscii c && isLetter c

    --
    -- Check if a Char is an ASCII symbol.
    --
    isAsciiSymbol   :: Char -> Bool
    isAsciiSymbol c  = isAscii c && not (isLetter c)

    --
    -- Match a character.
    --
    matchChar   :: Char -> Parser Char
    matchChar c  = satisfy (==c)

    --
    -- Match one of a list of characters.
    --
    oneOf        :: [Char] -> Parser Char
    oneOf []      = empty
    oneOf (c:cs)  = matchChar c <|> oneOf cs

    --
    -- Match a lower-case letter.
    --
    lower :: Parser Char
    lower  = satisfy isLower

    --
    -- Match a upper-case letter.
    --
    upper :: Parser Char
    upper  = satisfy isUpper

    --
    -- Match a letter.
    --
    letter :: Parser Char
    letter  = satisfy isLetter

    --
    -- Match an Ascii character.
    --
    ascii :: Parser Char
    ascii  = satisfy isAscii

    --
    -- Match a lower-case Ascii letter.
    --
    asciiLower :: Parser Char
    asciiLower  = satisfy isAsciiLower

    --
    -- Match an upper-case Ascii letter.
    --
    asciiUpper :: Parser Char
    asciiUpper  = satisfy isAsciiUpper

    --
    -- Match an Ascii letter.
    --
    asciiLetter :: Parser Char
    asciiLetter  = satisfy isAsciiLetter

    --
    -- Match an Ascii symbol.
    --
    asciiSymbol :: Parser Char
    asciiSymbol  = satisfy isAsciiSymbol

    --
    -- Match white-space character.
    --
    space :: Parser Char
    space  = satisfy isSpace

    --
    -- Match zero or more white-spaces.
    --
    spaces :: Parser String
    spaces  = many space

    --
    -- Match one or more white-space.
    --
    spaces1 :: Parser String
    spaces1  = some space

    --
    -- Match a String.
    --
    matchString        :: String -> Parser String
    matchString []      = empty
    matchString [c]     = do c' <- matchChar c; return [c']
    matchString (c:cs)  = do c' <- matchChar c
                             cs' <- matchString cs
                             return (c':cs')

    --
    -- Match one of a list of Strings.
    --
    oneOfS        :: [String] -> Parser String
    oneOfS []      = empty
    oneOfS (s:ss)  = matchString s <|> oneOfS ss

    --
    -- Match a Parser between two other Parsers.
    --
    sandwhich              :: Parser a -> Parser a -> Parser b -> Parser b
    sandwhich open close p  = do open
                                 p' <- p
                                 close
                                 return p
