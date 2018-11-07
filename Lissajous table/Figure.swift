//
//  Figure.swift
//  Lissajous table
//
//  Created by Pratchaya Khansomboon on 2018-11-03.
//  Copyright © 2018 Pratchaya K. All rights reserved.
//

import Foundation
import SpriteKit

class Curve {
    //MARK: Private Variables
    private let radius: CGFloat
    private var locationOrigin: CGPoint
    private var circleColor: CGColor
    private let multipler: Double
    private var shape: SKShapeNode?
    private var dotShape: SKShapeNode?
    private var dotLocation: CGPoint?
    
    //MARK: Public Varables
    var pointsArr = [CGPoint]()
    var showTraceDot: Bool = true
    var traceDotRadius: Double = 4
    
    init(radius: CGFloat, locationOrigin: CGPoint, color: CGColor, multipler: Double) {
        self.radius = radius
        self.locationOrigin = locationOrigin
        self.multipler = multipler
        self.circleColor = color
    }
    
    func createCircle() {
        self.shape = SKShapeNode(circleOfRadius: self.radius)
        self.shape?.position = self.locationOrigin
        createTraceDot(radius: traceDotRadius)
    }
    
    func appendPointsArray(location: CGPoint) {
        self.pointsArr.append(location)
        setTraceDotLocation(location: location)
        
    }
    
    func resetPointsArray() -> Void {
        self.pointsArr = []
    }
    
    func createTraceDot(radius: Double) {
        if showTraceDot{
            self.dotShape = SKShapeNode(circleOfRadius: CGFloat(radius))
    //        self.dotShape?.lineWidth = 3
            self.dotShape?.fillColor = NSColor.white
            self.dotShape?.position = CGPoint(x: self.locationOrigin.x, y: self.locationOrigin.y + self.radius)
        }
    }
    
    func advanceTraceDot(counter: Int) {
        let radian = (Double(counter)*Double.pi*self.multipler)/180
        self.dotShape?.position = CGPoint(x: Double(self.locationOrigin.x) + (Double(self.radius) * -sin(radian)),
                                          y:  Double(self.locationOrigin.y) + (Double(self.radius) * cos(radian)))
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
    
    func getLocationOrigin() -> CGPoint {
        return self.locationOrigin
    }
    
}
