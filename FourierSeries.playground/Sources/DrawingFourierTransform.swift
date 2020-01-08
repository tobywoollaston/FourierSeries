import SpriteKit

extension CGRect {
    var midPoint: CGPoint {
        get {
            return CGPoint(x: self.midX, y: self.midY)
        }
    }
}

public class DrawingFourierTransform: SKScene {
    
    enum Mode {
        case user, fourier
    }
    var mode: Mode!
    var drawingShape: SKShapeNode!
    var drawingPath: CGMutablePath!
    var points: [CGPoint]!
    
    var center: CGPoint!
    var fourier: [ComplexNumber]!
    var time: CGFloat = 0;
    var circles = [SKShapeNode]()
    var dots = [SKShapeNode]()
    var wave = [CGPoint]()
    var circlePath: CGMutablePath!
    var circlePathShape: SKShapeNode!
    var wavePath: CGMutablePath!
    var waveShape: SKShapeNode!
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        backgroundColor = .black
        
        mode = .user
        drawingShape = SKShapeNode()
        addChild(drawingShape)
        
        center = view.frame.midPoint
        
        circlePathShape = SKShapeNode()
        addChild(circlePathShape)

        waveShape = SKShapeNode()
        addChild(waveShape)
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let location = touches.first!.location(in: self)
        
        mode = .user
        drawingPath = CGMutablePath()
        drawingPath.move(to: location)
        points = [location]
        
        circles.forEach { $0.removeFromParent() }
        dots.forEach { $0.removeFromParent() }
        
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        let location = touches.first!.location(in: self)
        
        drawingPath.addLine(to: location)
        points.append(location)
        
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
                
        drawingPath.closeSubpath()
        mode = .fourier
        
        time = 0
        wave = []
        circles.removeAll()
        dots.removeAll()
        
        fourier = dft(points)
        var point = center!
        for i in 0...(fourier.count-1) {

            let freq = fourier[i].freq!
            let radius = fourier[i].amp!
            let phase = fourier[i].phase!

            let circle = SKShapeNode(ellipseOf: CGSize(width: radius*2, height: radius*2))
            circle.strokeColor = SKColor(white: 0.5, alpha: 0.2)
            circle.position = point
            addChild(circle)
            circles.append(circle)

            let x = radius * cos(freq * time + phase)// + (CGFloat.pi / 2))
            let y = radius * sin(freq * time + phase)// + (CGFloat.pi / 2))

            point.x += x
            point.y += y

            let dot = SKShapeNode(ellipseOf: CGSize(width: 2, height: 2))
            dot.fillColor = .clear//SKColor(white: 0.5, alpha: 0.2)
            dot.strokeColor = .clear
            dot.position = point
            addChild(dot)
            dots.append(dot)
        }
        
        
    }
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
                    
        drawingShape.path = drawingPath
        drawingShape.strokeColor = .blue
        
        if mode == .user {
            
            circlePathShape.path = CGMutablePath()
            waveShape.path = CGMutablePath()
            
            return
        }
        
        var point = center!
                
        circlePath = CGMutablePath()
        circlePath.move(to: point)

        wavePath = CGMutablePath()
//        wavePath.move(to: point)

        for i in 0...(fourier.count-1) {

            let freq = fourier[i].freq!
            let radius = fourier[i].amp!
            let phase = fourier[i].phase!

            let x = radius * cos(freq * time + phase)// + (CGFloat.pi / 2))
            let y = radius * sin(freq * time + phase)// + (CGFloat.pi / 2))

            point.x += x
            point.y += y

            dots[i].position = point

            if i+1 != dots.count {
                circles[i+1].position = point
            }
                    
            circlePath.addLine(to: point)
                    
//            wavePath.addLine(to: point)
        }
                
        circlePathShape.path = circlePath
        circlePathShape.strokeColor = .red
        circlePathShape.lineWidth = 0.5
        
        wave.insert(point, at: 0)

        wavePath.move(to: point)

        for x in 0...(wave.count-1) {
            wavePath.addLine(to: wave[x])
        }
        if wave.count > 150 {
            wave.removeLast()
        }

        waveShape.path = wavePath
        waveShape.lineWidth = 2
        waveShape.strokeColor = .white

        let dt = (2 * CGFloat.pi) / CGFloat(fourier.count)
        time += dt //* 0.1
        
    }
    
    func dft(_ input: [CGPoint]) -> [ComplexNumber] {
        var x = [ComplexNumber]()
        input.forEach { x.append(ComplexNumber(re: $0.x - center.x, im: $0.y - center.y)) }
        
        var X = [ComplexNumber]()
        let N = x.count
        
        for k in 0...(N-1) {
            let sum = ComplexNumber(re: 0, im: 0)
            
            for n in 0...(N-1) {
                let phi = ((2 * CGFloat.pi) * CGFloat(k) * CGFloat(n)) / CGFloat(N)
                let c = ComplexNumber(re: cos(phi), im: -sin(phi))
                sum.add(.mult(x[n], c))
            }
            
            sum.re = sum.re / CGFloat(N)
            sum.im = sum.im / CGFloat(N)
            
            sum.freq = CGFloat(k)
            sum.amp = (sum.re * sum.re + sum.im * sum.im).squareRoot()
            sum.phase = atan2(sum.im, sum.re)
            X.append(sum)
        }
        
        return X
    }
    
}
