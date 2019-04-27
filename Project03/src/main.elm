module Login exposing (main)

import Browser
import Browser.Navigation exposing (load)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events
import Http
import Json.Decode as JD exposing (field, Decoder, int, string)
import Json.Encode as JEncode
import String


-- TODO adjust rootUrl as needed


rootUrl =
    "http://localhost:8000/"



-- rootUrl = "https://mac1xa3.ca/e/macid/"


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }



{- -------------------------------------------------------------------------------------------
   - Model
   --------------------------------------------------------------------------------------------
-}


type alias Model =
    { title : String, price : String, description : String,  
    phnum : String, error : String, failed :List String, pressed :Bool, 
    addInfo: AddInfo }

type alias AddInfo = {
        title : List String, 
        price : List String, 
        description : List String,
        phnum : List String
    }

type Msg
    = NewTitle String -- Name text field changed
    | NewPrice String
    | NewDescription String -- Password text field changed
    | NewPhnum String -- Password text field changed
    | GotLoginResponse (Result Http.Error AddInfo) -- Http Post Response Received
    | AuthResponse (Result Http.Error String) -- Http Post Response Received
    | LoginButton -- Login Button Pressed


init : () -> ( Model, Cmd Msg )
init _ =
    ( { title = ""
      , price = ""
      , description = ""
      , phnum = ""
      , error = ""
      , failed = ["Post!","egg"]
      , pressed = False
      , addInfo = {title = [], price = [], description = [], phnum = []}
      }
    , auth
    )

getAt : Int -> List a -> Maybe a
getAt idx xs =
    if idx < 0 then
        Nothing

    else
        List.head <| List.drop idx xs

renderList : List String -> Html msg
renderList lst =
    ul []
        (List.map (\l -> li [] [ text l ]) lst)

