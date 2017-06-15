module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import DateHelpers exposing (..)
import Events exposing (..)
import Navigation as Navigation exposing (Location)
import MaybeZipper


-- MODEL


type alias Model =
    { schedule : Events }


initModel =
    { schedule = schedule }



-- VIEW


viewEvent event =
    let
        startEnd =
            formatEventTime event.start event.end

        title =
            event.title

        comment =
            Maybe.withDefault "" event.comment
    in
        li [ class "pb3 flex" ]
            [ div [ class "w-100 br2 bg-light-gray mid-gray pv3 ph3" ]
                [ time [] [ text startEnd ]
                , h4 [ class "f4 mv1 normal" ] [ text title ]
                , div [] [ text comment ]
                ]
            ]


viewTalk talk selected =
    let
        startEnd =
            formatTalkTime talk.start talk.end

        title =
            talk.title

        authorName =
            talk.author.name

        description =
            talk.description

        descriptionClass =
            if selected then
                ""
            else
                "dn"

        kindClass =
            kindToClass talk.kind
    in
        li [ class "pb3 flex" ]
            [ div [ class "w-100 br2 shadow-4 pv3 ph3", class kindClass ]
                [ time [] [ text startEnd ]
                , h4 [ class "f4 mv2 normal" ] [ text title ]
                , div [ class descriptionClass ] [ text description ]
                , div [] [ text authorName ]
                ]
            ]


viewSchedule : Events -> Html msg
viewSchedule schedule =
    ul [ class "list pa0 ma0" ] <|
        MaybeZipper.mapToList
            (\event selected ->
                case event of
                    Event e ->
                        viewEvent e

                    Talk t ->
                        viewTalk t selected
            )
            schedule


view model =
    div []
        [ header [ class "pa3 pt4" ]
            [ h1 [ class "f2 ma0" ] [ text "Frontinsampa" ] ]
        , section [ class "pa3" ]
            [ h2 [ class "f2 ma0 mb4" ] [ text "Informações" ] ]
        , section [ class "pa3" ]
            [ h2 [ class "f2 ma0 mb4" ] [ text "Agenda" ]
            , viewSchedule initModel.schedule
            ]
        , footer [] []
        ]



-- UPDATE


type Msg
    = Navigate Location


update msg model =
    ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions model =
    Sub.none



-- PROGRAM


init location =
    ( initModel, Cmd.none )


main =
    Navigation.program Navigate
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
