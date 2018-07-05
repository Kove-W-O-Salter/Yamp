
{-
 - Copyright (c) Kove W. Ochre-Salter, 6th of July, 2018.
 - Yamps monad.
 -}

module Data.Yamp where

  import Data.State
  import Data.Errorman

  newtype Yamp :: * -> * where
    Y :: State String Errorman a -> Yamp a

  instance Functor Yamp where
    {-
     - fmap :: (a -> b) -> Yamp a -> Yamp b
     -}
    fmap f px = Y $ \stream0 ->
      case apply px stream0 of
        (Error s           ) -> Error s
        (Ok    (x, stream1)) -> Ok (f x, stream1)

  instance Applicative Yamp where
    {-
     - pure :: a -> Yamp a
     -}
    pure x = Y $ \stream0 ->
      Ok (x, stream0)

    {-
     - (<*>) :: Yamp (a -> b) -> Yamp a -> Yamp b
     -}
    pf <*> px = Y $ \stream0 ->
      case apply pf stream0 of
        (Error (s         )) -> Error s
        (Ok    (f, stream1)) -> case apply px stream1 of
          (Error (s         )) -> Error s
          (Ok    (x, stream2)) -> Ok (f x, stream2)

  instance Monad Yamp where
    {-
     - (>>=) :: Yamp a -> (a -> Yamp b) -> Yamp b
     -}
    px >>= f = Y $ \stream0 ->
      case apply px stream0 of
        (Error (s         )) -> Error s
        (Ok    (x, stream1)) -> apply (f x) stream1

  apply       :: Yamp a -> String -> Errorman (a, String)
  apply (Y f)  = f
