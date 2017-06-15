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


viewTalk talk event selected =
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
                class "mh-100 o-100"
            else
                class "mh-0 o-0"

        kindClass =
            class <| kindToClass talk.kind

        shadowClass =
            if selected then
                class "shadow-2"
            else
                class ""
    in
        li [ class "pb3 flex pointer", onClick <| SelectEvent event ]
            [ div [ class "w-100 br2 pv3 ph3", kindClass, shadowClass ]
                [ time [] [ text startEnd ]
                , h4 [ class "f4 mv2" ] [ text title ]
                , div [ class "overflow-hidden transition-smooth", descriptionClass ] [ text description ]
                , div [] [ text authorName ]
                ]
            ]


viewSchedule : Events -> Html Msg
viewSchedule schedule =
    ul [ class "list pa0 ma0" ] <|
        MaybeZipper.mapToList
            (\event selected ->
                case event of
                    Event e ->
                        viewEvent e

                    Talk t ->
                        viewTalk t event selected
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
            , viewSchedule model.schedule
            ]
        , footer [] []
        ]



-- UPDATE


type Msg
    = Navigate Location
    | SelectEvent Event


update msg model =
    case msg of
        Navigate _ ->
            ( model, Cmd.none )

        SelectEvent event ->
            ( { model | schedule = MaybeZipper.select event model.schedule }
            , Cmd.none
            )



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
