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


maybeEqual : a -> Maybe a -> Bool
maybeEqual a maybeB =
    case maybeB of
        Just b ->
            a == b

        Nothing ->
            False


mapToList : (a -> Bool -> b) -> MaybeZipper a -> List b
mapToList mapFn ((MaybeZipper beforeList selected afterList) as zipper) =
    toList zipper
        |> List.map
            (\item -> mapFn item (maybeEqual item selected))



-- Moving around


find : (a -> Bool) -> MaybeZipper a -> MaybeZipper a
find findFn zipper =
    let
        zipperList =
            toList zipper

        bef =
            takeWhile (findFn >> not) zipperList

        rest =
            dropWhile (findFn >> not) zipperList

        sel =
            List.head rest

        aft =
            List.tail rest |> Maybe.withDefault []
    in
        MaybeZipper bef sel aft


select : a -> MaybeZipper a -> MaybeZipper a
select item zipper =
    find ((==) item) zipper


unselect : MaybeZipper a -> MaybeZipper a
unselect zipper =
    zipper |> toList |> fromList
