{-# LANGUAGE LinearTypes #-}
{-# LANGUAGE GADTs       #-}

linearIdentity :: a #-> a
linearIdentity x = x

linearSwap :: (a, a) #-> (a, a)
linearSwap (x, y) = (y, x)

{- Doesn't compile
linearDup :: a #-> (a, a)
linearDup x = (x, x)
-}

{- Does compile -}
nonLinearDup :: a -> (a, a)
nonLinearDup x = (x, x)

{- Doesn't compile
linearDropper :: a #-> IO ()
linearDropper x = putStrLn "oops I dropped it"
-}

data LinearHolder a where
    LinearHolder :: a #-> LinearHolder a

linearHold :: a #-> LinearHolder a
linearHold x = LinearHolder x

{-
Nonlinears can call linears, but not vice versa.
So if the LinearHolder constructor wasn't typed 
with #-> then linearHold wouldn't compile.
-}

data Box a where
    Box :: a -> Box a

{-
Because the Box constructor is nonlinear, the wrapped
value isn't checked. So we can write this:
-}

spookyLinearPair :: Box a #-> (a, a)
spookyLinearPair (Box x) = (x, x)

{-
    See more in depth explanations at:
    https://github.com/tweag/linear-base/blob/master/examples/Simple/Pure.hs
-}

main :: IO ()
main = do
    putStrLn "hello linear types" 
    putStrLn "see Main.hs"
