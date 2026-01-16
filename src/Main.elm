module Main exposing (main)

import Animation
import Array
import Browser
import Browser.Events exposing (onAnimationFrameDelta, onKeyDown, onResize)
import Browser.Dom exposing (getViewport)
import Draggable
import Html.Events exposing (keyCode)
import Json.Decode as Decode
import Update exposing (..)
import Model exposing (..)
import Message exposing (..)
import View exposing (..)
import Task
import Time exposing (..)




main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : flags -> ( Model, Cmd Msg )
init _ =
    ( { tools = initialTool
      , drag = Draggable.init
      , indexNum = 0
      , size = ( 0, 0 )
      , boardAppear = False
      , mouseX = 0
      , mouseY = 0
      , clicked = False
      , button1 = True
      , dialogEnd = False
      , dialogID = 0
      , value1 = "Guard: You are not allowed in, cop."
      , value2 = "Drunk: My head..."
      , value3 = "Drunk: Oh yes, I have the key...but my head's aching, you know."
      , value4 = "Drunk: If you can get me some anodyne..."
      , value5 = "Drunk: I don't (*hiccup) know what...you mean. Go away!"
      , value6 = "Bartender: How are you tonight? What can I get you to drink?"
      , value7 = "Bartender: I don't know where he is. I haven't seen him for quite a while."
      , value8 = "Bartender: Honestly, he is kinda strange. He always rearranges the wines on the rack and we're even not allowed to change the order."
      , value9 = "Bartender: Weird, right?"
      , value10 = "Bartender: Didn't you just ask about it? You are a bit weird too."
      , value11 = "Bartender: What? Are you fooling me?"
      , value12 = "Bartender: You must be drunk. Go lie down with that drunkard and don't bother me."
      , value13 = "Bartender: I don't have the key of the warehouse. Only two persons own it."
      , value14 = "Bartender: One is my boss, you know. The other is the warehouse keeper —— see, the drunkard over there."
      , showCursor = True
      , cursor = defaultCursor
      , inProcess = ""
      , cursorOn = False
      , rain = False
      , showRain = False
      , scene = 3
      , transition1 = False
      , transition1Times = 0
      , endTransition1 = False
      , transition2 = False
      , transition2Times = 0
      , endTransition2 = False
      , askDrunk = False
      , content = ""
      , showBarOptions = False
      , showMixDrink = False
      , askOwnerTimes = 0
      , askWarehouseTimes = 0
      , style1 = initialStyle
      , style2 = initialStyle
      , style3 = initialStyle
      , showPiano = False
      , pianoValue = ""
      , pressedC = False
      , pressedD = False
      , pressedE = False
      , pressedF = False
      , pressedG = False
      , pressedA = False
      , pressedB = False
      , pipes =demopipes
      , status =Playing
      , worldmap =initialWorldmap
      ,cityColorArray = Array.repeat 7 "url(resources/invisiblepoint.png)"
      ,cityPositionArrayx = Array.fromList [ 467,780,860,508,258,223,430]
      ,cityPositionArrayy = Array.fromList [ 123,210,420,205,430,177,140]
      ,state = Playing_w
      ,firstClick = False
      ,indexpc = (6,-1)-----
      , sodoBlock = demoBlock
      , sodoPos = (4,4)
      , page = Feature4
      , face = Left
      }
    , Task.perform GetViewport getViewport
    )




subscriptions : Model -> Sub Msg
subscriptions model =
    let
      typing =
          if model.dialogID /=0 then
            if model.value1==model.inProcess || model.value2==model.inProcess
              then Sub.none
              else Time.every 30 (always NextKey)
          else Sub.none
      cursorBlinking =
          if model.dialogID /=0 then
            if model.showCursor
            then Time.every 500 (always ToggleCursor)
            else Sub.none
          else Sub.none
    in
    Sub.batch
        [ Draggable.subscriptions DragMsg model.drag
        , onResize Resize
        , Time.every 4000 Tick
        , if model.clicked == True then
             Time.every 1250 TickClick
          else
             Sub.none
        , if model.rain == True then
            Time.every 4400 Rain
          else
            Sub.none
        , if model.transition1 == True then
            Time.every 4150 EndTransition1
          else
            Sub.none
        , if model.transition2 == True then
            Time.every 4150 EndTransition2
          else
            Sub.none
        , if model.showMixDrink == True then
            Time.every 12500 EndMixDrink
          else
            Sub.none
        , if model.pressedA == True || model.pressedB == True || model.pressedC == True || model.pressedD == True
          || model.pressedE == True || model.pressedF == True || model.pressedG == True then
            Time.every 1000 PressTime
          else
            Sub.none
        , Animation.subscription Animate <|
                [model.style1, model.style2, model.style3]
        , typing
        , cursorBlinking
        , onKeyDown (Decode.map key keyCode)
        ]



key: Int -> Msg
key k =
    case k of
        37 ->
            MoveLeftBlock
        65 ->
            MoveLeftBlock
        38 ->
            MoveUpBlock
        87 ->
            MoveUpBlock
        39 ->
            MoveRightBlock
        68 ->
            MoveRightBlock
        40 ->
            MoveDownBlock
        83 ->
            MoveDownBlock
        13 ->
            InputText
        _->
            NoOp
