
--
-- Copyright (c) Kove W. Ochre-Salter, 5th of July, 2018.
--

module Data.Yamp where
    --
    -- For Alternative.
    --
    import Control.Applicative

    --
    -- The Stream which a Parser
    -- parses.
    --
    type Stream
        = String

    --
    -- The Parser type, which is just
    -- a state transformer where the
    -- state is a Stream.
    --
    newtype Parser a =
        Parser (Stream -> [(a,Stream)])

    --
    -- Allowing Parser to be mapped,
    -- since I need it to be a Monad.
    --
    instance Functor Parser where
        --
        -- fmap :: (a -> b) -> Parser a -> Parser b
        --
        fmap f px = Parser (\stream0 ->
            case apply px stream0 of
                []            -> []
                [(x,stream1)] -> [(f x,stream1)])

    --
    -- Allowing non-Parser functions
    -- to be applied to Parsers, since
    -- I need it to be a Monad.
    --
    instance Applicative Parser where
        --
        -- pure :: a -> Parser a
        --
        pure x = Parser (\stream0 ->
            [(x,stream0)])

        --
        -- (<*>) :: Parser (a -> b) -> Parser a -> Parser b
        --
        pf <*> px = Parser (\stream0 ->
            case apply pf stream0 of
                []            -> []
                [(f,stream1)] ->
                    case apply px stream1 of
                        []            -> []
                        [(x,stream2)] -> [(f x,stream2)])

    --
    -- Allowing Parser to be Monadic
    -- so that all the error handling
    -- and state is hidden from the
    -- user.
    --
    instance Monad Parser where
        --
        -- (>>=) :: Parser a -> (a -> Parser b) -> Parser b
        --
        px >>= fp = Parser (\stream0 ->
            case apply px stream0 of
                []            -> []
                [(x,stream1)] -> apply (fp x) stream1)

    --
    --
    --
    instance Alternative Parser where
        --
        -- empty :: Parser a
        --
        empty = Parser (\stream0 ->
            [])

        --
        -- (<|>) :: Parser a -> Parser a -> Parser a
        --
        p1 <|> p2 = Parser (\stream0 ->
            case apply p1 stream0 of
                []  -> apply p2 stream0
                [r] -> [r])

        --
        -- many :: Parser a -> [Parser a]
        --
        many p = some p <|> pure []

        --
        -- some :: Parser a -> [Parser a]
        --
        some p = pure (:) <*> p <*> many p

    --
    -- Remove a Parsers constructor.
    --
    apply            :: Parser a -> Stream -> [(a,Stream)]
    apply (Parser f)  = f
