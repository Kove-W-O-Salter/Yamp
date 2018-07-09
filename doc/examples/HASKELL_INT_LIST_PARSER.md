# Haskell Int List Parser

[Examples](./INDEX.md).

```haskell
module HaskellIntListParser where
       import Data.Yamp
       import Text.Yamp
       import Control.Applicative

       haskellIntListParser :: Parser [Int]
       haskellIntListParser  = delim "[" "]" (commaSep int)

       int :: Parser Int
       int  = do spaces
                 is <- some digit
                 spaces
                 return (read is)
```

[Examples](./INDEX.md).
