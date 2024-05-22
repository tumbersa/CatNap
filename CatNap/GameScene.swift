//
//  GameScene.swift
//  CatNap
//
//  Created by Глеб Капустин on 17.03.2024.
//

import SpriteKit
import GameplayKit

protocol EventListenerNode {
    func didMoveToScene()
}

protocol InteractiveNode {
    func interact()
}

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Cat: UInt32 = 0b1
    static let Block: UInt32 = 0b10
    static let Bed: UInt32 = 0b100
    static let Edge: UInt32 = 0b1000
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bedNode: BedNode!
    var catNode: CatNode!
    
    override func didMove(to view: SKView) {
        //SKTAudio.sharedInstance().playBackgroundMusic("backgroundMusic.mp3")
        
        let maxAspectRatio: CGFloat = 16.0 / 9.0
        let maxAspectRatioHeight = size.width / maxAspectRatio
        let playableMargin: CGFloat = (size.height - maxAspectRatioHeight)/2
        
        let playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: size.height-playableMargin)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: playableRect)
        physicsBody!.categoryBitMask = PhysicsCategory.Edge
        physicsWorld.contactDelegate = self
        
        enumerateChildNodes(withName: "//*") { node, _ in
            if let eventListenerNode = node as? EventListenerNode {
                eventListenerNode.didMoveToScene()
            }
        }
        
        bedNode = (childNode(withName: "bed") as! BedNode)
        catNode = (childNode(withName: "//cat_body") as! CatNode)
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.Cat | PhysicsCategory.Bed {
            print("SUCCESS")
        } else if collision == PhysicsCategory.Cat | PhysicsCategory.Edge {
            print("FAIL")
        }
    }
    
}
