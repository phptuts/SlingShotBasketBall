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
    
    var ballInMotion = false
    
    let slingshotPoint = CGPoint(x: 200, y: 300)
    
    override func didMove(to view: SKView) {
        basketballSprite = self.childNode(withName: "basketball") as? SKSpriteNode
        basketballSprite.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        basketballSprite.physicsBody?.affectedByGravity = false
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let nodes = self.nodes(at: location)
        
        print(nodes)
        
        moveBasketball = nodes.contains(where: { $0.name == "basketball"})
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !moveBasketball || ballInMotion {
            return
        }
        guard let touch = touches.first else { return }
        basketballSprite.position = touch.location(in: self)
        
        rubberBand?.removeFromParent()
        let path = CGMutablePath()
        path.move(to: basketballSprite.position)
        path.addLine(to: slingshotPoint)
        

        rubberBand = SKShapeNode()
        rubberBand?.path = path
        rubberBand?.strokeColor = .purple
        rubberBand?.lineWidth = 30
        addChild(rubberBand!)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        moveBasketball = false
        
        let basketballPoint = basketballSprite.position

        let velocity = 10
        
        
        print("\(180 - basketballPoint.angle(to: slingshotPoint)) angle")
        
        rubberBand?.removeFromParent()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}


// https://stackoverflow.com/a/58137779
//extension CGPoint {
//    func angle( ending: CGPoint) -> CGFloat {
//        let center = CGPoint(x: ending.x - self.x, y: ending.y - self.y)
//        let radians = atan2(center.y, center.x)
//        let degrees = radians * 180 / .pi
//        return degrees > 0 ? degrees : degrees + degrees
//    }
//}

extension CGFloat {
    var degrees: CGFloat {
        return self * CGFloat(180) / .pi
    }
}

extension CGPoint {
    func angle(to comparisonPoint: CGPoint) -> CGFloat {
        let originX = comparisonPoint.x - x
        let originY = comparisonPoint.y - y
        let bearingRadians = atan2f(Float(originY), Float(originX))
        var bearingDegrees = CGFloat(bearingRadians).degrees

        while bearingDegrees < 0 {
            bearingDegrees += 360
        }

        return bearingDegrees
    }
}
