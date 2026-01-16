module View exposing (..)
import Animation
import Array exposing (get)
import Browser
import Draggable
import Draggable.Events exposing (onClick, onDragBy, onDragEnd, onDragStart)
import Html exposing (Html, button, div, img, text, input, Attribute)
import Html.Attributes as A exposing (src, style, placeholder, value)
import Html.Events exposing (onClick,onInput)
import Model exposing (..)
import Message exposing (..)
import Html.Events.Extra.Mouse as Mouse
import String.Extra
import Svg.Attributes exposing (height, width)

id1 =
    img
        [ A.style "position" "absolute"
        , A.style "left" "100px"
        , A.style "top" "10px"
        , A.src "https://www.z4a.net/images/2020/07/12/icecream_.png"]
        []

id2 =
    img
        [ A.style "position" "absolute"
        , A.style "left" "300px"
        , A.style "top" "40px"
        , A.src "https://www.z4a.net/images/2020/07/12/cake_.png"]
        []

id3 =
    img
        [ A.style "position" "absolute"
        , A.style "left" "500px"
        , A.style "top" "20px"
        , A.src "https://www.z4a.net/images/2020/07/12/donut_.png"]
        []

toolbar =
    img
        [ A.style "position" "absolute"
        , A.style "bottom" "0"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,0)"
        , A.src "https://www.z4a.net/images/2020/07/12/toolbar.png"
        ]
        []

viewDescription : String -> Html msg
viewDescription txt =
    Html.div
        [ A.style "color" "#34495f"
        , A.style "font-size" "30px"
        , A.style "line-height" "0px"
        , A.style "margin" "30px 0 0"
        , A.style "right" "600px"
        , A.style "top" "100px"
        , A.style "position" "absolute"
        ]
        [ Html.text txt ]

viewSingleTool : Tool -> Html Msg
viewSingleTool tool=
    let
        translate =
            "translate(" ++ String.fromFloat tool.xy.x ++ "px, " ++ String.fromFloat tool.xy.y ++ "px)"
        id =
            Debug.toString tool.id
    in
    if tool.index == 0 then
    Html.div
        [ if tool.id==0 then
          A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/25/rainfallboard2.png\")"
          else if tool.id==1 then
          A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/12/icecream.png\")"
          else if tool.id==2 then
          A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/12/cake.png\")"
          else
          A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/12/donut.png\")"
        , A.style "transform" translate
        , if tool.id/=0 then A.style "padding" "30px" else A.style "width" "12%"
        , if tool.id/=0 then A.style "width" "80px" else A.style "height" "5%"
        , A.style "text-align" "center"
        , A.style "cursor" "default"
        , A.style "position" "absolute"
        , if tool.id/=0 then A.style "background-size" "contain" else A.style "background-size" "cover"
        , A.style "background-repeat" "no-repeat"
        , Draggable.mouseTrigger id DragMsg][]
    else
    img
        [ if tool.id==1 then
          A.src "https://www.z4a.net/images/2020/07/12/icecream.png"
          else if tool.id==2 then
          A.src "https://www.z4a.net/images/2020/07/12/cake.png"
          else
          A.src "https://www.z4a.net/images/2020/07/12/donut.png"
        , A.style "transform" translate
        , A.style "padding" "16px"
        , A.style "width" "50px"
        , A.style "text-align" "center"
        , A.style "cursor" "default"
        , A.style "position" "absolute"
        , Draggable.mouseTrigger id DragMsg][]

viewWindow =
    img
        [ A.style "position" "absolute"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.src "https://www.z4a.net/images/2020/07/21/background.gif"]
        []

bar =
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
       {- , A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/19/bar.png\")" -}
        , A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/25/8b7d488daf447d58afe830c17a5571d8.gif\")"
        , A.style "background-size" "cover"
        , A.style "background-repeat" "no-repeat"
        , A.src "https://www.z4a.net/images/2020/07/19/bar.png"]
        []

rain =
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
        , A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/25/1876280065258c8a63d8994ded3888fe.gif\")"
        , A.style "background-size" "cover"
        , A.style "background-repeat" "no-repeat"
        , A.src "https://www.z4a.net/images/2020/07/19/bar.png"]
        []

rain2 =
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
        , A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/25/rain178fd2c2bbda76ef.gif\")"
        , A.style "background-size" "cover"
        , A.style "background-repeat" "no-repeat"
        , A.src "https://www.z4a.net/images/2020/07/19/bar.png"]
        []

