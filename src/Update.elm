module Update exposing (..)
import Array
import Draggable
import Draggable.Events exposing (onClick, onDragBy, onDragEnd, onDragStart)
import Message exposing (..)
import Model exposing (..)
import List exposing (..)
import Animation

dragConfig : Draggable.Config String Msg
dragConfig =
    Draggable.customConfig
        [ onDragStart OnDragStart
 {-       , onClick Clicked -}
        , onDragEnd OnDragEnd
        , onDragBy OnDragBy
{-        , onClick (\_ -> CountClick)
        , Draggable.Events.onMouseDown (\_ -> SetClicked True) -}
        ]

changeIndex : Int -> Tool -> Tool
changeIndex moved tool =
    if tool.index > moved then
        { tool | index = tool.index - 1, xy = Position (tool.xy.x - 60) tool.xy.y}
    else
        tool

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Piano ->
            ( { model| showPiano = True},Cmd.none)
        PianoBack ->
            ( { model| showPiano = False, pianoValue=if model.pianoValue /= "ADFBEGC" then "" else model.pianoValue},Cmd.none)
        PressTime time ->
            ( { model| pressedA = False, pressedB= False, pressedC=False, pressedD=False, pressedE=False,pressedF=False,pressedG=False},Cmd.none)
        PressF ->
            ( { model| pressedF = True, pianoValue=if model.pianoValue /= "ADFBEGC" then model.pianoValue++"F" else model.pianoValue
            , showPiano =if model.pianoValue == "ADFBEGC" then False else True},Cmd.none)
        PressG ->
            ( { model| pressedG = True, pianoValue=if model.pianoValue /= "ADFBEGC" then model.pianoValue++"G" else model.pianoValue
            , showPiano =if model.pianoValue == "ADFBEGC" then False else True},Cmd.none)
        PressA ->
            ( { model| pressedA = True, pianoValue=if model.pianoValue /= "ADFBEGC" then model.pianoValue++"A" else model.pianoValue
            , showPiano =if model.pianoValue == "ADFBEGC" then False else True},Cmd.none)
        PressB ->
            ( { model| pressedB = True, pianoValue=if model.pianoValue /= "ADFBEGC" then model.pianoValue++"B" else model.pianoValue
            , showPiano =if model.pianoValue == "ADFBEGC" then False else True},Cmd.none)
        PressC ->
            ( { model| pressedC = True, pianoValue=if model.pianoValue /= "ADFBEGC" then model.pianoValue++"C" else model.pianoValue
            , showPiano =if model.pianoValue == "ADFBEGC" then False else True},Cmd.none)
        PressD ->
            ( { model| pressedD = True, pianoValue=if model.pianoValue /= "ADFBEGC" then model.pianoValue++"D" else model.pianoValue
            , showPiano =if model.pianoValue == "ADFBEGC" then False else True},Cmd.none)
        PressE ->
            ( { model| pressedE = True, pianoValue=if model.pianoValue /= "ADFBEGC" then model.pianoValue++"E" else model.pianoValue
            , showPiano =if model.pianoValue == "ADFBEGC" then False else True},Cmd.none)
        Animate time ->
            ( { model| style1 = Animation.update time model.style1
                     , style2 = Animation.update time model.style2
                     , style3 = Animation.update time model.style3
              }
            , Cmd.none
            )
        Pulse index->
            (onStyle model index <|
                Animation.interrupt
                    [ Animation.to
                        [ Animation.translate (Animation.px 0) (Animation.px 0)
                        , Animation.scale 1.2
                        ]
                    , Animation.to
                        [ Animation.translate (Animation.px 0) (Animation.px 0)
                        , Animation.scale 1
                        ]
                    ],Cmd.none)
        BarOptions ->
            ({ model | showBarOptions = True},Cmd.none)
        ShowTypebox ->
            ({ model | askDrunk = True},Cmd.none)
        Change newContent ->
            ({ model | content = newContent},Cmd.none)
        InputText ->
            if model.dialogID == 2 then
                if String.contains "warehouse" model.content == True then
                    ({ model | dialogID = 3, askDrunk = False, inProcess = "", content = ""},Cmd.none)
                else
                    ({ model | dialogID = 5, askDrunk = False, dialogEnd = True, inProcess = "", content = ""},Cmd.none)
            else
                ( model, Cmd.none)
        EndTransition1 time ->
            ({ model | transition1 = False},Cmd.none)
        EndTransition2 time ->
            ({ model | transition2 = False},Cmd.none)
        OutPub ->
            ({ model | scene = 1, transition2Times = 1, transition2 = if model.transition2Times==0 then True else False},Cmd.none)
        Pub ->
            ({ model | scene = 2, transition1Times = 1, transition1 = if model.transition1Times==0 then True else False},Cmd.none)
        ContinueDialog ->
            if model.dialogID == 3 then
                ({ model | dialogID = 4, dialogEnd = True, inProcess = ""},Cmd.none)
            else if model.dialogID == 7 then
                ({ model | dialogID = 8, inProcess = ""},Cmd.none)
            else if model.dialogID == 8 then
                ({ model | dialogID = 9, dialogEnd =True, inProcess = ""},Cmd.none)
            else if model.dialogID == 13 then
                ({ model | dialogID = 14, dialogEnd =True, inProcess = ""},Cmd.none)
            else
                ( model,Cmd.none)
        EndDialog ->
            ({ model | dialogID = 0, dialogEnd = False, inProcess = ""},Cmd.none)
        Security ->
            ({ model | dialogID = 1, dialogEnd = True},Cmd.none)
        Bartender ->
            ({ model | dialogID = 6},Cmd.none)
        Drunk ->
            ({ model | dialogID = 2},Cmd.none)
        MixDrink ->
            ({ model | showMixDrink = True, dialogID = 0, inProcess = "", showBarOptions = False},Cmd.none)
        EndMixDrink time->
            ({ model | showMixDrink = False},Cmd.none)
        AskOwner ->
            if model.askOwnerTimes ==0 then
                ({ model | dialogID = 7, inProcess = "", showBarOptions = False, askOwnerTimes = 1},Cmd.none)
            else if model.askOwnerTimes ==1 then
                ({ model | dialogID = 10, dialogEnd = True, inProcess ="", showBarOptions = False, askOwnerTimes = model.askOwnerTimes +1},Cmd.none)
            else if model.askOwnerTimes ==2 then
                ({ model | dialogID = 11, dialogEnd = True, inProcess ="", showBarOptions = False, askOwnerTimes = model.askOwnerTimes +1},Cmd.none)
            else
                ({ model | dialogID = 12, dialogEnd = True, inProcess ="", showBarOptions = False},Cmd.none)
        AskWarehouse ->
            if model.askWarehouseTimes ==0 then
                ({ model | dialogID = 13, inProcess = "", showBarOptions = False, askWarehouseTimes = 1},Cmd.none)
            else if model.askWarehouseTimes ==1 then
                ({ model | dialogID = 10, dialogEnd = True, inProcess ="", showBarOptions = False, askWarehouseTimes = model.askWarehouseTimes +1},Cmd.none)
            else if model.askWarehouseTimes ==2 then
                ({ model | dialogID = 11, dialogEnd = True, inProcess ="", showBarOptions = False, askWarehouseTimes = model.askWarehouseTimes +1},Cmd.none)
            else
                ({ model | dialogID = 12, dialogEnd = True, inProcess ="", showBarOptions = False},Cmd.none)
        ToggleCursor ->
          ({ model | cursorOn = model.showCursor && not model.cursorOn  },Cmd.none)
        ShowCursor show ->
          ({ model | showCursor = show },Cmd.none)
        SetCursor cursor ->
          ({ model | cursor = if cursor == "" then defaultCursor else cursor },Cmd.none)
        NextKey ->
          let
            nextText = typer model
          in
          ({ model | inProcess = nextText},Cmd.none)
        Click event ->
            let
                x = Tuple.first event.clientPos
                y = Tuple.second event.clientPos
            in
            ( { model | mouseX = x, mouseY = y, clicked = True
                  {-    , dialogID = if model.dialogEnd == True then 0 else model.dialogID
                      , dialogEnd = if model.dialogEnd == True && model.dialogID /=0 then False else True-}  } , Cmd.none)
        Rain time ->
            ( { model | showRain = True}, Cmd.none)
        TickClick time ->
            ( { model | clicked = False}, Cmd.none)
        Tick time ->
            if model.boardAppear == False then
                ( { model | boardAppear = True }, Cmd.none)
            else
                ( { model | boardAppear = False }, Cmd.none)
        Resize width height ->
            ( { model | size = ( toFloat width, toFloat height ) }
            , Cmd.none
            )

        GetViewport { viewport } ->
            ( { model
                | size =
                    ( viewport.width
                    , viewport.height
                    )
              }
            , Cmd.none
            )
        OnDragBy ( dx, dy ) ->
            let
                tool = Maybe.withDefault initialTool1 (List.head (List.filter (\x -> x.isDragging == True) model.tools))
                tool_ = { tool | xy = Position (tool.xy.x + dx) (tool.xy.y + dy) }
                tools = List.filter (\x -> x.isDragging == False) model.tools
                tools_ = tools ++ [tool_]
            in
            ( { model | tools = tools_ }, Cmd.none )

        OnDragStart id ->
            let
                id_ = Maybe.withDefault 1 (String.toInt id)
                tool = Maybe.withDefault initialTool1 (List.head (List.filter (\x -> x.id == id_) model.tools))
                tool_ = { tool | isDragging = True}
                tools = List.filter (\x -> x.id /= id_) model.tools
                tools_ = tools ++ [tool_]
            in
            if tool.status == Unfound || tool.status == Stored then
                ( { model | tools = tools_ }, Cmd.none )
            else
                ( model, Cmd.none )

        OnDragEnd ->
            let
                tool = Maybe.withDefault initialTool1 (List.head (List.filter (\x -> x.isDragging == True) model.tools))
                tools = List.filter (\x -> x.isDragging == False) model.tools
            in
            if tool.index == 0 && tool.id /= 0 then
                let
                    indexNum = model.indexNum +1
                    tool_ = { tool | isDragging = False, status = Stored, index=indexNum
                            , xy = Position (250 + 60* toFloat indexNum) 626 }
                    tools_ = tools ++ [tool_]
                in
                ( { model | indexNum = indexNum, tools = tools_ }, Cmd.none )
            else if tool.id == 0 then
                ( { model | tools = tools, rain = True }, Cmd.none )
            else if tool.id == 1 then
                if tool.xy.x >=90 && tool.xy.x<=150 && tool.xy.y>=0 && tool.xy.y<=60 then
                    let
                        tool_ = { tool | isDragging = False }
                        tools_ = List.map (changeIndex tool.index) tools
                    in
                    ( { model | indexNum = model.indexNum - 1, tools = tools_ }, Cmd.none )
                else
                    let
                        tool_ = { tool | xy = Position (250 + 60* toFloat tool.index) 626, isDragging = False }
                        tools_ = tools ++ [tool_]
                    in
                    ( { model | tools = tools_ }, Cmd.none )
            else if tool.id ==2 then
                if tool.xy.x >=290 && tool.xy.x<=350 && tool.xy.y>=30 && tool.xy.y<=90 then
                    let
                        tool_ = { tool | isDragging = False }
                        tools_ = List.map (changeIndex tool.index) tools
                    in
                    ( { model | indexNum = model.indexNum - 1, tools = tools_ }, Cmd.none )
                else
                    let
                        tool_ = { tool | xy = Position (250 + 60* toFloat tool.index) 626, isDragging = False }
                        tools_ = tools ++ [tool_]
                    in
                    ( { model | tools = tools_ }, Cmd.none )
            else
                if tool.xy.x >=490 && tool.xy.x<=550 && tool.xy.y>=10 && tool.xy.y<=70 then
                    let
                        tool_ = { tool | isDragging = False }
                        tools_ = List.map (changeIndex tool.index) tools
                    in
                    ( { model | indexNum = model.indexNum - 1, tools = tools_ }, Cmd.none )
                else
                    let
                        tool_ = { tool | xy = Position (250 + 60* toFloat tool.index) 626, isDragging = False }
                        tools_ = tools ++ [tool_]
                    in
                    ( { model | tools = tools_ }, Cmd.none )
{-
        CountClick ->
            ( { model | clicksCount = model.clicksCount + 1 }, Cmd.none )

        SetClicked flag ->
            ( { model | isClicked = flag }, Cmd.none ) -}

        DragMsg dragMsg ->
            Draggable.update dragConfig dragMsg model

        Rotate p ->
            let
                newmodel = checkwin model
            in
            ({newmodel|pipes = Array.set p (rotatePipe (Array.get p model.pipes))model.pipes},Cmd.none)

        Changecolor index ->
            let
                checkmodel = checkMapWin index model

                background =
                          case (Array.get index model.cityColorArray) of
                              Nothing ->
                                  " "
                              Just a ->
                                  a
            in
              case background of
                "url(resources/invisiblepoint.png)" ->
                    ( { checkmodel | cityColorArray  = Array.set index "url(resources/redball.png)" model.cityColorArray ,firstClick = True}, Cmd.none )
                _->
                    ( checkmodel, Cmd.none )

        ToFirstPage ->
            ( { model
                | page = FirstPage
              }
            , Cmd.none
            )
        MoveLeftBlock ->
            let
                newmodel = {model| face = Left}
            in
            if newmodel.page == Feature4 then
                ((moveCharacter newmodel Left),Cmd.none)
            else
             (newmodel,Cmd.none)
        MoveRightBlock ->
            let
                newmodel = {model| face = Right}
            in
            if newmodel.page == Feature4 then
                ((moveCharacter newmodel Right),Cmd.none)
            else
             (newmodel,Cmd.none)
        MoveUpBlock ->
            let
                newmodel = {model| face = Up}
            in
            if newmodel.page == Feature4 then
                ((moveCharacter newmodel Up),Cmd.none)
            else
             (newmodel,Cmd.none)
        MoveDownBlock ->
            let
                newmodel = {model| face = Down}
            in
            if newmodel.page == Feature4 then
                ((moveCharacter newmodel Down),Cmd.none)
            else
             (newmodel,Cmd.none)
        NoOp ->
            (model,Cmd.none)

