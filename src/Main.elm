module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


viewEvent =
    li [ class "pb3 flex" ]
        [ div [ class "w2 h2 mr2 br-100 bn bg-light-silver" ] []
        , div []
            [ time [] [ text "9:30" ]
            , h4 [ class "f4 ma0 normal" ] [ text "Cadastro" ]
            , span [ class "" ] [ text "Não esqueça seu RG" ]
            ]
        ]


viewTalk =
    li [ class "pb3 flex" ]
        [ div [] [ img [ class "w2 h2 mr2 br-100 bn bg-light-silver" ] [] ]
        , div []
            [ time [] [ text "9:30 ~ 10:00" ]
            , h4 [ class "f4 ma0 normal" ] [ text "Keynote" ]
            , div [ class "flex items-center" ]
                [ span
                    [ class "lh-solid" ]
                    [ text "Matheus Marsiglio" ]
                ]
            ]
        ]


main =
    div []
        [ header [ class "pa3 pt4" ]
            [ h1 [ class "headline ma0" ] [ text "Frontinsampa" ] ]
        , section [ class "pa3" ]
            [ h2 [ class "subheadline" ] [ text "Informações" ] ]
        , section [ class "pa3" ]
            [ h2 [ class "subheadline" ] [ text "Agenda" ]
            , ul [ class "list pa0 ma0" ]
                [ viewEvent
                , viewTalk
                ]
            ]
        , footer [] []
        ]
