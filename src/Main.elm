module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Date exposing (Date)
import Date.Extra as Date


type alias Author =
    { name : String
    , avatarUrl : String
    , twitterHandle : String
    }


type Event
    = Event { date : Date, title : String, comment : String }
    | Talk { date : Date, title : String, description : String, author : Author }


type alias Events =
    List Event


type alias Model =
    { schedule : Events }


eventTz : Date.TimeZone
eventTz =
    Date.offset -3


eventDate : Date.DateSpec
eventDate =
    Date.calendarDate 2017 Date.Jul 1


eventTime : Int -> Int -> Date
eventTime hour minute =
    Date.fromSpec eventTz (Date.atTime hour minute 0 0) eventDate


initModel =
    { schedule = [] }


viewEvent =
    li [ class "pb3 flex" ]
        [ div [ class "w2 h2 mr2 br-100 bn bg-blue" ] []
        , div []
            [ time [] [ text "9:30" ]
            , h4 [ class "f4 ma0 mb1" ] [ text "Cadastro" ]
            , span [] [ text "Não esqueça seu RG" ]
            ]
        ]


viewTalk =
    li [ class "pb3 flex" ]
        [ div [] [ img [ class "w2 h2 mr2 br-100 bn bg-green" ] [] ]
        , div []
            [ time [] [ text "9:30 ~ 10:00" ]
            , h4 [ class "f4 ma0 mb1" ] [ text "Keynote" ]
            , div [ class "flex items-center" ]
                [ span [] [ text "Matheus Marsiglio" ] ]
            ]
        ]


main =
    div []
        [ header [ class "pa3 pt4" ]
            [ h1 [ class "f2 ma0" ] [ text "Frontinsampa" ] ]
        , section [ class "pa3" ]
            [ h2 [ class "f3 ma0 mb3" ] [ text "Informações" ] ]
        , section [ class "pa3" ]
            [ h2 [ class "f3 ma0 mb3" ] [ text "Agenda" ]
            , ul [ class "list pa0 ma0" ]
                [ viewEvent
                , viewTalk
                ]
            ]
        , footer [] []
        ]
