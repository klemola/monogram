module Main exposing (..)

import Html exposing (Html, div)
import Svg exposing (Svg, circle, polyline, g, svg)
import Svg.Attributes exposing (..)


mgRadius : Float
mgRadius =
    200


mgLineWidth : Float
mgLineWidth =
    mgRadius / 10


letterMPoints : List ( Float, Float )
letterMPoints =
    [ --green
      ( sin (pi * 1.25), cos (pi * -0.25) )

    --blue
    , ( sin (pi * 1.25), cos (pi * 0.75) )

    --center
    , ( 0, 0 )

    --red
    , ( sin (pi * 0.75), cos (pi * 0.75) )

    --yellow
    , ( sin (pi * 0.75), cos (pi * 2.25) )
    ]


mgStroke : Svg.Attribute msg
mgStroke =
    stroke "black"


mgStrokeWidth : Svg.Attribute msg
mgStrokeWidth =
    strokeWidth (toString mgLineWidth)


mgViewBox : Svg.Attribute msg
mgViewBox =
    [ -(mgRadius + mgLineWidth / 2)
    , -(mgRadius + mgLineWidth / 2)
    , (mgRadius * 2) + mgLineWidth
    , (mgRadius * 2) + mgLineWidth
    ]
        |> List.map toString
        |> String.join " "
        |> viewBox


illustrativeDots : List (Svg msg)
illustrativeDots =
    let
        zip xs ys =
            case ( xs, ys ) of
                ( x :: xBack, y :: yBack ) ->
                    ( x, y ) :: zip xBack yBack

                ( _, _ ) ->
                    []
    in
        [ "red", "blue", "orange", "yellow", "green" ]
            |> zip letterMPoints
            |> List.map
                (\( ( x, y ), color ) ->
                    circle
                        [ cx <| toString (mgRadius * x)
                        , cy <| toString (mgRadius * y)
                        , fill color
                        , r (toString mgLineWidth)
                        ]
                        []
                )


toPolylinePoints : List ( Float, Float ) -> String
toPolylinePoints pointsList =
    pointsList
        |> List.map (\( x, y ) -> ( mgRadius * x, mgRadius * y ))
        |> List.map (\( x, y ) -> toString x ++ "," ++ toString y)
        |> String.join " "


main : Html a
main =
    svg
        [ width "250"
        , height "250"
        , mgViewBox
        ]
        [ g []
            [ circle
                [ cx "0"
                , cy "0"
                , r (toString mgRadius)
                , fill "none"
                , mgStroke
                , mgStrokeWidth
                ]
                []
            , polyline
                [ mgStroke
                , mgStrokeWidth
                , points <|
                    toString -mgRadius
                        ++ ",0 "
                        ++ toString mgRadius
                        ++ ",0"
                ]
                []
            , polyline
                [ mgStroke
                , mgStrokeWidth
                , fill "none"
                , points (toPolylinePoints letterMPoints)
                , strokeLinejoin "round"
                , strokeLinecap "round"
                ]
                []
            ]

        -- , g [] illustrativeDots
        ]
