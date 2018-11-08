//
//  Figure.swift
//  Lissajous table
//
//  Created by Pratchaya Khansomboon on 2018-11-03.
//  Copyright © 2018 Pratchaya K. All rights reserved.
//

import Foundation
import SpriteKit

class Rings {
    //MARK: Private Variables
    private let radius: CGFloat
    private var locationOrigin: CGPoint
    private let multipler: Double
    private var shape: SKShapeNode?
    private var dotShape: SKShapeNode?
    private var dotLocation: CGPoint?
    private var lineShape: SKShapeNode?
    private var vertical: Bool = false
    
    //MARK: Public Varables
    var circleColor: CGColor
    var showTraceDot: Bool = true
    var traceDotRadius: Double = 5
    var multipliedColor: CGColor?
    
    init(radius: CGFloat, locationOrigin: CGPoint, color: CGColor, multipler: Double) {
        self.radius = radius
        self.locationOrigin = locationOrigin
        self.multipler = multipler
        self.circleColor = color
        
        self.createCircle()
    }
    
    func createCircle() {
        self.shape = SKShapeNode(circleOfRadius: self.radius)
        self.shape?.position = self.locationOrigin
        self.shape?.strokeColor = NSColor(cgColor: self.circleColor)!
        createTraceDot(radius: traceDotRadius)
    }
    
    func createLine(location: CGPoint, vertical: Bool, screenSize: CGSize) {
        var pointArr = [CGPoint]()
        self.vertical = vertical
        
        if(self.vertical){
            pointArr.append(CGPoint(x: location.x, y: screenSize.height/2))
            pointArr.append(CGPoint(x: location.x, y: -screenSize.height/2))
        } else {
            pointArr.append(CGPoint(x: -screenSize.width/2, y: location.y))
            pointArr.append(CGPoint(x: screenSize.width/2, y: location.y))
        }
    
        self.lineShape = SKShapeNode(points: &pointArr, count: pointArr.count)
        self.lineShape?.strokeColor = NSColor.init(cgColor: circleColor)!
    }
    
    func setLineLocation(location: CGPoint) {
        if(self.vertical){
            self.lineShape?.position.x = location.x
        } else {
            self.lineShape?.position.y = location.y
        }
    }
    
    func setMultipliedColor(colorA: CGColor, colorB: CGColor) {
        self.multipliedColor = CGColor(red: colorA.components![0] * colorB.components![0], green: colorA.components![1] * colorB.components![1], blue: colorA.components![2] * colorB.components![2], alpha: colorA.components![3] * colorB.components![3])
    }
    
    func createTraceDot(radius: Double) {
        if showTraceDot{
            self.dotShape = SKShapeNode(circleOfRadius: CGFloat(radius))
            self.dotShape?.fillColor = NSColor.white
            self.dotShape?.position = CGPoint(x: self.locationOrigin.x, y: self.locationOrigin.y + self.radius)
        }
    }
    
    func advanceTraceDot(counter: Int) {
        let radian = (Double(counter)*Double.pi*self.multipler)/180
        let tempPoint = CGPoint(x: Double(self.locationOrigin.x) + (Double(self.radius) * -sin(radian)),
                               y:  Double(self.locationOrigin.y) + (Double(self.radius) * cos(radian)))
        self.dotShape?.position = tempPoint
    }
    
    func setTraceDotLocation(location: CGPoint) {
        self.dotShape?.position = location
    }
    
    func getShape() -> SKShapeNode {
        return self.shape!
    }
    
    func getDotShape() -> SKShapeNode {
        return self.dotShape!
    }
    
    func getLineShape() -> SKShapeNode {
        return self.lineShape!
    }
    
    func getDotLocation() -> CGPoint {
        return self.dotShape!.position
    }
    
    func getLocationOrigin() -> CGPoint {
        return self.locationOrigin
    }
    
}

class Curve {
    private var shape: SKShapeNode?
    var dotShape: SKShapeNode
    
    //MARK: Public Varables
    var color: CGColor
    var showTraceDot: Bool = true
    var traceDotRadius: Double = 5
    var pointsArr = [CGPoint]()
    
    init(startLocation: CGPoint, color: CGColor) {
        self.color = color
        self.dotShape = SKShapeNode(circleOfRadius: CGFloat(self.traceDotRadius))
        self.dotShape.position = startLocation
        
        self.createCurve()
    }
    
    func createCurve() {
        self.shape = SKShapeNode(points: &self.pointsArr, count: self.pointsArr.count)
        self.shape?.lineWidth = 2
        self.shape?.strokeColor = NSColor.init(cgColor: color)!
    }
    
    func appendPointsArray(location: CGPoint) {
        if self.pointsArr.isEmpty{
            self.pointsArr.append(location)
        } else {
            if !checkIfDuplicate(location: location){
                self.pointsArr.append(location)
            }
        }
        setTraceDotLocation(location: location)
    }
    
    func checkIfDuplicate(location: CGPoint) -> Bool {
        var temp = false
        for x in self.pointsArr{
            if location == x{
                temp = true
            } else {
                temp = false
            }
        }
        return temp
    }
    
    func getDotShape() -> SKShapeNode {
        return self.dotShape
    }
    
    func getShape() -> SKShapeNode {
        self.createCurve()
        return self.shape!
    }
    
    func setTraceDotLocation(location: CGPoint) {
        self.dotShape.position = location
    }
    
    func resetPointsArray() -> Void {
        self.pointsArr = []
    }
}
