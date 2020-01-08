import UIKit
import PlaygroundSupport

//need to use sprite kit to draw a line where the user draws
//then use sprite kit to draw the the fourier transform for each

//let scene = PathDrawingScene()
//let scene = FourierSeriesScene()
//let scene = FourierSeriesMultiScene()
//let scene = FourierTransformPicScene()
//let scene = FourierTransform2DScene()
//let scene = FourierTransform2DPicScene()
let scene = DrawingFourierTransform()

let view = MainView(scene)
PlaygroundPage.current.liveView = view
