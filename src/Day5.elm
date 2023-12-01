module Main exposing (..)

import Dict exposing (Dict)
import Element as E exposing (Element)
import Element.Font as Font
import Html exposing (Html)
import List.Extra as List
import Parser exposing ((|.), (|=), Parser)
import Set exposing (Set)



---


puzzleInput : String
puzzleInput =
    """        [C] [B] [H]
[W]     [D] [J] [Q] [B]
[P] [F] [Z] [F] [B] [L]
[G] [Z] [N] [P] [J] [S] [V]
[Z] [C] [H] [Z] [G] [T] [Z]     [C]
[V] [B] [M] [M] [C] [Q] [C] [G] [H]
[S] [V] [L] [D] [F] [F] [G] [L] [F]
[B] [J] [V] [L] [V] [G] [L] [N] [J]
 1   2   3   4   5   6   7   8   9

move 5 from 4 to 7
move 8 from 5 to 9
move 6 from 2 to 8
move 7 from 7 to 9
move 1 from 7 to 4
move 2 from 7 to 4
move 9 from 8 to 4
move 16 from 9 to 7
move 1 from 3 to 8
move 15 from 4 to 5
move 3 from 9 to 5
move 2 from 3 to 5
move 1 from 8 to 7
move 3 from 1 to 7
move 5 from 3 to 5
move 13 from 7 to 2
move 5 from 7 to 1
move 7 from 2 to 6
move 2 from 7 to 8
move 3 from 6 to 5
move 2 from 8 to 2
move 2 from 6 to 1
move 11 from 1 to 7
move 2 from 2 to 9
move 8 from 6 to 5
move 2 from 9 to 6
move 3 from 6 to 4
move 1 from 4 to 7
move 22 from 5 to 6
move 13 from 6 to 9
move 5 from 2 to 7
move 6 from 5 to 8
move 13 from 7 to 2
move 2 from 4 to 6
move 5 from 6 to 3
move 2 from 7 to 5
move 3 from 3 to 6
move 2 from 6 to 2
move 8 from 2 to 4
move 2 from 4 to 7
move 2 from 2 to 9
move 5 from 4 to 5
move 2 from 3 to 2
move 1 from 5 to 4
move 6 from 5 to 9
move 1 from 7 to 3
move 1 from 5 to 9
move 5 from 5 to 1
move 1 from 6 to 8
move 1 from 5 to 8
move 4 from 6 to 9
move 8 from 8 to 9
move 1 from 3 to 6
move 4 from 1 to 7
move 3 from 6 to 4
move 7 from 2 to 6
move 27 from 9 to 8
move 3 from 4 to 7
move 6 from 8 to 1
move 1 from 4 to 6
move 1 from 2 to 7
move 7 from 6 to 3
move 1 from 4 to 3
move 4 from 1 to 6
move 1 from 9 to 2
move 1 from 2 to 4
move 1 from 4 to 5
move 3 from 9 to 4
move 5 from 7 to 8
move 2 from 5 to 6
move 4 from 6 to 9
move 10 from 8 to 3
move 2 from 4 to 7
move 3 from 1 to 7
move 2 from 9 to 6
move 6 from 3 to 1
move 7 from 3 to 4
move 2 from 1 to 9
move 4 from 1 to 9
move 1 from 3 to 6
move 1 from 3 to 8
move 2 from 9 to 5
move 2 from 5 to 3
move 3 from 3 to 1
move 1 from 4 to 6
move 5 from 7 to 6
move 2 from 3 to 4
move 2 from 8 to 1
move 9 from 4 to 7
move 4 from 9 to 3
move 2 from 8 to 3
move 1 from 1 to 4
move 1 from 6 to 2
move 1 from 2 to 9
move 6 from 3 to 5
move 2 from 1 to 3
move 1 from 3 to 2
move 1 from 2 to 9
move 8 from 6 to 8
move 2 from 6 to 3
move 1 from 1 to 2
move 7 from 7 to 9
move 13 from 8 to 6
move 1 from 2 to 8
move 6 from 9 to 3
move 1 from 1 to 6
move 2 from 8 to 5
move 5 from 3 to 4
move 2 from 8 to 1
move 8 from 5 to 2
move 4 from 3 to 2
move 5 from 8 to 4
move 2 from 9 to 4
move 4 from 4 to 7
move 10 from 2 to 6
move 1 from 2 to 9
move 24 from 6 to 1
move 17 from 1 to 8
move 1 from 9 to 2
move 2 from 4 to 9
move 10 from 7 to 4
move 1 from 2 to 5
move 5 from 9 to 1
move 1 from 7 to 6
move 12 from 8 to 6
move 1 from 7 to 5
move 2 from 5 to 6
move 16 from 6 to 8
move 12 from 1 to 6
move 2 from 1 to 7
move 9 from 6 to 2
move 2 from 4 to 1
move 1 from 1 to 5
move 7 from 4 to 6
move 13 from 8 to 2
move 5 from 8 to 2
move 2 from 7 to 3
move 2 from 4 to 9
move 1 from 5 to 4
move 3 from 9 to 8
move 2 from 4 to 2
move 2 from 3 to 8
move 1 from 1 to 5
move 1 from 4 to 8
move 6 from 2 to 7
move 1 from 5 to 8
move 1 from 6 to 2
move 7 from 6 to 8
move 1 from 6 to 2
move 24 from 2 to 1
move 10 from 8 to 3
move 4 from 8 to 2
move 4 from 7 to 1
move 5 from 2 to 9
move 1 from 6 to 2
move 10 from 3 to 1
move 2 from 7 to 3
move 2 from 3 to 7
move 2 from 7 to 9
move 35 from 1 to 5
move 28 from 5 to 6
move 2 from 2 to 7
move 19 from 6 to 4
move 3 from 1 to 2
move 3 from 2 to 5
move 23 from 4 to 7
move 2 from 6 to 8
move 4 from 7 to 6
move 3 from 5 to 6
move 13 from 7 to 4
move 2 from 5 to 6
move 2 from 9 to 4
move 5 from 6 to 3
move 6 from 4 to 5
move 1 from 4 to 8
move 4 from 4 to 6
move 5 from 9 to 7
move 2 from 8 to 7
move 5 from 3 to 2
move 4 from 5 to 2
move 5 from 2 to 9
move 4 from 8 to 4
move 1 from 9 to 8
move 2 from 2 to 6
move 4 from 4 to 2
move 3 from 2 to 3
move 3 from 5 to 1
move 2 from 3 to 2
move 3 from 1 to 4
move 1 from 9 to 4
move 5 from 4 to 9
move 2 from 4 to 3
move 5 from 6 to 8
move 1 from 9 to 7
move 2 from 6 to 3
move 1 from 4 to 5
move 1 from 9 to 4
move 6 from 8 to 6
move 2 from 3 to 6
move 2 from 9 to 4
move 2 from 3 to 9
move 1 from 3 to 1
move 17 from 6 to 4
move 1 from 1 to 8
move 1 from 6 to 5
move 1 from 9 to 2
move 11 from 4 to 6
move 9 from 4 to 5
move 7 from 9 to 4
move 2 from 5 to 2
move 1 from 4 to 9
move 5 from 2 to 1
move 1 from 2 to 9
move 4 from 4 to 9
move 4 from 1 to 5
move 1 from 1 to 7
move 1 from 8 to 9
move 8 from 7 to 8
move 4 from 7 to 4
move 9 from 5 to 2
move 2 from 4 to 1
move 11 from 6 to 8
move 2 from 4 to 3
move 2 from 4 to 8
move 1 from 1 to 4
move 3 from 2 to 8
move 1 from 1 to 3
move 3 from 3 to 9
move 8 from 9 to 6
move 1 from 4 to 8
move 2 from 9 to 3
move 5 from 6 to 9
move 7 from 5 to 6
move 2 from 3 to 4
move 5 from 7 to 9
move 2 from 4 to 5
move 2 from 2 to 3
move 10 from 9 to 5
move 2 from 6 to 3
move 6 from 2 to 7
move 10 from 5 to 3
move 6 from 7 to 1
move 2 from 1 to 7
move 4 from 3 to 9
move 3 from 8 to 2
move 2 from 7 to 5
move 19 from 8 to 7
move 4 from 5 to 9
move 4 from 9 to 8
move 1 from 2 to 5
move 3 from 6 to 8
move 1 from 5 to 9
move 5 from 9 to 7
move 6 from 3 to 8
move 1 from 3 to 8
move 2 from 3 to 2
move 23 from 7 to 6
move 10 from 8 to 4
move 4 from 4 to 9
move 4 from 2 to 6
move 1 from 3 to 8
move 4 from 8 to 4
move 31 from 6 to 4
move 9 from 4 to 5
move 8 from 5 to 3
move 1 from 6 to 7
move 2 from 5 to 7
move 4 from 9 to 2
move 21 from 4 to 8
move 4 from 2 to 9
move 3 from 3 to 9
move 2 from 7 to 9
move 11 from 4 to 9
move 1 from 8 to 5
move 1 from 5 to 9
move 9 from 9 to 3
move 3 from 1 to 5
move 2 from 5 to 8
move 11 from 3 to 6
move 4 from 6 to 3
move 2 from 8 to 3
move 10 from 9 to 6
move 22 from 8 to 9
move 1 from 1 to 8
move 4 from 6 to 3
move 2 from 7 to 6
move 3 from 8 to 3
move 14 from 3 to 2
move 1 from 3 to 4
move 1 from 2 to 4
move 2 from 9 to 1
move 1 from 5 to 7
move 1 from 3 to 2
move 14 from 6 to 5
move 13 from 5 to 2
move 1 from 5 to 6
move 1 from 7 to 9
move 8 from 9 to 4
move 2 from 6 to 7
move 23 from 2 to 4
move 2 from 1 to 4
move 2 from 2 to 5
move 1 from 5 to 1
move 1 from 7 to 2
move 1 from 5 to 9
move 16 from 9 to 5
move 1 from 2 to 4
move 13 from 5 to 3
move 1 from 1 to 4
move 1 from 7 to 1
move 1 from 5 to 3
move 2 from 5 to 7
move 2 from 7 to 1
move 9 from 3 to 2
move 2 from 1 to 7
move 1 from 1 to 9
move 19 from 4 to 2
move 1 from 9 to 7
move 1 from 7 to 8
move 23 from 2 to 8
move 2 from 7 to 2
move 12 from 4 to 5
move 12 from 5 to 1
move 5 from 2 to 9
move 2 from 2 to 7
move 5 from 8 to 1
move 3 from 9 to 4
move 1 from 2 to 8
move 1 from 2 to 4
move 4 from 8 to 1
move 2 from 3 to 1
move 2 from 7 to 5
move 1 from 4 to 9
move 8 from 4 to 7
move 13 from 8 to 6
move 1 from 3 to 1
move 13 from 6 to 7
move 13 from 7 to 6
move 7 from 1 to 4
move 5 from 7 to 3
move 3 from 4 to 3
move 13 from 6 to 1
move 3 from 8 to 6
move 8 from 3 to 8
move 12 from 1 to 8
move 1 from 3 to 5
move 6 from 1 to 7
move 3 from 6 to 8
move 1 from 3 to 8
move 1 from 9 to 2
move 3 from 5 to 6
move 1 from 7 to 3
move 8 from 7 to 1
move 2 from 6 to 2
move 3 from 4 to 3
move 2 from 9 to 2
move 6 from 8 to 9
move 5 from 2 to 5
move 2 from 3 to 4
move 5 from 5 to 4
move 1 from 3 to 9
move 8 from 4 to 5
move 1 from 6 to 8
move 2 from 1 to 4
move 1 from 1 to 4
move 3 from 1 to 5
move 3 from 1 to 6
move 7 from 1 to 9
move 2 from 6 to 9
move 1 from 3 to 5
move 17 from 8 to 7
move 17 from 7 to 6
move 5 from 5 to 2
move 5 from 2 to 1
move 13 from 6 to 2
move 1 from 1 to 4
move 5 from 5 to 1
move 1 from 1 to 5
move 10 from 9 to 1
move 13 from 1 to 8
move 13 from 8 to 4
move 5 from 6 to 7
move 8 from 1 to 7
move 1 from 1 to 3
move 12 from 2 to 6
move 1 from 3 to 8
move 6 from 6 to 2
move 2 from 5 to 1
move 5 from 2 to 5
move 2 from 5 to 9
move 12 from 4 to 2
move 1 from 6 to 2
move 15 from 2 to 1
move 1 from 8 to 6
move 2 from 7 to 3
move 2 from 4 to 2
move 1 from 2 to 9
move 1 from 2 to 6
move 7 from 7 to 3
move 1 from 4 to 1
move 17 from 1 to 2
move 3 from 6 to 4
move 1 from 3 to 8
move 3 from 9 to 6
move 4 from 6 to 3
move 13 from 2 to 9
move 3 from 2 to 8
move 2 from 5 to 1
move 6 from 8 to 2
move 1 from 6 to 2
move 3 from 2 to 7
move 3 from 1 to 6
move 2 from 9 to 8
move 6 from 9 to 8
move 8 from 9 to 3
move 7 from 7 to 4
move 20 from 3 to 7
move 4 from 6 to 8
move 1 from 8 to 6
move 2 from 6 to 4
move 3 from 2 to 1
move 2 from 9 to 6
move 9 from 8 to 6
move 3 from 1 to 9
move 9 from 4 to 8
move 1 from 5 to 6
move 3 from 4 to 2
move 1 from 5 to 3
move 8 from 6 to 4
move 4 from 9 to 3
move 10 from 8 to 6
move 5 from 2 to 3
move 3 from 6 to 4
move 10 from 3 to 1
move 11 from 4 to 1
move 1 from 8 to 2
move 2 from 4 to 2
move 1 from 4 to 9
move 10 from 6 to 3
move 21 from 1 to 5
move 2 from 2 to 7
move 1 from 9 to 6
move 1 from 6 to 3
move 1 from 6 to 7
move 11 from 5 to 6
move 1 from 2 to 8
move 1 from 5 to 9
move 11 from 6 to 3
move 1 from 8 to 4
move 1 from 4 to 1
move 3 from 5 to 7
move 1 from 1 to 5
move 5 from 5 to 8
move 23 from 7 to 9
move 5 from 8 to 4
move 1 from 5 to 2
move 12 from 3 to 4
move 6 from 3 to 6
move 1 from 5 to 2
move 8 from 9 to 2
move 1 from 7 to 8
move 2 from 7 to 9
move 4 from 3 to 5
move 1 from 5 to 9
move 1 from 6 to 5
move 4 from 6 to 5
move 3 from 2 to 1
move 3 from 1 to 3
move 8 from 9 to 1
move 4 from 2 to 9
move 1 from 9 to 7
move 14 from 4 to 8
move 3 from 3 to 4
move 1 from 5 to 8
move 2 from 8 to 6
move 2 from 6 to 7
move 4 from 4 to 3
move 12 from 9 to 1
move 1 from 3 to 2
move 6 from 8 to 2
move 1 from 7 to 1
move 5 from 2 to 3
move 21 from 1 to 3
move 5 from 5 to 4
move 1 from 8 to 5
move 2 from 2 to 7
move 1 from 6 to 1
move 2 from 9 to 2
move 1 from 2 to 9
move 1 from 1 to 5
move 4 from 3 to 5
move 7 from 8 to 1
move 6 from 1 to 9
move 1 from 2 to 5
move 6 from 9 to 7
move 8 from 3 to 4
move 2 from 4 to 8
move 1 from 1 to 6
move 10 from 3 to 9
move 12 from 4 to 2
move 1 from 8 to 1
"""


