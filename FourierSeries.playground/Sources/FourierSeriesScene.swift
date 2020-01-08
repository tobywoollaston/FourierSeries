import SpriteKit

public class FourierSeriesScene: SKScene {
    
    var time: CGFloat = 0;
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
    
        backgroundColor = .black
        
        circle = SKShapeNode(ellipseOf: CGSize(width: radius*2, height: radius*2))
        circle.strokeColor = .white
        circle.position = CGPoint(x: 175, y: 350)
        
        addChild(circle)
        
        dot = SKShapeNode(ellipseOf: CGSize(width: 8, height: 8))
        dot.fillColor = .white
        dot.position = CGPoint(x: 175 + radius/2, y: 350)
        addChild(dot)
        
        waveShape = SKShapeNode()
        addChild(waveShape)
    }
    
    private let radius: CGFloat = 150
    private var circle: SKShapeNode!
    private var dot: SKShapeNode!
    private var wave = [CGFloat]()
    private var wavePath: CGMutablePath!
    private var waveShape: SKShapeNode!
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        let x = radius * cos(time)
        let y = radius * sin(time)
        wave.insert(y, at: 0)
        
        dot.position = CGPoint(x: circle.position.x + x, y: circle.position.y + y)
        
        time += 0.025
        
        wavePath = CGMutablePath()
        wavePath.move(to: dot.position)
        for x in 0...(wave.count-1) {
//            print("\(x), \(wave.count)")
            wavePath.addLine(to: CGPoint(x: circle.position.x + circle.frame.width/2 + 50 + CGFloat(x), y: circle.position.y + wave[x]))
        }
        if wave.count > 350 {
            wave.removeLast()
        }
        waveShape.path = wavePath
        waveShape.lineWidth = 2
        waveShape.strokeColor = .white
    }
    
}

