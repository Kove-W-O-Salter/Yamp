# Yaml List Parser

[Examples](https://github.com/Kove-W-O-Salter/Yamp/blob/master/doc/examples/INDEX.md).

```haskell
module YamlListParser where

    import Data.Yamp
    import Text.Yamp
    import Control.Applicative

    yamlList :: Parser [String]
    yamlList  = delim "[" "]" (commaSep yamlListItem)

    yamlListItem :: Parser String
    yamlListItem  = some (letter <|> digit <|> space)
```

[Examples](https://github.com/Kove-W-O-Salter/Yamp/blob/master/doc/examples/INDEX.md).