logic input =
    input
        |> show parse
        |> show (Tuple.mapFirst padCrateLines)
        |> show (Tuple.mapFirst List.transpose)
        |> show (Tuple.mapFirst (List.map (List.filterMap identity)))
        |> show moveCrates
        |> show (List.map (List.head >> unwrap))
        |> show String.fromList


moveCrates : ( List (List Char), List QtMove ) -> List (List Char)
moveCrates ( crates, moves ) =
    List.foldl moveCrate crates moves


moveCrate : QtMove -> List (List Char) -> List (List Char)
moveCrate move crates =
    let
        c =
            List.getAt (move.from - 1) crates |> unwrap |> List.take move.qty
    in
    crates
        |> listMapAt (move.to - 1) (\stack -> c ++ stack)
        |> listMapAt (move.from - 1) (List.drop move.qty)


listMapAt : Int -> (a -> a) -> List a -> List a
listMapAt i f l =
    List.indexedMap
        (\index elem ->
            if index == i then
                f elem

            else
                elem
        )
        l


padCrateLines : List (List (Maybe Char)) -> List (List (Maybe Char))
padCrateLines ll =
    let
        longest : Int
        longest =
            List.maximumBy List.length ll
                |> unwrap
                |> List.length
    in
    ll
        |> List.map (\l -> l ++ List.repeat (longest - List.length l) Nothing)


