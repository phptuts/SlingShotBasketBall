//
//  GameScene.swift
//  SlingShotBasketBall
//
//  Created by Noah Glaser on 3/14/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var moveBasketball = false {
        didSet {
            print("MOVE BASKETBALL: \(moveBasketball)")
        }
    }
    
    var basketballSprite: SKSpriteNode!
    
    var rubberBand: SKShapeNode?
    
    override func didMove(to view: SKView) {
        basketballSprite = self.childNode(withName: "basketball") as? SKSpriteNode
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let nodes = self.nodes(at: location)
        
        print(nodes)
        
        moveBasketball = nodes.contains(where: { $0.name == "basketball"})
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !moveBasketball {
            return
        }
        guard let touch = touches.first else { return }
        basketballSprite.position = touch.location(in: self)
        
        rubberBand?.removeFromParent()
        let path = CGMutablePath()
        path.move(to: basketballSprite.position)
        path.addLine(to: CGPoint(x: 200, y: 300))
        

        rubberBand = SKShapeNode()
        rubberBand?.path = path
        rubberBand?.strokeColor = .purple
        rubberBand?.lineWidth = 30
        addChild(rubberBand!)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveBasketball = false
        rubberBand?.removeFromParent()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