-- formatList : String -> Html mssg
-- formatList l = 
--     [ h5 [ class "title" ]
--         [ text l ]

auth : Cmd Msg
auth = 
    Http.get { 
            url = rootUrl ++ "userauthapp/userinfo/",
            expect = Http.expectString AuthResponse
        }

-- View
view : Model -> Html Msg
view model = div []
    [ node "title" []
        [ text "Resale a Business Category Flat Bootstrap Responsive Website Template | All Classifieds :: w3layouts" ]
    , node "link" [ href "css/bootstrap.min.css", rel "stylesheet" ]
        []
    , node "link" [ href "css/bootstrap-select.css", rel "stylesheet" ]
        []
    , node "link" [ href "css/style.css", media "all", rel "stylesheet", type_ "text/css" ]
        []
    , node "link" [ href "css/jquery-ui1.css", rel "stylesheet", type_ "text/css" ]
        []
    , text ""
    , node "script" [ src "js/jquery.leanModal.min.js", type_ "text/javascript" ]
        []
    , node "link" [ href "css/jquery.uls.css", rel "stylesheet" ]
        []
    , text ""
    , node "link" [ href "css/jquery.uls.grid.css", rel "stylesheet" ]
        []
    , text ""
    , node "link" [ href "css/jquery.uls.lcd.css", rel "stylesheet" ]
        []
    , div [ class "header" ]
        [ div [ class "container" ]
            [ div [ class "logo" ]
                [ a [ href "index.html" ]
                    [ span []
                        [ text "Re" ]
                    , text "sale"
                    ]
                ]
            , div [ class "header-right" ]
                [ a [ class "account", href "login.html" ]
                    [ text "My Account" ]
                ]
            ]
        ]
    , div [ class "banner text-center" ]
        [ div [ class "container" ]
            [ h1 []
                [ text "Sell or Advertise   "
                , span [ class "segment-heading" ]
                    [ text "anything online " ]
                , text "with Resale"
                ]
            
            , p []
                [ text "poop" ]
            , a [ href "post-ad.html" ]
                [ text "Post Free Ad" ]
            ]
        ]
    , div [ class "total-ads main-grid-border" ]
        [ div [ class "container" ]
            [ div [ class "ads-grid" ]
                [ div [ class "ads-display col-md-9" ]
                    [ div [ class "wrapper" ]
                        [ div [ class "bs-example bs-example-tabs", attribute "data-example-id" "togglable-tabs", attribute "role" "tabpanel" ]
                            [ ul [ class "nav nav-tabs nav-tabs-responsive", id "myTab", attribute "role" "tablist" ]
                                [ li [ class "active", attribute "role" "presentation" ]
                                    [ a [ attribute "aria-controls" "home", attribute "aria-expanded" "true", attribute "data-toggle" "tab", href "#home", id "home-tab", attribute "role" "tab" ]
                                        [ span [ class "text" ]
                                            [ text "All Ads" ]
                                        ]
                                    ]
                                , li [ class "next", attribute "role" "presentation" ]
                                    []
                                , li [ attribute "role" "presentation" ]
                                    []
                                ]
                            , div [ class "tab-content", id "myTabContent" ]
                                [ div [ attribute "aria-labelledby" "home-tab", class "tab-pane fade in active", id "home", attribute "role" "tabpanel" ]
                                    [ div []
                                        [ div [ id "container" ]
                                            [ ul [ class "list" ]
                                                [ li []
                                                    [ img [ alt "", src "images/m1.jpg", title "" ]
                                                        []
                                                    , section [ class "list-left" ]
                                                        [ h5 [ class "title" ]
                                                            [ text "There are many variations of passages of Lorem Ipsum" ]
                                                        , span [ class "adprice" ]
                                                            [ text "$290" ]
                                                        , p [ class "catpath" ]
                                                            [ text "Mobile Phones » Brand" ]
                                                        ]
                                                    , section [ class "list-right" ]
                                                        [ span [ class "date" ]
                                                            [ text "Today, 17:55" ]
                                                        , span [ class "cityname" ]
                                                            [ text "City name" ]
                                                        ]
                                                    , div [ class "clearfix" ]
                                                        []
                                                    ]
                                                , div [ class "clearfix" ]
                                                    []
                                                ]
                                                , renderList model.failed
                                            ]
                                        ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                , div [ class "clearfix" ]
                    []
                ]
            ]
        ]
    , text "	"
    , footer []
        [ div [ class "footer-top" ]
            []
        , div [ class "footer-bottom text-center" ]
            [ div [ class "container" ]
                [ div [ class "footer-logo" ]
                    []
                , div [ class "copyrights" ]
                    [ p []
                        [ text "© 2019 Resale. All Rights Reserved | Design by  "
                        , a [ href "http://w3layouts.com/" ]
                            [ text "W3layouts" ]
                        ]
                    ]
                , div [ class "clearfix" ]
                    []
                ]
            ]
        ]
    , text ""
    ]

viewInput : String -> String -> String -> (String -> Msg) -> Html Msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, Events.onInput toMsg ] []


{- -------------------------------------------------------------------------------------------
   - JSON Encode/Decode
   -   passwordEncoder turns a model name and password into a JSON value that can be used with
   -   Http.jsonBody
   --------------------------------------------------------------------------------------------
-}





{- -------------------------------------------------------------------------------------------
   - Update
   -   Sends a JSON Post with currently entered username and password upon button press
   -   Server send an Redirect Response that will automatically redirect to UserPage.html
   -   upon success
   --------------------------------------------------------------------------------------------
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewTitle title ->
            ( { model | title = title }, Cmd.none )
            
        NewPrice price ->
            ( { model | price = price }, Cmd.none )

        NewDescription description ->
            ( { model | description = description }, Cmd.none )
            
    
        NewPhnum phnum ->
            ( { model | phnum = phnum }, Cmd.none )


        LoginButton ->
             ( model, Cmd.none )
            
        AuthResponse result ->
            case result of
                Ok "LoginFailed" ->
                    ( model, load ("login.html") )
                Ok "Auth" ->
                    ( model,  getAllAdds)
                Ok _ ->
                    ( model, Cmd.none )

                Err error ->
                    ( handleError model error, Cmd.none )


        GotLoginResponse result ->
            case result of
                Ok info ->
                    ( { model | failed = info.title }, Cmd.none )

                Err error ->
                    ( handleError model error, Cmd.none )

infoJsonD : Decoder AddInfo  
infoJsonD = 
    JD.map4 AddInfo  
        (field "title" listDecoder)
        (field "price" listDecoder)
        (field "description" listDecoder)
        (field "phnum" listDecoder)
listDecoder : Decoder (List String)
listDecoder = JD.list JD.string

getAllAdds : Cmd Msg
getAllAdds =
    Http.get 
        { url = rootUrl ++ "userauthapp/getadds/"
        , expect = Http.expectJson GotLoginResponse infoJsonD
        }

-- put error message in model.error_response (rendered in view)


handleError : Model -> Http.Error -> Model
handleError model error =
    case error of
        Http.BadUrl url ->
            { model | error = "bad url: " ++ url }

        Http.Timeout ->
            { model | error = "timeout" }

        Http.NetworkError ->
            { model | error = "network error" }

        Http.BadStatus i ->
            { model | error = "bad status " ++ String.fromInt i }

        Http.BadBody body ->
            { model | error = "bad body " ++ body }