import SpriteKit

public class FourierTransformPicScene: SKScene {
    
    struct ImaginaryNumber {
        var re: CGFloat
        var im: CGFloat
        var freq: CGFloat
        var amp: CGFloat
        var phase: CGFloat
    }
    
    var y = [CGFloat]()
    var fourierY: [ImaginaryNumber]!
    
    var time: CGFloat = 0;
    let center = CGPoint(x: 175, y: 350)
    var circles = [SKShapeNode]()
    var dots = [SKShapeNode]()
    var wave = [CGFloat]()
    var wavePath: CGMutablePath!
    var waveShape: SKShapeNode!
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        backgroundColor = .black
        
//        y = [100, 100, 100, -100, -100, -100, 100, 100, 100, -100, -100, -100, 100, 100, 100, -100, -100, -100]
        for _ in 0...299 {
            y.append(CGFloat(Int.random(in: -100 ..< 100)))
        }
        fourierY = dft(y)
        
//        fourierY.forEach { print($0) }
        
        var point = center
        for i in 0...(fourierY.count-1) {
            
            let freq = fourierY[i].freq
            let radius = fourierY[i].amp
            let phase = fourierY[i].phase
            
            let circle = SKShapeNode(ellipseOf: CGSize(width: radius*2, height: radius*2))
            circle.strokeColor = .white
            circle.position = point
            addChild(circle)
            circles.append(circle)
            
            let x = radius * cos(freq * time + phase + (CGFloat.pi / 2))
            let y = radius * sin(freq * time + phase + (CGFloat.pi / 2))
            
            point.x += x
            point.y += y
            
            let dot = SKShapeNode(ellipseOf: CGSize(width: 2, height: 2))
            dot.fillColor = .white
            dot.position = point
            addChild(dot)
            dots.append(dot)
        }
        
        waveShape = SKShapeNode()
        addChild(waveShape)
        
    }
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        var point = center
        
        wavePath = CGMutablePath()
        wavePath.move(to: point)
        
        for i in 0...(fourierY.count-1) {
            
            let freq = fourierY[i].freq
            let radius = fourierY[i].amp
            let phase = fourierY[i].phase
            
            let x = radius * cos(freq * time + phase + (CGFloat.pi / 2))
            let y = radius * sin(freq * time + phase + (CGFloat.pi / 2))
            
            point.x += x
            point.y += y
            
            dots[i].position = point
            
            if i+1 != dots.count {
                circles[i+1].position = point
            }
            
            wavePath.addLine(to: point)
        }
        wave.insert(point.y, at: 0)
        
        for x in 0...(wave.count-1) {
            wavePath.addLine(to: CGPoint(x: center.x + fourierY[0].amp + 70 + CGFloat(x), y: wave[x]))
        }
        if wave.count > 450 {
            wave.removeLast()
        }
        
        waveShape.path = wavePath
        waveShape.lineWidth = 2
        waveShape.strokeColor = .white
            
        let dt = (2 * CGFloat.pi) / CGFloat(fourierY.count)
        time += dt/2
        
    }
    
    func dft(_ x: [CGFloat]) -> [ImaginaryNumber] {
        var X = [ImaginaryNumber]()
        let N = x.count
        
        for k in 0...(N-1) {
            
            var re: CGFloat = 0
            var im: CGFloat = 0
            
            for n in 0...(N-1) {
                let phi = ((2 * CGFloat.pi) * CGFloat(k) * CGFloat(n)) / CGFloat(N)
                re += x[n] * cos(phi)
                im -= x[n] * sin(phi)
            }
            
            re = re / CGFloat(N)
            im = im / CGFloat(N)
            
            let freq = CGFloat(k)
            let amp = (re * re + im * im).squareRoot()
            let phase = atan2(im, re)
            
            X.append(ImaginaryNumber(re: re, im: im, freq: freq, amp: amp, phase: phase))
        }
        
        return X
    }
    
}
