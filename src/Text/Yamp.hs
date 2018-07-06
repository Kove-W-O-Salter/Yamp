
--
-- Copyright (c) Kove W. Ochre-Salter, 6th of July, 2018.
--

module Text.Yamp where
    --
    -- For the Parser data-structure.
    --
    import Data.Yamp

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
    -- Check if a character in the parser stream satisfies a predicate.
    --
    satisfy   :: (Char -> Bool) -> Parser Char
    satisfy p  = Parser (\stream0 ->
        case stream0 of
            ([])   -> []
            (c:cs) ->
                if p c
                    then [(c,cs)]
                    else [])
