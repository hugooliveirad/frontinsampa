module MaybeZipper exposing (..)

import Maybe.Extra as MaybeExtra
import List.Extra exposing (takeWhile, dropWhile)


type MaybeZipper a
    = MaybeZipper (List a) (Maybe a) (List a)



-- Constructors


fromList : List a -> MaybeZipper a
fromList list =
    MaybeZipper [] Nothing list



-- Accessors


before : MaybeZipper a -> List a
before (MaybeZipper beforeList _ _) =
    beforeList


get : MaybeZipper a -> Maybe a
get (MaybeZipper _ selected _) =
    selected


after : MaybeZipper a -> List a
after (MaybeZipper _ _ afterList) =
    afterList


toList : MaybeZipper a -> List a
toList (MaybeZipper beforeList selected afterList) =
    beforeList
        ++ MaybeExtra.toList selected
        ++ afterList


mapToList : (a -> Bool -> b) -> MaybeZipper a -> List b
mapToList mapFn ((MaybeZipper beforeList selected afterList) as zipper) =
    toList zipper
        |> List.map (\i -> mapFn i (Just i == selected))



-- Moving around


find : (a -> Bool) -> MaybeZipper a -> MaybeZipper a
find findFn zipper =
    let
        zipperList =
            toList zipper

        bef =
            takeWhile findFn zipperList

        rest =
            dropWhile findFn zipperList

        sel =
            List.head rest

        aft =
            List.tail rest |> Maybe.withDefault []
    in
        MaybeZipper bef sel aft
