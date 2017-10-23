import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

main = 
    Html.beginnerProgram {model = model, view = view, update = update}

-- MODEL

type alias Model = 
    { name : String
    , password : String
    , passwordAgain : String
    , age : String
    }


model : Model
model = 
    Model "" "" "" ""

-- UPDATE

type Msg    
    = Name String   
    | Password String
    | PasswordAgain String
    | Age String

update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }

        Age age ->
            case String.toInt age of
                Ok val ->
                    { model | age = age }
                Err err ->
                    { model | age = "" }
                       

-- VIEW

view model = 
    div []
        [ input [type_ "text", placeholder "Name", onInput Name] []
        , input [type_ "password", placeholder "Password", onInput Password] []
        , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain] [] 
        , input [ type_ "text", placeholder "Age", onInput Age] []
        , viewValidation model
        ]

viewValidation : Model -> Html msg
viewValidation model = 
    let
        (color, message) = 
            if String.length model.password < 9 then
                ("red", "Password must be at least nine characters.")
            else if model.password /= model.passwordAgain then
                ("red", "Passwords do not match")
            else if model.age == "" then 
                ("red", "Please enter your age as a number." )
            else 
                ("green", "Ok.")
    
    in
        div [ style [("color", color)] ] [text message]
        
   