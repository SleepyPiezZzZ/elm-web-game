module Message exposing (..)
import Animation
import Browser.Dom exposing (Viewport)
import Draggable
import Time exposing (..)
import Html.Events.Extra.Mouse as Mouse

type Msg
    = OnDragBy Draggable.Delta
    | OnDragStart String
    | OnDragEnd
    | DragMsg (Draggable.Msg String)
    | GetViewport Viewport
    | Resize Int Int
    | Tick Time.Posix
    | Click Mouse.Event
    | TickClick Time.Posix
    | ShowCursor Bool
    | SetCursor String
    | ToggleCursor
    | NextKey
    | Security
    | Drunk
    | Bartender
    | BarOptions
    | Pub
    | OutPub
    | MixDrink
    | EndMixDrink Time.Posix
    | PressTime Time.Posix
    | Piano
    | PressF
    | PressG
    | PressA
    | PressB
    | PressC
    | PressD
    | PressE
    | PianoBack
    | AskOwner
    | AskWarehouse
    | EndTransition1 Time.Posix
    | EndTransition2 Time.Posix
    | ContinueDialog
    | EndDialog
    | ShowTypebox
    | InputText
    | Change String
    | Rain Time.Posix
    | Pulse Int
    | Animate Animation.Msg
    | Rotate Int
    | Changecolor Int
    | ToFirstPage
    | MoveLeftBlock
    | MoveRightBlock
    | MoveUpBlock
    | MoveDownBlock
    | NoOp
