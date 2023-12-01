module Main exposing (..)

import Dict exposing (Dict)
import Element as E exposing (Element)
import Element.Font as Font
import Html exposing (Html)
import List.Extra as List
import Set exposing (Set)



---


logic input =
    input



--- Scaffolding


main : Html msg
main =
    ( [], puzzleInput )
        |> logic
        |> displayResultsElement


displayResultsElement : ( List String, a ) -> Html msg
displayResultsElement ( trace, final ) =
    E.layout []
        (E.column [ E.padding 15, E.spacing 13 ] (E.el [ Font.size 40 ] (E.text (Debug.toString final)) :: List.map E.text (List.intersperse "⬆" trace)))


hide : (a -> b) -> ( List String, a ) -> ( List String, b )
hide f ( display, item ) =
    ( display
    , f item
    )


show : (a -> b) -> ( List String, a ) -> ( List String, b )
show f ( display, item ) =
    let
        next =
            f item
    in
    ( Debug.toString next :: display
    , next
    )


lm : (a -> b) -> ( List String, List a ) -> ( List String, List b )
lm f ( display, l ) =
    ( display, l )
        |> show (List.map f)


unwrap : Maybe a -> a
unwrap maybeA =
    case maybeA of
        Just a ->
            a

        Nothing ->
            Debug.todo "panic!"


puzzleInput : String
puzzleInput =
    """





    """