onStyle : Model -> Int -> (Animation.State -> Animation.State) -> Model
onStyle model index styleFn =
    case index of
        1 ->
            { model | style1 = styleFn model.style1 }
        2 ->
            { model | style2 = styleFn model.style2 }
        3 ->
            { model | style3 = styleFn model.style3 }
        _ ->
            model



typer : Model -> String
typer model  =
  let
    typedKeys =
        case model.dialogID of
            1 -> toTypedKeys model.value1 model.inProcess
            2 -> toTypedKeys model.value2 model.inProcess
            3 -> toTypedKeys model.value3 model.inProcess
            4 -> toTypedKeys model.value4 model.inProcess
            5 -> toTypedKeys model.value5 model.inProcess
            6 -> toTypedKeys model.value6 model.inProcess
            7 -> toTypedKeys model.value7 model.inProcess
            8 -> toTypedKeys model.value8 model.inProcess
            9 -> toTypedKeys model.value9 model.inProcess
            10 -> toTypedKeys model.value10 model.inProcess
            11 -> toTypedKeys model.value11 model.inProcess
            12 -> toTypedKeys model.value12 model.inProcess
            13 -> toTypedKeys model.value13 model.inProcess
            14 -> toTypedKeys model.value14 model.inProcess
            _ -> toTypedKeys model.value1 model.inProcess
    typed =
          appendNextLetter typedKeys
  in
    typed

