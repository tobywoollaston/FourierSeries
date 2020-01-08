import UIKit
import PlaygroundSupport

//need to use sprite kit to draw a line where the user draws
//then use sprite kit to draw the the fourier series for each

//let scene = PathDrawingScene()
//let scene = FourierSeriesScene()
//let scene = FourierSeriesMultiScene()
let scene = FourierTransformPicScene()

let view = MainView(scene)

PlaygroundPage.current.liveView = view
