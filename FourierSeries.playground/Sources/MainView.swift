import UIKit
import SpriteKit

public class MainView: UIView {
    
    private let scene: SKScene!
    
    public init(_ scene: SKScene) {
        self.scene = scene
        super.init(frame: CGRect(x: 0, y: 0, width: 750, height: 750))
        
        self.loadScene()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func loadScene() {
        let skView = SKView(frame: self.frame)
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.backgroundColor = .blue
        addSubview(skView)
        
//        let scene = PathDrawingScene(size: self.bounds.size)
//        let scene = FourierSeriesScene(size: self.bounds.size)
        scene.size = self.bounds.size
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
    
}