transition1 =
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
        , A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/26/transition1922bad9c6f16ff33.gif\")"
        , A.style "background-size" "cover"
        , A.style "background-repeat" "no-repeat"
        , A.src "https://www.z4a.net/images/2020/07/19/bar.png"]
        []

transition2 =
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
        , A.style "background-image" "url(\"https://ftp.bmp.ovh/imgs/2020/07/92ba61a07eee1096.gif\")"
        , A.style "background-size" "cover"
        , A.style "background-repeat" "no-repeat"
        , A.src "https://www.z4a.net/images/2020/07/19/bar.png"]
        []

mixDrink =
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
        , A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/27/06f1c14a91d056739f983d99cba81f98.gif\")"
        , A.style "background-size" "cover"
        , A.style "background-repeat" "no-repeat"
        , A.src "https://www.z4a.net/images/2020/07/19/bar.png"]
        []


pub =
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
        , A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/26/602a32e3d34029ccfd4155fe76e4b4a6.gif\")"
        , A.style "background-size" "cover"
        , A.style "background-repeat" "no-repeat"
        , A.src "https://www.z4a.net/images/2020/07/19/bar.png"]
        []

security =
    Html.button
        [ A.style "top" "400px"
        , A.style "cursor" "pointer"
        , A.style "display" "block"
        , A.style "background" "url(\"https://www.z4a.net/images/2020/07/25/invisible1.png\")"
        , A.style "background-size" "contain"
        , A.style "background-repeat" "no-repeat"
        , A.style "left" "630px"
        , A.style "position" "absolute"
        , A.style "width" "10%"
        , A.style "height" "20%"
        , A.style "border" "0"
        , A.style "outline" "none"
        , Html.Events.onClick Security
        ]
        []

security2 =
    Html.button
        [ A.style "top" "400px"
        , A.style "cursor" "pointer"
        , A.style "display" "block"
        , A.style "background" "url(\"https://www.z4a.net/images/2020/07/25/invisible1.png\")"
        , A.style "background-size" "contain"
        , A.style "background-repeat" "no-repeat"
        , A.style "left" "780px"
        , A.style "position" "absolute"
        , A.style "width" "10%"
        , A.style "height" "20%"
        , A.style "border" "0"
        , A.style "outline" "none"
        , Html.Events.onClick Security
        ]
        []

drunk =
    Html.button
        [ A.style "top" "440px"
        , A.style "cursor" "pointer"
        , A.style "display" "block"
        , A.style "background" "url(\"https://www.z4a.net/images/2020/07/25/invisible1.png\")"
        , A.style "background-size" "contain"
        , A.style "background-repeat" "no-repeat"
        , A.style "left" "700px"
        , A.style "position" "absolute"
        , A.style "width" "10%"
        , A.style "height" "20%"
        , A.style "border" "0"
        , A.style "outline" "none"
        , Html.Events.onClick Drunk
        ]
        []

bartender =
    Html.button
        [ A.style "top" "400px"
        , A.style "cursor" "pointer"
        , A.style "display" "block"
        , A.style "background" "url(\"https://www.z4a.net/images/2020/07/25/invisible1.png\")"
        , A.style "background-size" "contain"
        , A.style "background-repeat" "no-repeat"
        , A.style "left" "640px"
        , A.style "position" "absolute"
        , A.style "width" "3%"
        , A.style "height" "10%"
        , A.style "border" "0"
        , A.style "outline" "none"
        , Html.Events.onClick Bartender
        ]
        []

enterPub =
    Html.button
        [ A.style "top" "400px"
        , A.style "cursor" "pointer"
        , A.style "display" "block"
        , A.style "background" "url(\"https://www.z4a.net/images/2020/07/25/invisible1.png\")"
        , A.style "background-size" "contain"
        , A.style "background-repeat" "no-repeat"
        , A.style "left" "780px"
        , A.style "position" "absolute"
        , A.style "width" "10%"
        , A.style "height" "20%"
        , A.style "border" "0"
        , A.style "outline" "none"
        , Html.Events.onClick Pub
        ]
        []