appendNextLetter : List TypedKey -> String
appendNextLetter typedKeys =
  let
    filterTyped x =
      case x of
        Matched c -> Just c
        Wrong _ c -> Just c
        _ -> Nothing
    skipTyped =
      List.filter (\x -> case x of
                            Untyped c -> True
                            _ -> False
                  )
    nextLetter =
      case head <| skipTyped typedKeys of
        Just (Untyped c) ->
          [c]
        _ -> []
  in
    filterMap filterTyped typedKeys ++ nextLetter
      |> String.fromList

toTypedKeys : String -> String -> List TypedKey
toTypedKeys expected current =
  let
    typedKey entry =
      case entry of
        First c -> Untyped c
        Second c -> Excess c
        Both exp cur -> if exp == cur then Matched exp else Wrong exp cur
  in
    zipAll (String.toList expected) (String.toList current)
      |> List.map typedKey

zipAll : List a -> List b -> List (FullZipItem a b)
zipAll a b =
  case (a, b) of
    ([], []) -> []
    (x::xs, []) -> First x :: zipAll xs []
    ([], y::ys) -> Second y :: zipAll [] ys
    (x::xs, y::ys) -> Both x y :: zipAll xs ys


getState: Maybe Pipe -> PipeType
getState p =
    case p of
        Just p1 ->
            p1.category
        Nothing ->
            Empty

