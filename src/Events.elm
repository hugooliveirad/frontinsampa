module Events exposing (..)

import Author exposing (..)
import Date exposing (Date)
import DateHelpers exposing (..)
import MaybeZipper exposing (MaybeZipper)


type Kind
    = Development
    | Other


kindToClass : Kind -> String
kindToClass kind =
    case kind of
        Development ->
            "bg-blue white"

        Other ->
            "bg-green white"


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
        , kind : Kind
        }


type alias Events =
    MaybeZipper Event


schedule : Events
schedule =
    MaybeZipper.fromList
        [ Event
            { start = (eventTime 8 0)
            , end = Just (eventTime 9 20)
            , title = "Credenciamento"
            , comment = Just "Não esqueça seu RG"
            }
        , Talk
            { start = (eventTime 9 20)
            , end = (eventTime 9 30)
            , title = "Apresentação"
            , description = ""
            , author = matheusMarsiglio
            , kind = Other
            }
        , Talk
            { start = (eventTime 9 30)
            , end = (eventTime 10 10)
            , title = "CSS Tips"
            , description = "Muitos de nós já perdemos a paciência com CSS pelo menos uma vez na vida. No entanto, já também demos aquele suspiro de alívio quando conseguimos resolver um determinado problema ou bug. Fácil de aprender e difícil de dominar, o CSS é uma linguagem de fácil acesso e que esconde diversos segredos. Nessa talk, iremos abordar algumas dicas de alguém que já perdeu a paciência algumas vezes com CSS mas que ainda o ama. Sem ressentimentos."
            , author = raphaelFabeni
            , kind = Development
            }
        , Talk
            { start = (eventTime 10 20)
            , end = (eventTime 11 0)
            , title = "Webapps confiáveis com Elm"
            , description = "Interfaces de usuário podem ser simples e confiáveis utilizando a ferramenta correta. Elm ajuda a impedir erros de execução e torna o processo de desenvolvimento mais simples. A simplicidade do Elm o ajuda a criar webapps à prova de balas e torna seu processo de desenvolvimento muito mais divertido."
            , author = hugoBessa
            , kind = Development
            }
        , Talk
            { start = (eventTime 11 10)
            , end = (eventTime 12 0)
            , title = "UX: quem são, o que fazem, onde vivem?"
            , description = "\"Fazer UX\" está virando pré-requisito para desenvolver qualquer produto digital, mas o que está por trás disso? O que o mercado espera que a gente faça, como os chefes vendem o que a gente faz, o que os devs acham que a gente faz e o que a gente realmente faz (ou deveria fazer)."
            , author = biancaBrancaleone
            , kind = Other
            }
        , Talk
            { start = (eventTime 12 5)
            , end = (eventTime 12 30)
            , title = "WCAG 2.1"
            , description = "Nesta palestra serão apresentadas as primeiras atualizações da nova versão das Diretrizes de Acessibilidade para Conteúdo Web, as WCAG, e como elas podem impactar a acessibilidade nas páginas Web. Serão mostradas as principais mudanças propostas nesse primeiro Draft e como isso pode refletir no desenvolvimento front-end."
            , author = reinaldoFerraz
            , kind = Development
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
            , kind = Other
            }
        , Talk
            { start = (eventTime 15 0)
            , end = (eventTime 15 40)
            , title = "Renderizando componentes React no servidor"
            , description = "O ReactJS tem a poderosa habilidade de renderizar seus componentes no servidor. Nesta apresentação Bruno irá mostrar os benefícios e também como e quando podemos explorar esta prática."
            , author = brunoGenaro
            , kind = Development
            }
        , Talk
            { start = (eventTime 15 50)
            , end = (eventTime 16 10)
            , title = "Built for destruction: Preparando sua arquitetura de componentes para o refactor"
            , description = "Lições aprendidas ao criar um sistema de design auto documentável e de fácil refactor utilizando Functional CSS + React."
            , author = zehFernandes
            , kind = Development
            }
        , Talk
            { start = (eventTime 16 20)
            , end = (eventTime 16 50)
            , title = "What I learned interviewing for Front-end Developer roles"
            , description = "Linguagem JavaScript. Desafios de código. Complexidade de algoritmos. CSS. Web APIs. React. E mais. Os aprendizados obtidos nos processos de entrevista para grandes nomes da tecnologia. Tudo isto contado de forma divertida (deixando de lado algumas frustrações)."
            , author = jeanCarlo
            , kind = Development
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
            , kind = Development
            }
        , Talk
            { start = (eventTime 18 30)
            , end = (eventTime 19 0)
            , title = "Aguardando"
            , description = ""
            , author = zenoRocha
            , kind = Other
            }
        , Event
            { start = (eventTime 19 0)
            , end = Nothing
            , title = "Party - Code In The Dark"
            , comment = Nothing
            }
        ]