outPub =
    Html.button
        [ A.style "top" "350px"
        , A.style "cursor" "pointer"
        , A.style "display" "block"
        , A.style "background" "url(\"https://www.z4a.net/images/2020/07/25/invisible1.png\")"
        , A.style "background-size" "contain"
        , A.style "background-repeat" "no-repeat"
        , A.style "left" "100px"
        , A.style "position" "absolute"
        , A.style "width" "10%"
        , A.style "height" "20%"
        , A.style "border" "0"
        , A.style "outline" "none"
        , Html.Events.onClick OutPub
        ]
        []

piano =
    Html.button
        [ A.style "top" "370px"
        , A.style "cursor" "default"
        , A.style "display" "block"
        , A.style "background" "url(\"https://www.z4a.net/images/2020/07/25/invisible1.png\")"
        , A.style "background-size" "contain"
        , A.style "background-repeat" "no-repeat"
        , A.style "left" "260px"
        , A.style "position" "absolute"
        , A.style "width" "10%"
        , A.style "height" "20%"
        , A.style "border" "0"
        , A.style "outline" "none"
        , Html.Events.onClick Piano
        ]
        []

pianoBack =
    Html.button
        [ A.style "top" "140px"
        , A.style "cursor" "pointer"
        , A.style "display" "block"
        , A.style "background" "url(\"https://www.z4a.net/images/2020/07/28/82f620bcbf184a006dab3e5fba092989.png\")"
        , A.style "background-size" "80px 40px"
        , A.style "background-repeat" "no-repeat"
        , A.style "left" "120px"
        , A.style "position" "absolute"
        , A.style "text-align" "center"
        , A.style "padding" "30px 60px"
        , A.style "background-position" "center"
        , A.style "border" "0"
        , A.style "outline" "none"
        , A.style "color" "#000000"
        , Html.Events.onClick PianoBack
        ]
        [ text "BACK"]

pressF =
    Html.button
        [ A.style "top" "250px"
        , A.style "cursor" "pointer"
        , A.style "display" "block"
        , A.style "background" "url(\"https://www.z4a.net/images/2020/07/25/invisible1.png\")"
        , A.style "background-size" "40px 100px"
        , A.style "background-repeat" "no-repeat"
        , A.style "left" "350px"
        , A.style "padding" "90px 15px"
        , A.style "position" "absolute"
        , A.style "border" "0"
        , A.style "transform-origin" "0 0"
        , A.style "transform" "rotate(12deg)"
        , A.style "outline" "none"
        , Html.Events.onClick PressF
        ]
        []

pressG =
    Html.button
        [ A.style "top" "250px"
        , A.style "cursor" "pointer"
        , A.style "display" "block"
        , A.style "background" "url(\"https://www.z4a.net/images/2020/07/25/invisible1.png\")"
        , A.style "background-size" "40px 100px"
        , A.style "background-repeat" "no-repeat"
        , A.style "left" "395px"
        , A.style "padding" "90px 15px"
        , A.style "position" "absolute"
        , A.style "border" "0"
        , A.style "transform-origin" "0 0"
        , A.style "transform" "rotate(7deg)"
        , A.style "outline" "none"
        , Html.Events.onClick PressG
        ]
        []

pressA =
    Html.button
        [ A.style "top" "250px"
        , A.style "cursor" "pointer"
        , A.style "display" "block"
        , A.style "background" "url(\"https://www.z4a.net/images/2020/07/25/invisible1.png\")"
        , A.style "background-size" "40px 100px"
        , A.style "background-repeat" "no-repeat"
        , A.style "left" "440px"
        , A.style "padding" "90px 15px"
        , A.style "position" "absolute"
        , A.style "border" "0"
        , A.style "transform-origin" "0 0"
        , A.style "transform" "rotate(3deg)"
        , A.style "outline" "none"
        , Html.Events.onClick PressA
        ]
        []

pressB =
    Html.button
        [ A.style "top" "250px"
        , A.style "cursor" "pointer"
        , A.style "display" "block"
        , A.style "background" "url(\"https://www.z4a.net/images/2020/07/25/invisible1.png\")"
        , A.style "background-size" "40px 100px"
        , A.style "background-repeat" "no-repeat"
        , A.style "left" "485px"
        , A.style "padding" "90px 15px"
        , A.style "position" "absolute"
        , A.style "border" "0"
        , A.style "transform-origin" "0 0"
        , A.style "transform" "rotate(0deg)"
        , A.style "outline" "none"
        , Html.Events.onClick PressB
        ]
        []

