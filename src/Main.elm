module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Date exposing (Date, hour, minute)
import Date.Extra as Date


stringHour =
    hour >> toString


stringMinute =
    minute >> toString


type alias Author =
    { name : String
    , avatarUrl : String
    , twitterHandle : String
    }


fabioVedovelli : Author
fabioVedovelli =
    { name = "Fábio Vedovelli"
    , avatarUrl = ""
    , twitterHandle = "vedovelli"
    }


biancaBrancaleone : Author
biancaBrancaleone =
    { name = "Bianca Brancaleone"
    , avatarUrl = ""
    , twitterHandle = "biab"
    }


raphaelFabeni : Author
raphaelFabeni =
    { name = "Raphael Fabeni"
    , avatarUrl = ""
    , twitterHandle = "raphaelfabeni"
    }


patriciaSilva : Author
patriciaSilva =
    { name = "Patrícia Silva"
    , avatarUrl = ""
    , twitterHandle = "Paty_Go"
    }


brunoGenaro : Author
brunoGenaro =
    { name = "Bruno Genaro"
    , avatarUrl = ""
    , twitterHandle = "bfgenaro"
    }


hugoBessa : Author
hugoBessa =
    { name = "Hugo Bessa"
    , avatarUrl = ""
    , twitterHandle = "hugoBessaa"
    }


reinaldoFerraz : Author
reinaldoFerraz =
    { name = "Reinaldo Ferraz"
    , avatarUrl = ""
    , twitterHandle = "reinaldoferraz"
    }


zehFernandes : Author
zehFernandes =
    { name = "Zeh Fernandes"
    , avatarUrl = ""
    , twitterHandle = "zehf"
    }


jeanCarlo : Author
jeanCarlo =
    { name = "Jean Carlo Emer"
    , avatarUrl = ""
    , twitterHandle = "jcemer"
    }


zenoRocha : Author
zenoRocha =
    { name = "Zeno Rocha"
    , avatarUrl = ""
    , twitterHandle = "zenorocha"
    }


matheusMarsiglio : Author
matheusMarsiglio =
    { name = "Matheus Marsiglio"
    , avatarUrl = ""
    , twitterHandle = "mtmr0x"
    }


type Event
    = Event
        { start : Date
        , end : Maybe Date
        , title : String
        , comment : Maybe String
        }
    | Talk
        { start : Date
        , end : Date
        , title : String
        , description : String
        , author : Author
        }


type alias Events =
    List Event


type alias Model =
    { schedule : Events }


eventTz : Date.TimeZone
eventTz =
    Date.offset -180


eventDate : Date.DateSpec
eventDate =
    Date.calendarDate 2017 Date.Jul 1


eventTime : Int -> Int -> Date
eventTime hour minute =
    Date.fromSpec eventTz (Date.atTime hour minute 0 0) eventDate


