module Model exposing (..)
import Animation exposing (percent,px,turn)
import Array exposing (Array)
import Draggable
import Html exposing (Html, div, img)
import Html.Attributes as A exposing (src)
import Message exposing (Msg)

type alias Model =
    { tools : List Tool
    , drag : Draggable.State String
    , indexNum : Int
    , size : ( Float, Float )
    , boardAppear : Bool
    , mouseX : Float
    , mouseY : Float
    , clicked : Bool
    , button1 : Bool
    , dialogEnd : Bool
    , dialogID : Int
    , value1 : String
    , value2 : String
    , value3 : String
    , value4 : String
    , value5 : String
    , value6 : String
    , value7 : String
    , value8 : String
    , value9 : String
    , value10 : String
    , value11 : String
    , value12 : String
    , value13 : String
    , value14 : String
    , showCursor : Bool
    , cursor : String
    , inProcess : String
    , cursorOn : Bool
    , rain: Bool
    , showRain : Bool
    , scene : Int
    , transition1 : Bool
    , transition1Times : Int
    , endTransition1 : Bool
    , transition2 : Bool
    , transition2Times : Int
    , endTransition2  : Bool
    , askDrunk : Bool
    , content : String
    , showBarOptions : Bool
    , showMixDrink : Bool
    , askOwnerTimes : Int
    , askWarehouseTimes : Int
    , style1 : Animation.State
    , style2 : Animation.State
    , style3 : Animation.State
    , showPiano : Bool
    , pianoValue : String
    , pressedC : Bool
    , pressedD : Bool
    , pressedE : Bool
    , pressedF : Bool
    , pressedG : Bool
    , pressedA : Bool
    , pressedB : Bool
    , page : Pagestate
    , pipes : Array Pipe
    , status : State
    , worldmap : Worldmap
    --,ball : Ball
    --,cityColor : String ----in world map
    , cityColorArray : Array String
    , cityPositionArrayx : Array Int
    , cityPositionArrayy: Array Int
    , state : State
    , firstClick : Bool
    , indexpc: (Int,Int)------
    , sodoBlock : Array SokoBlock
    , sodoPos : (Int,Int)
    , face : Direction
    }

type State
    = Playing
    | Win
    | Playing_w
    | Win_w
    | MapWin
    | MapLose

type Pagestate
    = FirstPage
    | Feature1
    | Feature2
    | Feature3
    | Feature4

type Direction
    = Up
    | Down
    | Left
    | Right

type alias Position =
    { x : Float
    , y : Float
    }

type TypedKey
  = Untyped Char
  | Matched Char
  | Wrong Char Char -- 1: Expected, 2: Typed
  | Excess Char


type FullZipItem a b
  = First a
  | Second b
  | Both a b

type Orientation
    = FaceLeft
    | FaceRight
    | FaceUp
    | FaceDown


type Status
    = Unfound
    | Stored
    | Used

type alias Tool =
    { xy : Position
    , clicksCount : Int
    , isDragging : Bool
    , isClicked : Bool
    , id : Int
    , index : Int
    , status : Status
    , originScene : Int
    , targetScene : Int
    }

initialTool : List Tool
initialTool =
    [initialTool0, initialTool1,initialTool2,initialTool3]

initialTool0: Tool
initialTool0 =
    { xy = Position 367 173
    , clicksCount = 0
    , isDragging = False
    , isClicked = False
    , id = 0
    , index = 0
    , status = Unfound
    , originScene = 0
    , targetScene = 0
    }

initialTool1 : Tool
initialTool1 =
    { xy = Position 32 100
    , clicksCount = 0
    , isDragging = False
    , isClicked = False
    , id = 1
    , index = 0
    , status = Unfound
    , originScene = 0
    , targetScene = 0
    }

initialTool2 : Tool
initialTool2 =
    { xy = Position 232 150
    , clicksCount = 0
    , isDragging = False
    , isClicked = False
    , id = 2
    , index = 0
    , status = Unfound
    , originScene = 0
    , targetScene = 0
    }


initialTool3 : Tool
initialTool3 =
    { xy = Position 400 150
    , clicksCount = 0
    , isDragging = False
    , isClicked = False
    , id = 3
    , index = 0
    , status = Unfound
    , originScene = 0
    , targetScene = 0
    }