pressC =
    Html.button
        [ A.style "top" "250px"
        , A.style "cursor" "pointer"
        , A.style "display" "block"
        , A.style "background" "url(\"https://www.z4a.net/images/2020/07/25/invisible1.png\")"
        , A.style "background-size" "40px 100px"
        , A.style "background-repeat" "no-repeat"
        , A.style "left" "530px"
        , A.style "padding" "90px 15px"
        , A.style "position" "absolute"
        , A.style "border" "0"
        , A.style "transform-origin" "0 0"
        , A.style "transform" "rotate(-3deg)"
        , A.style "outline" "none"
        , Html.Events.onClick PressC
        ]
        []

pressD =
    Html.button
        [ A.style "top" "250px"
        , A.style "cursor" "pointer"
        , A.style "display" "block"
        , A.style "background" "url(\"https://www.z4a.net/images/2020/07/25/invisible1.png\")"
        , A.style "background-size" "40px 100px"
        , A.style "background-repeat" "no-repeat"
        , A.style "left" "575px"
        , A.style "padding" "90px 15px"
        , A.style "position" "absolute"
        , A.style "border" "0"
        , A.style "transform-origin" "0 0"
        , A.style "transform" "rotate(-7deg)"
        , A.style "outline" "none"
        , Html.Events.onClick PressD
        ]
        []

pressE =
    Html.button
        [ A.style "top" "250px"
        , A.style "cursor" "pointer"
        , A.style "display" "block"
        , A.style "background" "url(\"https://www.z4a.net/images/2020/07/25/invisible1.png\")"
        , A.style "background-size" "40px 100px"
        , A.style "background-repeat" "no-repeat"
        , A.style "left" "610px"
        , A.style "padding" "90px 15px"
        , A.style "position" "absolute"
        , A.style "border" "0"
        , A.style "transform-origin" "0 0"
        , A.style "transform" "rotate(-12deg)"
        , A.style "outline" "none"
        , Html.Events.onClick PressE
        ]
        []

pianoBackground =
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
        , A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/28/82f620bcbf184a006dab3e5fba092989.png\")"
        , A.style "background-size" "contain"
        , A.style "background-position" "center"
        , A.style "background-repeat" "no-repeat"]
        []

pianoBlack =
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
        , A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/28/2a710e14bab91525390fde4099603dce.png\")"
        , A.style "background-size" "427px 240.8px"
        , A.style "background-position" "center"
        , A.style "background-repeat" "no-repeat"]
        []

pianoF model=
    let
        url =
            if model.pressedF == False then
                "https://www.z4a.net/images/2020/07/28/C.png"
            else
                "https://www.z4a.net/images/2020/07/28/Cb23197eaaf8965d0.png"
    in
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
        , A.style "background-image" ("url(\"" ++ url ++ "\")")
        , A.style "background-size" "427px 240.8px"
        , A.style "background-position" "center"
        , A.style "background-repeat" "no-repeat"]
        []

pianoG model=
    let
        url =
            if model.pressedG == False then
                "https://www.z4a.net/images/2020/07/28/D.png"
            else
                "https://www.z4a.net/images/2020/07/28/D8a096705b3c9c904.png"
    in
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
        , A.style "background-image" ("url(\"" ++ url ++ "\")")
        , A.style "background-size" "427px 240.8px"
        , A.style "background-position" "center"
        , A.style "background-repeat" "no-repeat"]
        []

pianoA model=
    let
        url =
            if model.pressedA == False then
                "https://www.z4a.net/images/2020/07/28/E.png"
            else
                "https://www.z4a.net/images/2020/07/28/E72ea6ec6a47895e1.png"
    in
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
        , A.style "background-image" ("url(\"" ++ url ++ "\")")
        , A.style "background-size" "427px 240.8px"
        , A.style "background-position" "center"
        , A.style "background-repeat" "no-repeat"]
        []

pianoB model=
    let
        url =
            if model.pressedB == False then
                "https://www.z4a.net/images/2020/07/28/F.png"
            else
                "https://www.z4a.net/images/2020/07/28/F101244dc6d83123d.png"
    in
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
        , A.style "background-image" ("url(\"" ++ url ++ "\")")
        , A.style "background-size" "427px 240.8px"
        , A.style "background-position" "center"
        , A.style "background-repeat" "no-repeat"]
        []

