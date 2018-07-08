# Yaml List Parser

[Examples](./INDEX.md).

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

[Examples](./INDEX.md).