initialStyle =
    Animation.style
                [ Animation.display Animation.inlineBlock
                , Animation.width (px 100)
                , Animation.height (px 100)
                , Animation.margin (px 50)
                , Animation.padding (px 25)
                , Animation.rotate (turn 0.0)
                , Animation.rotate3d (turn 0.0) (turn 0.0) (turn 0.0)
                , Animation.translate (px 0) (px 0)
                , Animation.opacity 1
                , Animation.scale 1.0
                , Animation.translate3d (percent 0) (percent 0) (px 0)
                , Animation.shadow
                    { offsetX = 0
                    , offsetY = 1
                    , size = 0
                    , blur = 2
                    , color =  { red = 0, blue = 0, green = 0, alpha = 0.1 }
                    }
                ]

defaultCursor : String
defaultCursor =
  String.fromChar <| Char.fromCode 9608

nbspChar : String
nbspChar =
  String.fromChar <| Char.fromCode 160



demopipes : Array Pipe
demopipes =
    Array.fromList [generatePipe ("400px","20px") (Circular 1),  generatePipe ("500px","20px") Updown , generatePipe ("600px","20px") Updown
                   ,generatePipe ("700px","20px") LeftRight , generatePipe ("800px","20px") (Circular 2), generatePipe ("400px","80px") LeftRight
                   ,generatePipe ("500px","80px") Empty , generatePipe ("600px","80px") Empty
                   ,generatePipe ("700px","80px") Empty , generatePipe ("800px","80px") LeftRight
                   ,generatePipe ("400px","140px") (Circular 1),  generatePipe ("500px","140px") Updown , generatePipe ("600px","140px") Updown
                   ,generatePipe ("700px","140px") LeftRight , generatePipe ("800px","140px") (Circular 2)
                   ]

type alias Pipe =
    { pos : (String, String)
    , category : PipeType
    }

getPos : Maybe Pipe -> (String,String)
getPos p =
    case p of
        Just p1 ->
            p1.pos
        Nothing ->
            ("0px","0px")

type PipeType
    = Updown
    | LeftRight
    | Circular Int
    | Empty



backgroundForPipes : Maybe Pipe -> String
backgroundForPipes a =
    case a of
        Just b ->
            case b.category of
                Empty ->
                    "url(resources/Empty.png)"
                Updown->
                    "url(resources/Updown.png)"
                Circular num->
                    case num of
                        1 ->
                            "url(resources/Circle1.png)"
                        2 ->
                            "url(resources/Circle2.png)"
                        3 ->
                            "url(resources/Circle3.png)"
                        4 ->
                            "url(resources/Circle4.png)"
                        _ ->
                            "url(resources/Empty.png)"
                LeftRight ->
                        "url(resources/leftright.png)"
        Nothing ->
             "url(resources/Empty.png)"


generatePipe : (String, String) -> PipeType ->Pipe
generatePipe (x,y) t =
    { pos = (x,y)
    , category = t
    }

rotatePipe : Maybe Pipe -> Pipe
rotatePipe p1  =
    case p1 of
        Just p ->
            case p.category of
                Updown ->
                    {p|category = LeftRight}
                LeftRight ->
                    {p|category = Updown}
                Circular num ->
                    case num of
                        1 ->
                         {p|category = Circular 2}
                        2 ->
                            {p|category = Circular 3}
                        3 ->
                            {p|category = Circular 4}
                        _ ->
                            {p|category = Circular 1}
                Empty ->
                    p
        Nothing ->
            generatePipe ("0px","0px") Empty

type alias SokoBlock =
    { category : SokoType
    , rank : (Int, Int)
    , backgroundnum : Int
    , hasBlock: Bool
    , hasCharacter: Bool
    }

type SokoType
    = Blank1
    | Blank2
    | Wall
    | Void

type alias Rect =
    { width : Int
    , height : Int
    , centerPos : (Float, Float)
    }
{-
getLeftTop : Rect-> (Float, Float)
getLeftTop rect =
    (Tuple.first rect.centerPos - toFloat rect.width / 2, Tuple.second rect.centerPos - toFloat rect.height / 2)
-}
generateSoko : Int->Int->Int->Bool->Bool -> SokoType -> SokoBlock
generateSoko x y z c b t =
    {category = t
    ,rank = (x,y)
    ,backgroundnum = z
    ,hasCharacter = c
    ,hasBlock = b
    }