pianoC model=
    let
        url =
            if model.pressedC == False then
                "https://www.z4a.net/images/2020/07/28/G.png"
            else
                "https://www.z4a.net/images/2020/07/28/G92cdcf6e3e684b4e.png"
    in
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
        , A.style "background-image" ("url(\"" ++ url ++ "\")")
        , A.style "background-size" "427px 240.8px"
        , A.style "background-position" "center"
        , A.style "background-repeat" "no-repeat"]
        []

pianoD model=
    let
        url =
            if model.pressedD == False then
                "https://www.z4a.net/images/2020/07/28/A.png"
            else
                "https://www.z4a.net/images/2020/07/28/Ad06e95c2fb58a5d1.png"
    in
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
        , A.style "background-image" ("url(\"" ++ url ++ "\")")
        , A.style "background-size" "427px 240.8px"
        , A.style "background-position" "center"
        , A.style "background-repeat" "no-repeat"]
        []

pianoE model=
    let
        url =
            if model.pressedE == False then
                "https://www.z4a.net/images/2020/07/28/B.png"
            else
                "https://www.z4a.net/images/2020/07/28/B935df318d3f44483.png"
    in
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "top" "50%"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-50%)"
        , A.style "padding" "210px 400px"
        , A.style "background-image" ("url(\"" ++ url ++ "\")")
        , A.style "background-size" "427px 240.8px"
        , A.style "background-position" "center"
        , A.style "background-repeat" "no-repeat"]
        []


barOption1 model=
    div
        (Animation.render model.style1
            ++ [ style "text-align" "center"
               , style "cursor" "pointer"
               , style "border-radius" "300px"
               , style "vertical-align" "middle"
               , style "background" "url(\"https://www.z4a.net/images/2020/07/28/option.png\")"
               , style "background-size" "cover"
               , style "background-position" "center"
               , style "background-repeat" "no-repeat"
               , style "width" "20%"
               , style "height" "4%"
               , style "padding" "15px"
               , style "position" "absolute"
               , style "top" "150px"
               , style "left" "360px"
               , style "color" "#FFFFFF"
               , Html.Events.onMouseEnter (Pulse 1)
               , Html.Events.onClick MixDrink
               ]
        )
        [ text "Order a drink" ]

barOption2 model=
    div
        (Animation.render model.style2
            ++ [ style "text-align" "center"
               , style "cursor" "pointer"
               , style "border-radius" "300px"
               , style "vertical-align" "middle"
               , style "background" "url(\"https://www.z4a.net/images/2020/07/28/option.png\")"
               , style "background-position" "center"
               , style "background-size" "cover"
               , style "background-repeat" "no-repeat"
               , style "width" "20%"
               , style "height" "4%"
               , style "padding" "15px"
               , style "position" "absolute"
               , style "top" "220px"
               , style "left" "360px"
               , style "color" "#FFFFFF"
               , Html.Events.onMouseEnter (Pulse 2)
               , Html.Events.onClick AskOwner
               ]
        )
        [ text "Ask about the owner" ]

barOption3 model=
    div
        (Animation.render model.style3
            ++ [ style "text-align" "center"
               , style "cursor" "pointer"
               , style "border-radius" "300px"
               , style "vertical-align" "middle"
               , style "background" "url(\"https://www.z4a.net/images/2020/07/28/option.png\")"
               , style "background-position" "center"
               , style "background-size" "cover"
               , style "background-repeat" "no-repeat"
               , style "width" "20%"
               , style "height" "4%"
               , style "padding" "15px"
               , style "position" "absolute"
               , style "top" "290px"
               , style "left" "360px"
               , style "color" "#FFFFFF"
               , Html.Events.onMouseEnter (Pulse 3)
               , Html.Events.onClick AskWarehouse
               ]
        )
        [ text "Ask about the warehouse" ]

dialogBox =
    Html.div
        [ A.style "position" "absolute"
        , A.style "border-radius" "15px"
        , A.style "width" "55%"
        , A.style "height" "45%"
        , A.style "bottom" "0"
        , A.style "left" "50%"
        , A.style "transform" "translate(-50%,-30px)"
        , A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/21/2.gif\")"
        , A.style "background-size" "contain"
        , A.style "background-repeat" "no-repeat"]
        []

rainBoard =
    Html.div
        [ A.style "position" "absolute"
        , A.style "width" "12%"
        , A.style "height" "50%"
        , A.style "transform" "translate(367px,173px)"
        , A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/25/rainfallboard1.png\")"
        , A.style "background-size" "contain"
        , A.style "background-repeat" "no-repeat"]
        []

