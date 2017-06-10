module DateHelpers exposing (..)

import Date exposing (Date, hour, minute)
import Date.Extra as Date


stringHour : Date -> String
stringHour =
    hour >> toString


stringMinute : Date -> String
stringMinute =
    minute >> toString


eventTz : Date.TimeZone
eventTz =
    Date.offset -180


eventDate : Date.DateSpec
eventDate =
    Date.calendarDate 2017 Date.Jul 1


eventTime : Int -> Int -> Date
eventTime hour minute =
    Date.fromSpec eventTz (Date.atTime hour minute 0 0) eventDate


toHourAndMinute : Date -> String
toHourAndMinute date =
    Date.toFormattedString "H:mm" date


formatEventTime : Date -> Maybe Date -> String
formatEventTime start end =
    case end of
        Just e ->
            toHourAndMinute start
                ++ " ~ "
                ++ toHourAndMinute e

        Nothing ->
            toHourAndMinute start


formatTalkTime : Date -> Date -> String
formatTalkTime start end =
    toHourAndMinute start
        ++ " ~ "
        ++ toHourAndMinute end
