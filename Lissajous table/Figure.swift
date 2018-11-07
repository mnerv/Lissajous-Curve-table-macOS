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
    
    init(radius: CGFloat, locationOrigin: CGPoint, color: CGColor, multipler: Double) {
        self.radius = radius
        self.locationOrigin = locationOrigin
        self.multipler = multipler
        self.circleColor = color
    }
    
    func createCircle() {
        self.shape = SKShapeNode(circleOfRadius: self.radius)
        self.shape?.position = self.locationOrigin
    }
    
    func appendPointsArray(location: CGPoint) {
        self.pointsArr.append(location)
    }
    
    func resetPointsArray() -> Void {
        self.pointsArr = []
    }
    
    func createTraceDot(radius: Double) {
        self.dotShape = SKShapeNode(circleOfRadius: CGFloat(radius))
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