board =
    Html.div
        [ A.style "position" "absolute"
        , A.style "width" "12%"
        , A.style "height" "50%"
        , A.style "transform" "translate(367px,173px)"
        , A.style "background-image" "url(\"https://www.z4a.net/images/2020/07/25/board.png\")"
        , A.style "background-size" "contain"
        , A.style "background-repeat" "no-repeat"]
        []

pointer: Model -> Html msg
pointer model=
    img
        [ A.src "https://www.z4a.net/images/2020/07/20/water2.gif"]
        []

viewDialog : Model -> Html Msg
viewDialog model =
  let
    cursor =
      case (model.showCursor, model.cursorOn) of
        (True, True) -> model.cursor
        (True, False) -> nbspChar
        _ -> ""
    length =
        List.length (String.Extra.softBreak 45 model.inProcess)
    firstline =
        Maybe.withDefault "" (Array.get 0 (Array.fromList (String.Extra.softBreak 45 model.inProcess)))
    secondline =
        Maybe.withDefault "" (Array.get 1 (Array.fromList (String.Extra.softBreak 45 model.inProcess)))
    thirdline =
        Maybe.withDefault "" (Array.get 2 (Array.fromList (String.Extra.softBreak 45 model.inProcess)))
  in
  Html.div[]
    [Html.div
            [ A.style "position" "absolute"
            , A.style "left" "370px"
            , A.style "top" "470px"
            , A.style "color" "#8eede1"
            ]
            [ if length <2 then text <| firstline ++ cursor else text<| firstline]
    ,Html.div
            [ A.style "position" "absolute"
            , A.style "left" "370px"
            , A.style "top" "490px"
            , A.style "color" "#8eede1"
            ]
            [ if length >=2 && length < 3 then text <| secondline ++ cursor
              else if length>=3 then text <| secondline
              else text ""]
    ,Html.div
            [ A.style "position" "absolute"
            , A.style "left" "370px"
            , A.style "top" "510px"
            , A.style "color" "#8eede1"
            ]
            [ if length >=3 then text <| thirdline ++ cursor
              else text ""]
    ]

pixelWidth : Float
pixelWidth =
    1000


pixelHeight : Float
pixelHeight =
    703


