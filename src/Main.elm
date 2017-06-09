module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    div []
        [ header [ class "pa3 pt4" ]
            [ h1 [ class "headline ma0" ] [ text "Frontinsampa" ] ]
        , section [ class "pa3" ]
            [ h2 [ class "subheadline" ] [ text "Informações" ] ]
        , section [ class "pa3" ]
            [ h2 [ class "subheadline" ] [ text "Agenda" ]
            , ul [ class "list pa0 ma0" ]
                [ li [ class "pv1" ]
                    [ time [] [ text "9:30" ]
                    , h4 [ class "f4 ma0 normal" ] [ text "Cadastro" ]
                    , span [ class "" ] [ text "Não esqueça seu RG" ]
                    ]
                , li [ class "pv1" ]
                    [ time [] [ text "9:30" ]
                    , h4 [ class "f3 ma0 normal" ] [ text "Keynote" ]
                    , div [ class "flex items-center" ]
                        [ div [ class "pr1" ]
                            [ img [ class "w1 h1 br-100 bn bg-light-silver" ] []
                            ]
                        , span [ class "lh-solid" ] [ text "Matheus Marsiglio" ]
                        ]
                    ]
                ]
            ]
        , footer [] []
        ]
