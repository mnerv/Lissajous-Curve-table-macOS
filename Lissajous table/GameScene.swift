//
//  GameScene.swift
//  Lissajous table
//
//  Created by Pratchaya Khansomboon on 2018-10-31.
//  Copyright © 2018 Pratchaya K. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //MARK: Global Variables
    var test = [[String]]()
    var sceneSize = CGSize(width: 0, height: 0)
    var radius: Double = 0
    var circles = [[Curve]]()
    
    var columnCount: Int = 10
    var rowCount: Int = 0
    var circleRadiusRatio = 0.9
    
    //MARK: Start Function
    override func didMove(to view: SKView) {
        sceneSize = self.size
        radius = Double(sceneSize.width)/Double(columnCount+1)/2
        
        for x in 1...columnCount{
            let xPosition = Double(x)*radius*2+radius - Double(sceneSize.width/2)
            let yPosition = Double(sceneSize.height/2) - Double(x)*radius*2-radius
            let xColor = CGColor.white
            let yColor = CGColor.white
            if(yPosition - radius < Double(-sceneSize.height/2)){
                if rowCount == 0 {
                    rowCount = x
                }
                self.circles.append([Curve(radius: CGFloat(radius * circleRadiusRatio), locationOrigin: CGPoint(x: xPosition, y: Double(sceneSize.height/2) - radius), color: xColor, multipler: Double(x))])
            } else {
                self.circles.append([Curve(radius: CGFloat(radius * circleRadiusRatio), locationOrigin: CGPoint(x: xPosition, y: Double(sceneSize.height/2) - radius), color: xColor, multipler: Double(x)),
                                     Curve(radius: CGFloat(radius * circleRadiusRatio), locationOrigin: CGPoint(x: -Double(sceneSize.width/2) + radius, y: yPosition), color: yColor, multipler: Double(x))])
            }
        }
        
        for cir in self.circles{
            for shape in cir{
                shape.createCircle()
                self.addChild(shape.getShape())
            }
        }
        
        for i in 0..<3{
            test.append(["x" + String(i), "y" + String(i)])
        }
        test.append(["x"])
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 49:
            for i in test{
                print(i)
            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}