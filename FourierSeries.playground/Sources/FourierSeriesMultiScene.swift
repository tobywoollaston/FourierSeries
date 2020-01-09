import SpriteKit

public class FourierSeriesMultiScene: SKScene {
    
    var time: CGFloat = 0;
    let center = CGPoint(x: 175, y: 350)
    let number: Int = 5;
    var radii = [CGFloat]()
    var circles = [SKShapeNode]()
    var dots = [SKShapeNode]()
    var wave = [CGFloat]()
    var wavePath: CGMutablePath!
    var waveShape: SKShapeNode!
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
    
        backgroundColor = .black
        
        var point = center
        for i in 0...(number-1) {
            let n = CGFloat(i) * 2 + 1
            let radius = 75 * (4 / (n * CGFloat.pi))
            radii.append(radius)
            
            let circle = SKShapeNode(ellipseOf: CGSize(width: radius*2, height: radius*2))
            circle.strokeColor = .white
            circle.position = point
            addChild(circle)
            circles.append(circle)
            
            point.x += radius
            
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
        
        for i in 0...(number-1) {
            let n = CGFloat(i) * 2 + 1
            point.x += radii[i] * cos(n * time)
            point.y += radii[i] * sin(n * time)
            
            dots[i].position = point
            
            if i+1 != dots.count {
                circles[i+1].position = point
            }
            
            wavePath.addLine(to: point)
        }
        wave.insert(point.y, at: 0)
        
        for x in 0...(wave.count-1) {
            wavePath.addLine(to: CGPoint(x: center.x + radii[0] + 70 + CGFloat(x), y: wave[x]))
        }
        if wave.count > 450 {
            wave.removeLast()
        }
        
        waveShape.path = wavePath
        waveShape.lineWidth = 2
        waveShape.strokeColor = .white
            
        time += 0.01
        
    }
    
}

