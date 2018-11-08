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
    var sceneSize = CGSize(width: 0, height: 0)
    var radius: Double = 0
    var circles = [[Curve]]()
    var traces = [[Curve]]()
    
    var columnCount: Int = 8
    var rowCount: Int = 0
    var circleRadiusRatio = 0.82
    
    var counter: Int = 0
    
    //MARK: Start Function
    override func didMove(to view: SKView) {
        sceneSize = self.size
        radius = Double(sceneSize.width)/Double(columnCount+1)/2
        
        for x in 1...columnCount{
            let xPosition = Double(x)*radius*2+radius - Double(sceneSize.width/2)
            let yPosition = Double(sceneSize.height/2) - Double(x)*radius*2-radius
            let xColor = CGColor(red: CGFloat(x)/CGFloat(columnCount), green: 0.5, blue: 1, alpha: 1)
            let yColor = CGColor(red: 1, green: CGFloat(x)/CGFloat(columnCount), blue: 0.5, alpha: 1)
            
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
                self.addChild(shape.getDotShape())
            }
        }
        
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 49:
            print("Hello World")
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        for _ in 0..<1{
            for cir in self.circles{
                for shape in cir{
                    shape.advanceTraceDot(counter: counter)
                }
            }
            counter += 1
            if(counter > 360){
                counter = 0
                break
            }
        }
        
        self.removeAllChildren()
        for cir in self.circles{
            for shape in cir{
                self.addChild(shape.getShape())
                self.addChild(shape.getDotShape())
            }
        }
    }
    
}
