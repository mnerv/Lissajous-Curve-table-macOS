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
    var circles = [[Rings]]()
    var traces = [[Curve]]()
    
    var columnCount: Int = 6
    var rowCount: Int = 0
    var circleRadiusRatio = 0.82
    
    var counter: Int = 0
    
    //MARK: Start Function
    override func didMove(to view: SKView) {
        sceneSize = self.size
        radius = Double(sceneSize.width)/Double(columnCount+1)/2
        
        var tempColumn = [Rings]()
        var tempRow = [Rings]()

        for x in 1...columnCount{
            let xPosition = Double(x)*radius*2+radius - Double(sceneSize.width/2)
            let yPosition = Double(sceneSize.height/2) - Double(x)*radius*2-radius
            let xColor = CGColor(red: CGFloat(x)/CGFloat(columnCount), green: 0.5, blue: 1, alpha: 1)
            let yColor = CGColor(red: 1, green: CGFloat(x)/CGFloat(columnCount), blue: 0.5, alpha: 1)
            
            if(yPosition - radius < Double(-sceneSize.height/2)){
                if rowCount == 0 {
                    rowCount = x - 1
                }
                tempColumn.append(Rings(radius: CGFloat(radius * circleRadiusRatio), locationOrigin: CGPoint(x: xPosition, y: Double(sceneSize.height/2) - radius), color: xColor, multipler: Double(x)))
                
            } else {
                tempColumn.append(Rings(radius: CGFloat(radius * circleRadiusRatio), locationOrigin: CGPoint(x: xPosition, y: Double(sceneSize.height/2) - radius), color: xColor, multipler: Double(x)))
                
                tempRow.append(Rings(radius: CGFloat(radius * circleRadiusRatio), locationOrigin: CGPoint(x: -Double(sceneSize.width/2) + radius, y: yPosition), color: yColor, multipler: Double(x)))
            }
        }
        
        self.circles.append(tempColumn)
        self.circles.append(tempRow)
        tempRow = []
        tempColumn = []
        
        var temp = [Curve]()
        for x in 0..<columnCount{
            temp = []
            for y in 0..<rowCount{
                let mulitpliedColor = multiplyColor(colorA: self.circles[0][x].circleColor, colorB: self.circles[1][y].circleColor)

                let location = CGPoint(x: self.circles[0][x].getDotLocation().x, y: self.circles[1][y].getDotLocation().y)
                temp.append(Curve(startLocation: location, color: mulitpliedColor))
            }
            self.traces.append(temp)
        }
        
        for element in self.traces{
            for element1 in element{
                self.addChild(element1.getDotShape())
                self.addChild(element1.getShape())
            }
        }
        
        for (index, element) in self.circles.enumerated(){
            for element1 in element{
//                if index == 0{
//                    element1.createLine(location: element1.getDotLocation(), vertical: true, screenSize: self.sceneSize)
//                } else {
//                    element1.createLine(location: element1.getDotLocation(), vertical: false, screenSize: self.sceneSize)
//                }
                self.addChild(element1.getShape())
                self.addChild(element1.getDotShape())

            }
        }

    }
    
    func multiplyColor(colorA: CGColor, colorB: CGColor) -> CGColor{
        let multipliedColor = CGColor(red: colorA.components![0] * colorB.components![0], green: colorA.components![1] * colorB.components![1], blue: colorA.components![2] * colorB.components![2], alpha: colorA.components![3] * colorB.components![3])
        
        return multipliedColor
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 49:
            counter = 0
            
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    func animateTraces(){
        for x in 0..<columnCount{
            for y in 0..<rowCount{
                self.circles[0][x].advanceTraceDot(counter: counter)
                self.circles[1][y].advanceTraceDot(counter: counter)
                
                let location = CGPoint(x: self.circles[0][x].getDotLocation().x, y: self.circles[1][y].getDotLocation().y)
                self.traces[x][y].appendPointsArray(location: location)
            }
            
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        counter += 1
        if(counter > 360){
            counter = 0
        }

        self.removeAllChildren()
        self.animateTraces()
        for cir in self.circles{
            for shape in cir{
                self.addChild(shape.getShape())
                self.addChild(shape.getDotShape())
//                self.addChild(shape.getLineShape())
            }
        }
        for element in self.traces{
            for element1 in element{
                if counter == 0 {
                    element1.resetPointsArray()
                }
                self.addChild(element1.getDotShape())
                self.addChild(element1.getShape())
            }
        }
    }
    
}
