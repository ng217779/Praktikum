module PrettyPrinting (Pretty, pretty) where

import Type

class Pretty a where
    pretty :: a -> String

instance Pretty Term where
    -- Simple gets the name of the variable.
    pretty (Var (VarName a)) = a
    -- Case that there is only the name for the combinator
    pretty (Comb n []) = n
    -- Case that the term is made out of multiple terms.
    pretty (Comb n (t:ts)) = n ++ "(" ++ (pretty t) ++ (rest ts)
        where rest []      = ")"
              rest (x:xs)  = ", " ++ (pretty x) ++ (rest xs)

instance Pretty Rule where
    -- Basic case with no extra terms coming with that rule.
    pretty (Rule n []) = (pretty n) ++ "."
    -- Case for extra terms, describing the rule.
    pretty (Rule n (t:ts)) = (pretty n) ++ " :- " ++ (pretty t) ++ (rest ts)
        where rest []      = "."
              rest (x:xs)  = ", " ++ (pretty x) ++ (rest xs)

instance Pretty Prog where
    -- Base case again
    pretty (Prog []) = ""
    -- Same pattern as in the upper examples.
    pretty (Prog (r:rs))  = (pretty r) ++ (rest rs)
        where rest []     = ""
              rest (x:xs) =  "\n" ++ (pretty x) ++ rest (xs)

instance Pretty Goal where
    -- Basic case it is.
    pretty (Goal []) = "?- ."
    -- Suprise! Again the same pattern, I'll work on an improvement soon.
    pretty (Goal (t:ts))  = "?- " ++ (pretty t) ++ (rest ts)
        where rest []     = "."
              rest (x:xs) = ", " ++ (pretty x) ++ (rest xs)