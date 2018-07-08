module XMLParser where

    import Data.Yamp
    import Text.Yamp
    import Control.Applicative

    data Attr = Attr String String
              deriving Show

    data Tag = OTag String [Attr]
             | CTag String
             deriving Show

    data Expr = PlainText String
              | Tag Tag Expr Tag
              deriving Show

    parseAttr :: Parser Attr
    parseAttr  = do name <- letters
                    matchChar '='
                    value <- letters
                    return (Attr name value)

    parseAttrs :: Parser [Attr]
    parseAttrs  = sepBy space parseAttr

    parseOTag :: Parser Tag
    parseOTag  = delim "<" ">" (do name <- letters1
                                   attrs <- parseAttrs
                                   return (OTag name attrs))

    parseCTag :: Parser Tag
    parseCTag  = delim "<" ">" (do matchChar '/'
                                   name <- letters
                                   return (CTag name))

    parsePlainText :: Parser Expr
    parsePlainText  = delim "\"" "\"" (do ls <- letters
                                          return (PlainText ls))

    parseTag :: Parser Expr
    parseTag  = do otag <- parseOTag
                   space
                   body <- parseExpr
                   space
                   ctag <- parseCTag
                   return (Tag otag body ctag)

    parseExpr :: Parser Expr
    parseExpr  =  parseTag
              <|> parsePlainText