initModel =
    { schedule =
        [ Event
            { start = (eventTime 8 0)
            , end = Just (eventTime 9 20)
            , title = "Credenciamento"
            , comment = Just "Não Esqueça seu RG"
            }
        , Talk
            { start = (eventTime 9 20)
            , end = (eventTime 9 30)
            , title = "Apresentação"
            , description = ""
            , author = matheusMarsiglio
            }
        , Talk
            { start = (eventTime 9 30)
            , end = (eventTime 10 10)
            , title = "CSS Tips"
            , description = "Muitos de nós já perdemos a paciência com CSS pelo menos uma vez na vida. No entanto, já também demos aquele suspiro de alívio quando conseguimos resolver um determinado problema ou bug. Fácil de aprender e difícil de dominar, o CSS é uma linguagem de fácil acesso e que esconde diversos segredos. Nessa talk, iremos abordar algumas dicas de alguém que já perdeu a paciência algumas vezes com CSS mas que ainda o ama. Sem ressentimentos."
            , author = raphaelFabeni
            }
        , Talk
            { start = (eventTime 10 20)
            , end = (eventTime 11 0)
            , title = "Webapps confiáveis com Elm"
            , description = "Interfaces de usuário podem ser simples e confiáveis utilizando a ferramenta correta. Elm ajuda a impedir erros de execução e torna o processo de desenvolvimento mais simples. A simplicidade do Elm o ajuda a criar webapps à prova de balas e torna seu processo de desenvolvimento muito mais divertido."
            , author = hugoBessa
            }
        , Talk
            { start = (eventTime 11 10)
            , end = (eventTime 12 0)
            , title = "UX: quem são, o que fazem, onde vivem?"
            , description = "\"Fazer UX\" está virando pré-requisito para desenvolver qualquer produto digital, mas o que está por trás disso? O que o mercado espera que a gente faça, como os chefes vendem o que a gente faz, o que os devs acham que a gente faz e o que a gente realmente faz (ou deveria fazer)."
            , author = biancaBrancaleone
            }
        , Talk
            { start = (eventTime 12 5)
            , end = (eventTime 12 30)
            , title = "WCAG 2.1"
            , description = "Nesta palestra serão apresentadas as primeiras atualizações da nova versão das Diretrizes de Acessibilidade para Conteúdo Web, as WCAG, e como elas podem impactar a acessibilidade nas páginas Web. Serão mostradas as principais mudanças propostas nesse primeiro Draft e como isso pode refletir no desenvolvimento front-end."
            , author = reinaldoFerraz
            }
        , Event
            { start = (eventTime 12 30)
            , end = Just (eventTime 14 0)
            , title = "Almoço"
            , comment = Nothing
            }
        , Talk
            { start = (eventTime 14 10)
            , end = (eventTime 14 50)
            , title = "Síndrome do impostor, um mal que nunca sai de moda"
            , description = "Você já teve a sensação que não é bom o suficiente para fazer o seu trabalho? Você já fingiu entender algo, mesmo sem entender nada? Você já teve medo de alguém descobrir que você é uma fraude? Que o código ou trabalho dos seus amigos é mais rápido ou melhor? Que você programa orientado ao Google? Então, talvez seja a hora de você entender melhor do que isso se trata e como vencer esse sentimento."
            , author = patriciaSilva
            }
        , Talk
            { start = (eventTime 15 0)
            , end = (eventTime 15 40)
            , title = "Renderizando componentes React no servidor"
            , description = "O ReactJS tem a poderosa habilidade de renderizar seus componentes no servidor. Nesta apresentação Bruno irá mostrar os benefícios e também como e quando podemos explorar esta prática."
            , author = brunoGenaro
            }
        , Talk
            { start = (eventTime 15 50)
            , end = (eventTime 16 10)
            , title = "Built for destruction: Preparando sua arquitetura de componentes para o refactor"
            , description = "Lições aprendidas ao criar um sistema de design auto documentável e de fácil refactor utilizando Functional CSS + React."
            , author = zehFernandes
            }
        , Talk
            { start = (eventTime 16 20)
            , end = (eventTime 16 50)
            , title = "What I learned interviewing for Front-end Developer roles"
            , description = "Linguagem JavaScript. Desafios de código. Complexidade de algoritmos. CSS. Web APIs. React. E mais. Os aprendizados obtidos nos processos de entrevista para grandes nomes da tecnologia. Tudo isto contado de forma divertida (deixando de lado algumas frustrações)."
            , author = jeanCarlo
            }
        , Event
            { start = (eventTime 17 0)
            , end = Just (eventTime 17 30)
            , title = "Coffee Break"
            , comment = Nothing
            }
        , Talk
            { start = (eventTime 17 30)
            , end = (eventTime 18 20)
            , title = "Vue.js, Vuex, Single Source of Truth e aplicações reais"
            , description = "O segredo para Single Page Applications bem sucedidas: o controle total sobre a informação carregada em memória. Esta palestra falará sobre gerenciamento centralizado do estado da aplicação."
            , author = fabioVedovelli
            }
        , Talk
            { start = (eventTime 18 30)
            , end = (eventTime 19 0)
            , title = "Aguardando"
            , description = ""
            , author = zenoRocha
            }
        , Event
            { start = (eventTime 19 0)
            , end = Nothing
            , title = "Party - Code In The Dark"
            , comment = Nothing
            }
        ]
    }


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
            [ div []
                [ time [] [ text startEnd ]
                , h4 [ class "f4 ma0 mb1" ] [ text title ]
                , div [] [ text comment ]
                ]
            ]


toHourAndMinute : Date -> String
toHourAndMinute date =
    Date.toFormattedString "H:mm" date


formatEventTime : Date -> Maybe Date -> String
formatEventTime start end =
    case end of
        Just e ->
            toHourAndMinute start
                ++ " ~ "
                ++ Date.toFormattedString "h.mm" e

        Nothing ->
            toHourAndMinute start


formatTalkTime : Date -> Date -> String
formatTalkTime start end =
    toHourAndMinute start
        ++ " ~ "
        ++ toHourAndMinute end


viewTalk talk =
    let
        startEnd =
            formatTalkTime talk.start talk.end

        title =
            talk.title

        authorName =
            talk.author.name
    in
        li [ class "pb3 flex" ]
            [ div []
                [ time [] [ text startEnd ]
                , h4 [ class "f4 ma0 mb1" ] [ text title ]
                , div [] [ text authorName ]
                ]
            ]


viewSchedule schedule =
    ul [ class "list pa0 ma0" ] <|
        List.map
            (\event ->
                case event of
                    Event e ->
                        viewEvent e

                    Talk t ->
                        viewTalk t
            )
            schedule


main =
    div []
        [ header [ class "pa3 pt4" ]
            [ h1 [ class "f2 ma0" ] [ text "Frontinsampa" ] ]
        , section [ class "pa3" ]
            [ h2 [ class "f2 ma0 mb3" ] [ text "Informações" ] ]
        , section [ class "pa3" ]
            [ h2 [ class "f2 ma0 mb3" ] [ text "Agenda" ]
            , viewSchedule initModel.schedule
            ]
        , footer [] []
        ]