expandMoves : List QtMove -> List Move
expandMoves l =
    List.foldl (\{ qty, from, to } acc -> List.repeat qty { from = from, to = to } ++ acc) [] l
        |> List.reverse


parse s =
    Parser.run parser s
        |> unwrapResult


type alias QtMove =
    { qty : Int, from : Int, to : Int }


type alias Move =
    { from : Int, to : Int }


parser : Parser ( List (List (Maybe Char)), List QtMove )
parser =
    Parser.succeed makeTups
        |= parserLoop crateLineParser
        -- Now we have parsed the crates
        |. Parser.symbol " 1"
        |. Parser.chompUntil "\n"
        |. Parser.symbol "\n\n"
        |= parserLoop parserQtMove


parserQtMove : Parser QtMove
parserQtMove =
    -- "move 3 from 1 to 3\n"
    Parser.succeed QtMove
        |. Parser.symbol "move "
        |= Parser.int
        |. Parser.symbol " from "
        |= Parser.int
        |. Parser.symbol " to "
        |= Parser.int
        |. parserMaybe (Parser.symbol "\n")


crateLineParser : Parser (List (Maybe Char))
crateLineParser =
    --    [D]
    --[N] [C]
    --[Z] [M] [P]
    Parser.sequence
        { start = ""
        , separator = " "
        , end = "\n"
        , spaces = Parser.succeed ()
        , item = Parser.oneOf [ crateParser, noCrateParser ]
        , trailing = Parser.Forbidden
        }



