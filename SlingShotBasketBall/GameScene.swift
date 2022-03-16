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
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         moveBasketball = false
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
