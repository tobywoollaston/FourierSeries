import SpriteKit

public class PathDrawingScene: SKScene {
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        backgroundColor = .white
        
        
//        let lineShape = SKShapeNode()
//        let path = CGMutablePath()
//        path.move(to: CGPoint(x: 50, y: 50))
//        path.addLine(to: CGPoint(x: 50, y: 150))
//        path.addLine(to: CGPoint(x: 150, y: 150))
//        path.addLine(to: CGPoint(x: 250, y: 250))
//        lineShape.path = path
//        lineShape.strokeColor = .red
//        addChild(lineShape)
        
        lineShape = SKShapeNode()
        addChild(lineShape)
        path = CGMutablePath()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        let location = touches.first!.location(in: self)
        
        path = CGMutablePath()
        path.move(to: location)
        
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

        let location = touches.first!.location(in: self)
        path.addLine(to: location)

    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        path.closeSubpath()
    }
    
    private var lineShape: SKShapeNode!
    private var path: CGMutablePath!
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        lineShape.path = path
        lineShape.strokeColor = .red
        
    }
    
}