demoBlock : Array SokoBlock
demoBlock =
    Array.fromList [generateSoko 1 1 0 False False Blank1, generateSoko  1 2 0 False False Blank1 , generateSoko 1 3 0 False False Blank1 , generateSoko 1 4 0 False False Blank1 ,generateSoko 1 5 0 False False Blank1
                   ,generateSoko 1 6 0 False False Blank1, generateSoko 1 7 0 False False Blank1 , generateSoko 1 8 0 False False Blank1 ,generateSoko 1 9 0 False False Blank1,generateSoko 1 10 0 False False Blank1
                   ,generateSoko 2 1 0  False False Wall, generateSoko 2 2 0 False False Blank1 , generateSoko 2 3 0 False False Blank1, generateSoko 2 4 0  False False Blank1 ,generateSoko 2 5 0 False False Blank1
                   ,generateSoko 2 6 0 False False Wall, generateSoko 2 7 0 False False Blank1 , generateSoko 2 8 0 False False Blank1, generateSoko 2 9 0 False False Blank1 ,generateSoko 2 10 0 False False Blank1
                   ,generateSoko 3 1 0 False False Void, generateSoko 3 2 0 False False Blank1 , generateSoko 3 3 0 False False Blank1 , generateSoko 3 4 0 False False Blank1 ,generateSoko 3 5 0 False False Blank1
                   ,generateSoko 3 6 5 False False Void, generateSoko 3 7 0 False False Blank1 , generateSoko 3 8 0 False False Blank1 , generateSoko 3 9 0 False False Blank1 ,generateSoko 3 10 0 False False Blank1
                   ,generateSoko 4 1 0 False False Void, generateSoko 4 2 0 False False Blank1, generateSoko 4 3 0 False False Blank1, generateSoko  4 4 0  True False Blank1 ,generateSoko  4 5 0 False True Blank1
                   ,generateSoko 4 6 0 False False Void, generateSoko 4 7 0 False False Blank1, generateSoko 4 8 0  False False Blank1, generateSoko  4 9 0  False False Blank1 ,generateSoko 4 10 0 False False Blank1
                   ,generateSoko 5 1 0 False False Void, generateSoko 5 2 0 False False Blank1 , generateSoko 5 3 0 False False Blank1, generateSoko 5 4 0 False False Blank1 ,generateSoko 5 5 0  False False Blank1
                   ,generateSoko 5 6 0 False False Void, generateSoko 5 7 0 False False Blank1 , generateSoko 5 8 0 False False Blank1, generateSoko 5 9 0  False False Blank1,generateSoko 5 10 0 False False Blank1
                   ,generateSoko 6 1 0 False False Void ,generateSoko 6 2 0 False False Blank1 , generateSoko 6 3 0 False False Blank1 , generateSoko  6 4 0 False False Blank1 ,generateSoko 6 5 0 False False Blank1
                   ,generateSoko 6 6 0 False False Void, generateSoko 6 7 0 False True Blank1 , generateSoko 6 8 0 False False Blank1 , generateSoko 6 9 0 False False Blank1 ,generateSoko 6 10 0 False False Blank1
                   ,generateSoko 7 1 0 False False Void, generateSoko 7 2 0 False True Blank1 , generateSoko 7 3 0 False False Blank1 , generateSoko 7 4 0  False False Blank1 ,generateSoko 7 5 0 False False Blank1
                   ,generateSoko 7 6 0 False False Void, generateSoko 7 7 0 False False Blank1 , generateSoko 7 8 0 False False Blank1, generateSoko 7 9 0 False False Blank1 ,generateSoko 7 10 0  False False Blank1
                   ,generateSoko 8 1 0 False False Wall, generateSoko 8 2 0 False False Blank1 , generateSoko 8 3 0 False False Blank1, generateSoko 8 4 0 False False Blank1 ,generateSoko 8 5 0 False False Blank1
                   ,generateSoko 8 6 0 False False Wall, generateSoko 8 7 0 False False Blank1, generateSoko 8 8 0 False False Blank1 , generateSoko 8 9 0 False False Blank1 ,generateSoko 8 10 0 False False Blank1
                   ,generateSoko 9 1 0 False False Wall, generateSoko 9 2 0 False False Blank1 , generateSoko 9 3 0 False False Blank1, generateSoko  9 4 0 False False Blank1,generateSoko 9 5 0 False False Blank1
                   ,generateSoko 9 6 0 False False Wall, generateSoko 9 7 0 False False Blank1 , generateSoko 9 8 0 False False Blank1, generateSoko 9 9 0 False False Blank1 ,generateSoko 9 10 0 False False Blank1
                   ,generateSoko 10 1 0 False False Wall, generateSoko 10 2 0 False False Wall , generateSoko 10 3 0 False False Wall , generateSoko 10 4 0 False False Wall ,generateSoko 10 5 0 False False Wall
                   ,generateSoko 10 6 0 False False Wall, generateSoko 10 7 0 False False Wall , generateSoko 10 8 0 False False Wall , generateSoko 10 9 0 False False Wall ,generateSoko  10 10 0 False False Wall
                   ]


