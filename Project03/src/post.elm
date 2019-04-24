module Login exposing (main)

import Browser
import Browser.Navigation exposing (load)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events
import Http
import Json.Decode as JDecode
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
    { title : String, price : String, description : String,  phnum : String, error : String, failed :String }


type Msg
    = NewTitle String -- Name text field changed
    | NewPrice String
    | NewDescription String -- Password text field changed
    | NewPhnum String -- Password text field changed
    | GotLoginResponse (Result Http.Error String) -- Http Post Response Received
    | LoginButton -- Login Button Pressed


init : () -> ( Model, Cmd Msg )
init _ =
    ( { title = ""
      , price = ""
      , description = ""
      , phnum = ""
      , error = ""
      , failed = "Post!"
      }
    , auth
    )
    
auth : Cmd Msg
auth = 
    Http.get { 
            url = rootUrl ++ "userauthapp/userinfo/",
            expect = Http.expectString GotLoginResponse
        }


-- View
view : Model -> Html Msg
view model = div []
    [ node "link" [ href "css/bootstrap.min.css", rel "stylesheet" ]
        []
    , node "link" [ href "css/bootstrap-select.css", rel "stylesheet" ]
        []
    , node "link" [ href "css/style.css", media "all", rel "stylesheet", type_ "text/css" ]
        []
    , text "				"
    , node "link" [ href "css/jquery.uls.css", rel "stylesheet" ]
        []
    , text "	"
    , node "link" [ href "css/jquery.uls.grid.css", rel "stylesheet" ]
        []
    , text "	"
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
                , div [ class "selectregion" ]
                    [ div [ attribute "aria-hidden" "true", attribute "aria-labelledby" "myLargeModalLabel", class "modal fade", id "myModal", attribute "role" "dialog", attribute "tabindex" "-1" ]
                        [ div [ class "modal-dialog modal-lg" ]
                            [ div [ class "modal-content" ]
                                [ div [ class "modal-header" ]
                                    []
                                , div [ class "modal-body" ]
                                    [ Html.form [ class "form-horizontal", attribute "role" "form" ]
                                        [ div [ class "form-group" ]
                                            []
                                        ]
                                    ]
                                ]
                            ]
                        ]
                    ]
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
                [ text "Lorem Ipsum is simply dummy text of the printing and typesetting industry" ]
            , a [ href "post-ad.html" ]
                [ text "Post Free Ad" ]
            ]
        ]
    , div [ class "submit-ad main-grid-border" ]
        [ div [ class "container" ]
            [ h2 [ class "head" ]
                [ text "Post an Ad" ]
            , div [ class "post-ad-form" ]
                [ Html.form []
                    [ label []
                        [ text "Select Category "
                        , span []
                            [ text "*" ]
                        ]
                    , select [ class "" ]
                        [ option []
                            [ text "Select Category" ]
                        , option []
                            [ text "Mobiles" ]
                        , option []
                            [ text "Electronics and Appliances" ]
                        , option []
                            [ text "Cars" ]
                        , option []
                            [ text "Bikes" ]
                        , option []
                            [ text "Furniture" ]
                        , option []
                            [ text "Pets" ]
                        , option []
                            [ text "Books, Sports and hobbies" ]
                        , option []
                            [ text "Fashion" ]
                        , option []
                            [ text "Kids" ]
                        , option []
                            [ text "Services" ]
                        , option []
                            [ text "Real, Estate" ]
                        ]
                    , div [ class "clearfix" ]
                        []
                    , label []
                        [ text "Ad Title "
                        , span []
                            [ text "*" ]
                        ]
                        
                    , viewInput "title" "Put the title of you add here" model.title NewTitle
                    , div [ class "clearfix" ]
                        []

                    , label []
                        [ text "Price "
                        , span []
                            [ text "*" ]
                        ]
                        
                    , viewInput "price" "$" model.title NewTitle
                    , div [ class "clearfix" ]
                        []

                    , label []
                        [ text "Ad Description "
                        , span []
                            [ text "*" ]
                        ]
                    ,viewInput "description" "Decribe your product" model.description NewDescription
                    , div [ class "clearfix" ]
                        []
                    , div [ class "upload-ad-photos" ]
                        [ label []
                            [ text "Photos for your ad :" ]
                        , div [ class "photos-upload-view" ]
                            [ Html.form [ action "index.html", enctype "multipart/form-data", id "upload", method "POST" ]
                                [ input [ id "MAX_FILE_SIZE", name "MAX_FILE_SIZE", type_ "hidden", value "300000" ]
                                    []
                                , div []
                                    [ input [ id "fileselect", attribute "multiple" "multiple", name "fileselect[]", type_ "file" ]
                                        []
                                    , div [ id "filedrag" ]
                                        [ text "or drop files here" ]
                                    ]
                                , div [ id "submitbutton" ]
                                    [ button [ type_ "submit" ]
                                        [ text "Upload Files" ]
                                    ]
                                ]
                            -- , div [ id "messages" ]
                            --     [ p []
                            --         [ text "Status Messages" ]
                            --     ]
                            ]
                        , div [ class "clearfix" ]
                            []
                        , node "script" [ src "js/filedrag.js" ]
                            []
                        ]
                    , div [ class "personal-details" ]
                        [ Html.form []
                            -- [ label []
                            --     [ text "Your Name "
                            --     , span []
                            --         [ text "*" ]
                            --     ]
                            -- ,viewInput "name" "Enter your name here" model.name NewName
                            -- , div [ class "clearfix" ]
                            --     []
                            [ label []
                                [ text "Your Phone Number "
                                , span []
                                    [ text "" ]
                                ]
                            ,viewInput "phnumber" "Optional" model.phnum NewPhnum
                            , div [ class "clearfix" ]
                                []
                            -- , label []
                            --     [ text "Your Email Address"
                            --     , span []
                            --         [ text "*" ]
                            --     ]
                            -- , input [ class "email", placeholder "", type_ "text" ]
                            --     []
                            -- , div [ class "clearfix" ]
                            --     []
                            , p [ class "post-terms" ]
                                [ text "By clicking "
                                , strong []
                                    [ text "post Button" ]
                                , text "you accept our "
                                , a [ href "terms.html", target "_blank" ]
                                    [ text "Terms of Use " ]
                                , text "and "
                                , a [ href "privacy.html", target "_blank" ]
                                    [ text "Privacy Policy" ]
                                ]
                            , input [ type_ "submit",  value model.failed, Events.onClick LoginButton ]
                                []
                            , div [ class "clearfix" ]
                                []
                            ]
                        ]
                    ]
                ]
            ]
        , text "		"
        , footer []
            [ div [ class "footer-bottom text-center" ]
                [ div [ class "container" ]
                    [ div [ class "footer-logo" ]
                        [ a [ href "index.html" ]
                            [ span []
                                [ text "Re" ]
                            , text "sale"
                            ]
                        ]
                    , div [ class "footer-social-icons" ]
                        [ ul []
                            [ li []
                                [ a [ class "facebook", href "#" ]
                                    [ span []
                                        [ text "Facebook" ]
                                    ]
                                ]
                            , li []
                                [ a [ class "twitter", href "#" ]
                                    [ span []
                                        [ text "Twitter" ]
                                    ]
                                ]
                            , li []
                                [ a [ class "flickr", href "#" ]
                                    [ span []
                                        [ text "Flickr" ]
                                    ]
                                ]
                            , li []
                                [ a [ class "googleplus", href "#" ]
                                    [ span []
                                        [ text "Google+" ]
                                    ]
                                ]
                            , li []
                                [ a [ class "dribbble", href "#" ]
                                    [ span []
                                        [ text "Dribbble" ]
                                    ]
                                ]
                            ]
                        ]
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
        , text "	"
        ]
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


passwordEncoder : Model -> JEncode.Value
passwordEncoder model =
    JEncode.object
        [ ( "title"
          , JEncode.string model.title
          )
        ,( "price"
          , JEncode.string model.price
          )
        , ( "description"
            , JEncode.string model.description
            )
        , ( "phnum"
            , JEncode.string model.phnum
            )

    
        ]

loginPost : Model -> Cmd Msg
loginPost model =
    Http.post
        { url = rootUrl ++ "userauthapp/postadd/"
        , body = Http.jsonBody <| passwordEncoder model
        , expect = Http.expectString GotLoginResponse
        }



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
            ( model, loginPost model )

        GotLoginResponse result ->
            case result of
                Ok "LoginFailed" ->
                    ( { model | error = "failed to login", failed = "Login failed, try again :(" }, Cmd.none )
                
                Ok "Success" ->
                    ( { model | error = "Success", failed = "Success" }, Cmd.none )

                Ok _ ->
                    ( model, load ("https://google.com") )

                Err error ->
                    ( handleError model error, Cmd.none )



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