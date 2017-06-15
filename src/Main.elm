module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import DateHelpers exposing (..)
import Events exposing (..)
import Navigation as Navigation exposing (Location)
import MaybeZipper
import Maybe.Extra as MaybeExtra


-- MODEL


type alias Model =
    { schedule : Events }


initModel =
    { schedule = schedule }



-- VIEW


viewEvent event currentTime =
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


viewTalk talk event currentTime selected anySelected =
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
                [ span [ class "br2 pa1 bg-red white mr1" ] [ text "Agora" ]
                , time [] [ text startEnd ]
                , h4 [ class "f4 mv2" ] [ text title ]
                , div [ class "lh-copy overflow-hidden transition-smooth", descriptionClass ] [ text description ]
                , div [ class "flex items-center" ]
                    [ img [ class "br-100 bn w-text h-text bg-white mr1", src authorAvatar ] []
                    , span [] [ text authorName ]
                    ]
                ]
            ]


viewSchedule : Events -> Html Msg
viewSchedule schedule =
    let
        anySelected =
            MaybeExtra.isJust <| MaybeZipper.get schedule

        currentTime =
            eventTime 10 10
    in
        ul [ class "list pa0 ma0" ] <|
            MaybeZipper.mapToList
                (\event selected ->
                    case event of
                        Event e ->
                            viewEvent e currentTime

                        Talk t ->
                            viewTalk t event currentTime selected anySelected
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
    | SelectEvent (Maybe Event)


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