view : Model -> Html Msg
view model =
    let
        tools =
            List.map viewSingleTool (List.filter (\tool -> tool.id /= 0) model.tools)
        rainboard2 =
            List.map viewSingleTool (List.filter (\tool -> tool.id == 0) model.tools)
        toolsStored =
            List.map viewSingleTool (List.filter (\tool -> tool.id /= 0 && tool.status == Stored) model.tools)
        toolsUnfound =
            List.map viewSingleTool (List.filter (\tool -> tool.id /= 0 && tool.status /= Stored) model.tools)
        ( w, h ) =
            model.size
        r =
            if w / h > pixelWidth / pixelHeight then
                min 1 (h / pixelHeight)
            else
                min 1 (w / pixelWidth)
    in
    Html.div
        [ A.style "width" "100%"
        , A.style "background-color" "#030303"
        , A.style "height" "100%"
        , A.style "position" "absolute"
        , A.style "left" "0"
        , A.style "top" "0"
        , Mouse.onClick Click
        , if model.dialogEnd == True then Html.Events.onClick EndDialog
          else if model.dialogID == 2 then
            Html.Events.onClick ShowTypebox
          else if model.dialogID == 3 then
            Html.Events.onClick ContinueDialog
          else if model.dialogID == 6 then
            Html.Events.onClick BarOptions
          else if model.dialogID == 7 then
            Html.Events.onClick ContinueDialog
          else if model.dialogID == 8 then
            Html.Events.onClick ContinueDialog
          else if model.dialogID == 13 then
            Html.Events.onClick ContinueDialog
          else A.style "left" "0"
        ]
        [ Html.div
            [ A.style "width" (String.fromFloat pixelWidth ++ "px")
            , A.style "height" (String.fromFloat pixelHeight ++ "px")
            , A.style "position" "absolute"
            , A.style "left" (String.fromFloat ((w - pixelWidth * r) / 2) ++ "px")
            , A.style "top" (String.fromFloat ((h - pixelHeight * r) / 2) ++ "px")
            , A.style "transform-origin" "0 0"
            , A.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
            ]
            ([viewWindow,toolbar,
            case model.scene of
                1 ->
                    Html.div[]
                    ([ bar
                     , if model.rain==False then bar else rain
                     , if model.showRain==True then Html.div[][rain2,enterPub] else viewDescription ""
                     , board
                     , if model.dialogID /=0 then Html.div[][dialogBox,viewDialog model] else viewDescription ""
                     , if model.button1 == True && model.rain==False then Html.div[][security,security2] else viewDescription ""
                     , if model.boardAppear == True then
                        Html.div[]([rainBoard]++rainboard2)
                       else
                        viewDescription ""
                     , if model.transition2==True then transition2 else viewDescription ""
                     , if model.clicked ==True then
                        let
                            x = model.mouseX - ((w - pixelWidth * r) / 2)
                            y = model.mouseY - ((h - pixelHeight * r) / 2)
                        in
                        Html.div[ A.style "position" "absolute"
                                , A.style "width" "10%"
                                , A.style "height" "10%"
                                , A.style "left" <| Debug.toString x ++ "px"
                                , A.style "top" <| Debug.toString y ++ "px"
                                , A.style "transform" "translate(-50%,-50%)"
                                ][pointer model]
                       else
                        text ""
                     ] ++ toolsUnfound)
                2 ->
                    Html.div[]
                    [ pub
                    , if model.dialogID ==0 then div[][outPub,drunk,bartender,piano] else viewDescription ""
                    , if model.transition1==True then transition1 else viewDescription ""
                    , if model.dialogID /=0 then Html.div[][dialogBox,viewDialog model] else viewDescription ""
                    , if model.askDrunk ==True then
                        div[ A.style "top" "50%"
                           , A.style "left" "50%"
                           , A.style "position" "absolute"
                           , A.style "transform" "translate(-50%,-50%)"
                           ][input [ placeholder "Ask him something", value model.content, onInput Change ][]]
                      else
                        viewDescription ""
                    , if model.showBarOptions == True && model.dialogID == 6 then div[][barOption1 model,barOption2 model,barOption3 model] else viewDescription ""
                    , if model.showMixDrink == True then mixDrink else viewDescription ""
                    , if model.showPiano == True && model.pianoValue /= "ADFBEGC" then
                        Html.div[][ pianoBackground,pianoE model,pianoD model,pianoC model,pianoB model, pianoA model,pianoG model
                                  , pianoF model,pianoBlack,pressF,pressG,pressA,pressB,pressC,pressD,pressE,pianoBack]
                      else viewDescription ""
                    ]
                3 ->
                    renderSokoban model
                _ ->
                    viewDescription ""

            ]++toolsStored)
        ]


renderFeature1: Model -> Html Msg
renderFeature1 model =
    if model.status == Playing then
        div
        [ style "width" "100%"
        , style "height" "100%"
        , style "position" "absolute"
        , style "left" "50%"
        , style "top" "50%"
        , style "transform" "translate(-50%,0)"
        , style "background-image" "url(resources/Background.jpg)"
        , style "background-size" "100% 100%"
        ]
        [renderPipeButton  0 model,renderPipeButton  1 model,renderPipeButton  2 model,renderPipeButton  3 model,renderPipeButton  4 model
        ,renderPipeButton  5 model,renderPipeButton  6 model,renderPipeButton  7 model,renderPipeButton  8 model,renderPipeButton  9 model,renderPipeButton  10 model,renderPipeButton  11 model,renderPipeButton  12 model,renderPipeButton  13 model,renderPipeButton  14 model
        ]
    else
        div[][text "You win!"]


renderFeature2: Model -> Html Msg
renderFeature2 model =
    let
        elements =
            [  viewWorldmap model.worldmap
            , renderCityButton 0 model
            , renderCityButton 1 model
            , renderCityButton 2 model
            , renderCityButton 3 model
            , renderCityButton 4 model
            , renderCityButton 5 model
            , renderCityButton 6 model
            ,viewMapprompt
           ]
    in
    if model.state == Playing_w then
       div
      [ style "width" "100%"
      , style "height" "100%"
      ,style "position" "absolute"
      , style "background-image" "url(resources/Background.jpg)"
      , style "background-size" "100% 100%"
    --, style "background-attachment" "fixed"
      ]
      (List.concat [ elements])
      {-[ Svg.svg
                                  [ width (String.fromFloat (model.window.width + model.window.x))
                                  , height (String.fromFloat (model.window.height + model.window.y))
                                  ]
                                  (List.concat [ elements, block ])
                              , viewDescription3 "You win!"
                              , renderRestartButton
                              ]-}
    else if model.state == MapLose then
      div
      [ ]
      [ viewDescription "You Lose"
      ]
    else
      div
      [ ]
      [viewDescription "You Win"
      ]