-- parserLoop
-- (Parser.oneOf [ crateParser, noCrateParser ])
-- |. Parser.symbol "\n"


crateParser : Parser (Maybe Char)
crateParser =
    Parser.succeed Just
        |. Parser.symbol "["
        |= parserChar
        |. Parser.symbol "]"


noCrateParser : Parser (Maybe Char)
noCrateParser =
    Parser.succeed Nothing
        |. Parser.symbol "   "



-- Parsing helpers


parserChar : Parser Char
parserChar =
    Parser.chompIf (\_ -> True)
        |> Parser.getChompedString
        |> Parser.map (String.toList >> List.head >> unwrap)


parserMaybe : Parser a -> Parser (Maybe a)
parserMaybe p =
    Parser.oneOf [ Parser.succeed Just |= p, Parser.succeed Nothing ]


parserLoop : Parser a -> Parser (List a)
parserLoop p =
    Parser.loop []
        (\l ->
            Parser.oneOf
                [ Parser.succeed (\c -> Parser.Loop (c :: l))
                    |= p
                , Parser.succeed ()
                    |> Parser.map (\_ -> Parser.Done (List.reverse l))
                ]
        )



-- Helpers


makeTups : a -> b -> ( a, b )
makeTups a b =
    ( a, b )



--- Scaffolding


main : Html msg
main =
    ( [], puzzleInput )
        |> logic
        |> displayResultsElement


displayResultsElement : ( List String, a ) -> Html msg
displayResultsElement ( trace, final ) =
    E.layout []
        (E.column [ E.padding 15, E.spacing 13 ] (E.el [ Font.size 40 ] (E.text ("> " ++ Debug.toString final)) :: List.map E.text (List.intersperse "⬆" trace)))


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


unwrapResult : Result a b -> b
unwrapResult r =
    case r of
        Ok b ->
            b

        Err _ ->
            Debug.todo "Paric result!"
