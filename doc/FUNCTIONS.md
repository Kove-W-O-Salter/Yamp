# Yamp 1.0.0.5 Functions List

[Index](./INDEX.md).

```haskell
-- 
-- Parse a Parser.
--
parse :: Parser a -> Stream -> [a]
```
---
```haskell
--
-- Parse a Parser then fail if
-- the Stream isn't empty.
--
parsePedantic :: Parser a -> Stream -> [a]
```
---
```haskell
--
-- Check if a character in the parser
-- stream satisfies a predicate.
--
satisfy   :: (Char -> Bool) -> Parser Char
```
---
```haskell
--
-- Match one of a list of characters.
--
oneOf :: [Char] -> Parser Char
```
---
```haskell
--
-- Match zero or more occurences of a Parser.
--
many :: Parser a -> Parser [a]
```
---
```haskell
--
-- Match one or more occurences of a Parser. 
--
some :: Parser a -> Parser [a]
```
---
```haskell
--
-- Match a lower-case letter.
--
lower :: Parser Char
```
---
```haskell
--
-- Match a upper-case letter.
--
upper :: Parser Char
```
---
```haskell
--
-- Match a letter.
--
letter :: Parser Char
```
---
```haskell
--
-- Match an Ascii character.
--
ascii :: Parser Char
```
---
```haskell
--
-- Match a lower-case Ascii letter.
--
asciiLower :: Parser Char
```
---
```haskell
--
-- Match an upper-case Ascii letter.
--
asciiUpper :: Parser Char
```
---
```haskell
--
-- Match an Ascii letter.
--
asciiLetter :: Parser Char
```
---
```haskell
--
-- Match an Ascii symbol.
--
asciiSymbol :: Parser Char
```
---
```haskell
--
-- Match a digit.
--
digit :: Parser Char
```
---
```haskell
--
-- Match white-space character.
--
space :: Parser Char
```
---
```haskell
--
-- Match zero or more white-spaces.
--
spaces :: Parser String
```
---
```haskell
--
-- Match one or more white-space.
--
spaces1 :: Parser String
```
---
```haskell
--
-- Match zero or more letters.
--
letters :: Parser [Char]
```
---
```haskell
--
-- Match one or more letters.
--
letters1 :: Parser [Char]
```
---
```haskell
--
-- Match a String.
--
matchString :: String -> Parser String
```
---
```haskell
--
-- Match one of a list of Strings.
--
oneOfS :: [String] -> Parser String
```
---
```haskell
--
-- Match a Parser between two other Parsers.
--
sandwhich :: Parser a -> Parser a -> Parser b -> Parser b
```
---
```haskell
--
-- Match a Parser between to String's.
--
delim :: String -> String -> Parser a -> Parser a
```
---
```haskell
--
-- Parse a Parser if the other Parser fails.
--
notFollowedBy :: Parser a -> Parser b -> Parser a
```
---
```haskell
--
-- Parser a Parser excluding curtain inputs.
--
careful :: Parser Char -> [Char] -> Parser Char
```
---
```haskell
--
-- Parse many Parsers separated by another Parser.
--
sepBy :: Parser a -> Parser b -> Parser [b]
```
---
```haskell
--
-- Parse many Parsers separated by another Parser.
--
sepBy1 :: Parser a -> Parser b -> Parser [b]
```
---
```haskell
--
-- Parse many Parsers separated by commas.
--
commaSep :: Parser a -> Parser [a]
```
---
```haskell
--
-- Parser more Parser separated by commas.
--
commaSep1 :: Parser a -> Parser [a]
```

[Index](./INDEX.md).