renderSokoban: Model -> Html Msg
renderSokoban model =
    let
        blocks = blockListBackground (Tuple.first model.sodoPos , Tuple.second model.sodoPos,model) (Array.toList model.sodoBlock)
    in
    div
        [ style "left" "0px" --define the x coordinate of the panel
        , style "position" "absolute"
        , style "right" "0"
        , style "top" "-300px"
        ]
    [ div
        [ width "100%"
        , height "100%"
        ]
        (  blocks )
    ]


renderPipeButton : Int -> Model -> Html Msg
renderPipeButton  p model=
    let
        (x,y) = getPos (get p model.pipes)
    in
    button
    [ style "height" "60px"
    , style "width" "100px"
    , style "line-height" "60px"
    , style "outline" "none"
    , style "border" "none"
   -- , style "padding" "0"
    , style "position" "absolute"
    , style "left" x
    , style "top" y
    , style "align" "center"
    , style "background-size" "cover"
    , style "background-image" (backgroundForPipes (get p model.pipes))
    , Html.Events.onClick (Rotate p)]
    []



--https://www.z4a.net/images/2020/07/10/whiteball.jpg
--https://www.z4a.net/images/2020/07/10/redball.jpg
viewWorldmap : Worldmap -> Html msg
viewWorldmap worldmap =
    img
        [ src "https://www.z4a.net/images/2020/07/10/worldmap.jpg"
        , style "left" <| String.fromFloat worldmap.x ++ "px"
        , style "top" <| String.fromFloat worldmap.y ++ "px"
        , style "position" "absolute"
        ]
        []

-----feature should be added that the prompt would appear after the previous gear is solved-----
viewMapprompt : Html msg
viewMapprompt =
    img
        [ src "resources/mapprompt.png"
        , style "left" "1500px"
        , style "top" "50px"
        , style "position" "absolute"
        ]
        []

{-viewBall : Ball -> Svg msg
viewBall ball =
    Svg.circle
        [ Svg.Attributes.fill <| ball.background
        , Svg.Attributes.cx <| String.fromFloat ball.x
        , Svg.Attributes.cy <| String.fromFloat ball.y
        , Svg.Attributes.r <| String.fromFloat ball.radius
        ]
        []-}

{-renderCityButton : (Int,Int) -> Model -> Html Msg
renderCityButton (x,y) model =
    button
        [style "outline" "none"
        ,style "border" "none"
        , style "left" <| String.fromInt x ++ "px"
        , style "top" <| String.fromInt y ++ "px"
        , style "cursor" "pointer"
        , style "height" "60px"
        , style "position" "absolute"
        , style "width" "60px"
        , style "background-size" "cover"
        , style "background-image" model.cityColor
        , onClick Changecolor
        ]
        []-}

renderCityButton : Int -> Model -> Html Msg
renderCityButton index model =
    let
        {-getPos : Maybe Pipe -> (String,String)
        getPos p =
            case p of
                Just p1 ->
                    p1.pos
                Nothing ->
                    ("0px","0px")-}
        background =
            case (Array.get index model.cityColorArray) of
                Nothing ->
                    " "
                Just a ->
                    a
        x =
            case (Array.get index model.cityPositionArrayx) of
                Nothing ->
                    200 ---" "

                Just xx ->
                    xx + windowx

        y =
            case (Array.get index model.cityPositionArrayy) of
                Nothing ->
                    200
                Just yy ->
                    yy + windowy

    in
       button
        [style "outline" "none"
        ,style "border" "none"
        , style "left"  <| String.fromInt x ++ "px"
        , style "top"  <| String.fromInt y ++ "px"
        , style "cursor" "pointer"
        , style "height" "20px"
        , style "position" "absolute"
        , style "width" "20px"
        , style "background-size" "contain"
        , style "background" ("no-repeat center/100%"++background)
        , Html.Events.onClick (Changecolor index)
        ]
        []