addSokoBackground : SokoBlock -> String
addSokoBackground s =
    case s.category of
        Blank1 ->
            "resources/Blankbackground"++(String.fromInt s.backgroundnum)++".png"
        Blank2 ->
            "resources/Blankbackground"++(String.fromInt s.backgroundnum)++".gif"
        Wall ->
            "resources/Wall.png"
        Void ->
            "resources/River"++(String.fromInt s.backgroundnum)++".png"


getCharacter : Model -> String
getCharacter model =
    case model.face of
        Up ->
           "resources/Character4.png"
        Down ->
           "resources/Character3.png"
        Left ->
           "resources/Character2.png"
        Right ->
           "resources/Character1.png"


sokodisplay:  (Int,Int) -> SokoBlock  -> Model ->  Html Msg
sokodisplay (x,y) s model =
    let
        (x2,y2) =s.rank
        x0 = getCentral x
        y0 = getCentral y
        x1= 450+80*(x0- x2)
        y1= 600+ 86*(y0- y2)
    in
        if (x2<=x0+2&&x2>=x0 - 2 && y2<=y0+2&&y2>=y0 - 2) then
            if s.hasCharacter== True then
            div
            [A.style "position" "absolute"
            , A.style "left" ((String.fromInt x1)++"px")
            , A.style "top"  ((String.fromInt y1)++"px")
            , A.style "width" "80px"
            , A.style "height" "86px"
            , A.style "background-size" "contain"
            , A.style "background-repeat" "no-repeat"
            , A.style "background-position" "absolute"
            , A.style "background" ("url("++(addSokoBackground s) ++ ")")
            ]
            [(img
                    [ A.style "position" "absolute"
                    , A.style "width" "80px"
                    , A.style "height" "86px"
                    , src  (getCharacter model)][])
            ]
            else if s.hasBlock == True then
            div
            [A.style "position" "absolute"
            , A.style "left" ((String.fromInt x1)++"px")
            , A.style "top"  ((String.fromInt y1)++"px")
            , A.style "width" "80px"
            , A.style "height" "86px"
            , A.style "background-size" "contain"
            , A.style "background-repeat" "no-repeat"
            , A.style "background-position" "absolute"
            , A.style "background" ("url("++(addSokoBackground s) ++ ")")
            ]
            [(img
                    [ A.style "position" "absolute"
                    , A.style "width" "80px"
                    , A.style "height" "86px"
                    , src  ("resources/Block.png")][])
            ]
            else
            div
            [A.style "position" "absolute"
            , A.style "left" ((String.fromInt x1)++"px")
            , A.style "top"  ((String.fromInt y1)++"px")
            , A.style "width" "80px"
            , A.style "height" "86px"
            , A.style "background-size" "100% 100%"
            , A.style "background-size" "contain"
            , A.style "background-position" "absolute"
            , A.style "background" ("url("++(addSokoBackground s) ++ ")")
            ][]
        else
            img
                []
             []

getCentral: Int -> Int
getCentral x=
    if (x<=3) then
        3
    else
        if x>=8 then
            8
        else
            x



blockListBackground : (Int,Int,Model) -> List SokoBlock  ->List (Html Msg)
blockListBackground (x0,y0,model) blocks =
    case blocks of
        [] ->
            []
        head :: rest ->
            let
                headSvg = sokodisplay  (x0,y0) head model
                restSvg = blockListBackground (x0,y0,model) rest
            in
            headSvg :: restSvg




type alias Worldmap =
    { x : Float
    , y : Float
    }

windowx = 500
windowy = 100

initialWorldmap : Worldmap
initialWorldmap =
    {  x = windowx
    ,y = windowy
    }