checkwin : Model -> Model
checkwin model =
    if (((getState (Array.get 0 model.pipes))== Circular 3 &&(getState (Array.get 1 model.pipes))== LeftRight&&(getState (Array.get 2 model.pipes))== LeftRight && (getState (Array.get 3 model.pipes))== LeftRight
        &&(getState (Array.get 4 model.pipes))== Circular 2 && (getState (Array.get 5 model.pipes))== Updown &&(getState (Array.get 9 model.pipes))== Updown&&(getState (Array.get 10 model.pipes))== Circular 4
        && (getState (Array.get 11 model.pipes))== LeftRight&&(getState (Array.get 12 model.pipes))== LeftRight&&(getState (Array.get 13 model.pipes))== LeftRight&&(getState (Array.get 14 model.pipes))== Circular 1))
    then
        {model|status = Win}
    else
        model



checkMapWin : Int -> Model ->Model
checkMapWin index  model =
    let
        indexp = Tuple.second(model.indexpc)
        indexc =
            if index <= indexp then
                 indexp
            else
                 index

    in
            if indexc - indexp > 1 then
               {model| state = MapLose,indexpc = (indexp,indexc)}
            else if indexc - indexp <= 1 && indexc == 6 then
               {model| state = MapWin,indexpc = (indexp,indexc)}
            else
                {model| indexpc = (indexp,indexc)}

