module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Date
import Date.Extra exposing (isBetween)
import DateHelpers exposing (..)
import Time exposing (Time)
import Events exposing (..)
import Navigation as Navigation exposing (Location)
import MaybeZipper
import Maybe.Extra as MaybeExtra
import Task


-- MODEL


type alias Model =
    { schedule : Events
    , now : Time
    }


initModel =
    { schedule = schedule
    , now = 0
    }



-- VIEW


viewHappening happening =
    let
        happeningClass =
            if happening then
                class ""
            else
                class "dn"
    in
        span
            [ class "br2 pa1 bg-red white ml2"
            , happeningClass
            ]
            [ text "Agora" ]


viewEvent event happening =
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
                [ div []
                    [ time [] [ text startEnd ]
                    , viewHappening happening
                    ]
                , h4 [ class "f4 mv1 normal" ] [ text title ]
                , div [] [ text comment ]
                ]
            ]


viewTalk talk event happening selected anySelected =
    let
        startEnd =
            formatTalkTime talk.start talk.end

        title =
            talk.title

        authorName =
            talk.author.name

        authorAvatar =
            talk.author.avatarUrl

        description =
            talk.description

        descriptionClass =
            if selected then
                class "mb3 mh-100 o-100"
            else
                class "mb0 mh-0 o-0"

        kindClass =
            class <| kindToClass talk.kind

        opacityClass =
            if anySelected && not selected then
                class "o-60"
            else
                class "o-100"

        shadowClass =
            if selected then
                class "shadow-2"
            else
                class ""

        selectMsg =
            if selected then
                SelectEvent Nothing
            else
                SelectEvent <| Just event
    in
        li [ class "pb3 flex " ]
            [ div
                [ class "w-100 br2 pv3 ph3 pointer"
                , kindClass
                , shadowClass
                , opacityClass
                , onClick selectMsg
                ]
                [ time []
                    [ text startEnd ]
                , viewHappening happening
                , h4 [ class "f4 mv2" ] [ text title ]
                , div
                    [ class "lh-copy overflow-hidden transition-smooth"
                    , descriptionClass
                    ]
                    [ text description ]
                , div [ class "flex items-center" ]
                    [ img
                        [ class "br-100 bn w-text h-text bg-white mr1"
                        , src authorAvatar
                        ]
                        []
                    , span [] [ text authorName ]
                    ]
                ]
            ]


viewSchedule : Model -> Html Msg
viewSchedule model =
    let
        anySelected =
            MaybeExtra.isJust <| MaybeZipper.get model.schedule

        now =
            Date.fromTime model.now
    in
        ul [ class "list pa0 ma0" ] <|
            MaybeZipper.mapToList
                (\event selected ->
                    case event of
                        Event e ->
                            let
                                happening =
                                    case e.end of
                                        Nothing ->
                                            False

                                        Just end ->
                                            isBetween e.start end now
                            in
                                viewEvent e happening

                        Talk t ->
                            let
                                happening =
                                    isBetween t.start t.end now
                            in
                                viewTalk t event happening selected anySelected
                )
                schedule


view model =
    div []
        [ header [ class "pa3 pt4" ]
            [ h1 [ class "ma0" ]
                [ div [ class "f2" ]
                    [ text "Programação" ]
                , div
                    [ class "f3 mt2" ]
                    [ text "Frontinsampa" ]
                ]
            ]
        , section [ class "pa3" ]
            [ viewSchedule model ]
        , footer [] []
        ]



-- UPDATE


type Msg
    = Navigate Location
    | SelectEvent (Maybe Event)
    | UpdateTime Time


update msg model =
    case msg of
        Navigate _ ->
            ( model, Cmd.none )

        SelectEvent event ->
            case event of
                Just e ->
                    ( { model | schedule = MaybeZipper.select e model.schedule }
                    , Cmd.none
                    )

                Nothing ->
                    ( { model | schedule = MaybeZipper.unselect model.schedule }
                    , Cmd.none
                    )

        UpdateTime time ->
            ( { model | now = time }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions model =
    Time.every (20 * Time.second) UpdateTime



-- PROGRAM


init location =
    ( initModel, Task.perform UpdateTime Time.now )


main =
    Navigation.program Navigate
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