moveCharacter : Model -> Direction -> Model
moveCharacter model d =
    let
        x= Tuple.first model.sodoPos
        y= Tuple.second model.sodoPos
        o = Array.get (10*x + y - 11) model.sodoBlock --sodoPos
        b1= Array.get (10*x + y - 21) model.sodoBlock --Left
        b2= Array.get (10*x + y - 1) model.sodoBlock --Right
        b3= Array.get (10*x + y - 12) model.sodoBlock --Up
        b4= Array.get (10*x + y - 10) model.sodoBlock --Down
        b5= Array.get (10*x + y - 31) model.sodoBlock --Left+1
        b6= Array.get (10*x + y + 9) model.sodoBlock --Right+1
        b7= Array.get (10*x + y - 13) model.sodoBlock --Up+1
        b8= Array.get (10*x + y - 9) model.sodoBlock --Down+1
    in
    case o of
        Nothing->
          model
        Just o1->
            case d of
                Down ->
                    if (y==1) then
                        model
                    else
                        case b3 of
                            Nothing ->
                                model
                            Just a ->
                                case a.category of
                                    Void ->
                                        model
                                    Wall ->
                                        model
                                    _ ->
                                        if a.hasBlock == False then
                                            {model|sodoPos = (x,y - 1), sodoBlock = Array.set (10*x + y - 12) {a|hasCharacter=True}  (
                                            Array.set (10*x + y - 11) ({o1|hasCharacter = False} ) model.sodoBlock)  }
                                        else
                                            if (y==2) then
                                                model
                                            else
                                                case b7 of
                                                    Nothing ->
                                                        model
                                                    Just m ->
                                                        case m.category of
                                                            Blank1 ->
                                                                {model|sodoPos = (x,y - 1) , sodoBlock = Array.set (10*x + y - 11) {o1|hasCharacter = False}  (Array.set (10*x + y - 12) {a|hasBlock=False,hasCharacter= True} (
                                                                Array.set (10*x + y - 13) {m|hasBlock=True,hasCharacter= False} model.sodoBlock))}
                                                            Void ->
                                                                {model|sodoPos = (x,y - 1) , sodoBlock = Array.set (10*x + y - 11 ) {o1|hasCharacter = False} (Array.set (10*x + y - 12) {a|hasBlock=False,hasCharacter= True} (
                                                                Array.set (10*x + y - 13) {m|hasBlock=False,hasCharacter= False,category=Blank2} model.sodoBlock))}
                                                            Blank2 ->
                                                                {model|sodoPos = (x,y - 1) , sodoBlock = (Array.set (10*x + y - 11) {o1|hasCharacter = False}) (Array.set (10*x + y - 12) {a|hasBlock=False,hasCharacter= True} (
                                                                Array.set (10*x + y - 13) {m|hasBlock=True,hasCharacter= False} model.sodoBlock))}
                                                            Wall ->
                                                                 model
                Up ->
                    if (y==10) then
                        model
                    else
                        case b4 of
                            Nothing ->
                                model
                            Just a ->
                                case a.category of
                                    Void ->
                                        model
                                    Wall ->
                                        model
                                    _ ->
                                        if a.hasBlock == False then
                                            {model|sodoPos = (x,y + 1), sodoBlock = Array.set (10*x + y - 10) {a|hasCharacter=True}   (
                                            Array.set (10*x + y - 11) ({o1|hasCharacter = False} ) model.sodoBlock)  }
                                        else
                                            if (y==9) then
                                                model
                                            else
                                                case b8 of
                                                    Nothing ->
                                                        model
                                                    Just m ->
                                                        case m.category of
                                                            Blank1 ->
                                                                {model|sodoPos = (x,y + 1) , sodoBlock = Array.set (10*x + y - 11) {o1|hasCharacter = False}  (Array.set (10*x + y - 10) {a|hasBlock=False,hasCharacter= True} (
                                                                Array.set (10*x + y - 9) {m|hasBlock=True,hasCharacter= False} model.sodoBlock))}
                                                            Void ->
                                                                {model|sodoPos = (x,y + 1) , sodoBlock = Array.set (10*x + y - 11 ) {o1|hasCharacter = False} (Array.set (10*x + y - 10) {a|hasBlock=False,hasCharacter= True} (
                                                                Array.set (10*x + y - 9) {m|hasBlock=False,hasCharacter= False,category=Blank2} model.sodoBlock))}
                                                            Blank2 ->
                                                                {model|sodoPos = (x,y + 1) , sodoBlock = (Array.set (10*x + y - 11) {o1|hasCharacter = False}) (Array.set (10*x + y - 10) {a|hasBlock=False,hasCharacter= True} (
                                                                Array.set (10*x + y - 9) {m|hasBlock=True,hasCharacter= False} model.sodoBlock))}
                                                            Wall ->
                                                                 model
                Left ->
                    if (x==10) then
                        model
                    else
                        case b2 of
                            Nothing ->
                                model
                            Just a ->
                                case a.category of
                                    Void ->
                                        model
                                    Wall ->
                                        model
                                    _ ->
                                        if a.hasBlock == False then
                                            {model|sodoPos = (x+1,y), sodoBlock = Array.set (10*x + y - 1) {a|hasCharacter=True}  (
                                            Array.set (10*x + y - 11) ({o1|hasCharacter = False} ) model.sodoBlock)  }
                                        else
                                            if (x==9) then
                                                model
                                            else
                                                case b6 of
                                                    Nothing ->
                                                        model
                                                    Just m ->
                                                        case m.category of
                                                            Blank1 ->
                                                                {model|sodoPos = (x+1,y) , sodoBlock = Array.set (10*x + y - 11) {o1|hasCharacter = False}  (Array.set (10*x + y - 1) {a|hasBlock=False,hasCharacter= True} (
                                                                Array.set (10*x + y + 9 ) {m|hasBlock=True,hasCharacter= False} model.sodoBlock))}
                                                            Void ->
                                                                {model|sodoPos = (x+1,y) , sodoBlock = Array.set (10*x + y - 11 ) {o1|hasCharacter = False} (Array.set (10*x + y - 1) {a|hasBlock=False,hasCharacter= True} (
                                                                Array.set (10*x + y +9 ) {m|hasBlock=False,hasCharacter= False,category=Blank2} model.sodoBlock))}
                                                            Blank2 ->
                                                                {model|sodoPos = (x+1,y) , sodoBlock = (Array.set (10*x + y - 11) {o1|hasCharacter = False}) (Array.set (10*x + y - 1) {a|hasBlock=False,hasCharacter= True} (
                                                                Array.set (10*x + y +9) {m|hasBlock=True,hasCharacter= False} model.sodoBlock))}
                                                            Wall ->
                                                                model
                Right ->
                    if (x==1) then
                        model
                    else
                        case b1 of
                            Nothing ->
                                model
                            Just a ->
                                case a.category of
                                    Void ->
                                        model
                                    Wall ->
                                        model
                                    _ ->
                                        if a.hasBlock == False then
                                            {model|sodoPos = (x - 1 ,y), sodoBlock = Array.set (10*x + y - 21) {a|hasCharacter=True}  (
                                            Array.set (10*x + y - 11) ({o1|hasCharacter = False} ) model.sodoBlock)  }
                                        else
                                            if (x==2) then
                                                model
                                            else
                                                case b5 of
                                                    Nothing ->
                                                        model
                                                    Just m ->
                                                        case m.category of
                                                            Blank1 ->
                                                                {model|sodoPos = (x - 1,y) , sodoBlock = Array.set (10*x + y - 11) {o1|hasCharacter = False}  (Array.set (10*x + y - 21) {a|hasBlock=False,hasCharacter= True} (
                                                                Array.set (10*x + y - 31) {m|hasBlock=True,hasCharacter= False} model.sodoBlock))}
                                                            Void ->
                                                                {model|sodoPos = (x - 1,y) , sodoBlock = Array.set (10*x + y - 11 ) {o1|hasCharacter = False} (Array.set (10*x + y - 21) {a|hasBlock=False,hasCharacter= True} (
                                                                Array.set (10*x + y - 31) {m|hasBlock=False,hasCharacter= False,category=Blank2} model.sodoBlock))}
                                                            Blank2 ->
                                                                {model|sodoPos = (x - 1,y ) , sodoBlock = (Array.set (10*x + y - 11) {o1|hasCharacter = False}) (Array.set (10*x + y - 21) {a|hasBlock=False,hasCharacter= True} (
                                                                Array.set (10*x + y - 31) {m|hasBlock=True,hasCharacter= False} model.sodoBlock))}
                                                            Wall ->
                                                                 model
