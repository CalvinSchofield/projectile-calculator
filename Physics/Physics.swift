//
//  Physics.swift
//  Physics
//
//  Created by Calvin Schofield on 10/28/15.
//  Copyright © 2015 Calvin Schofield. All rights reserved.
//

import UIKit
import Foundation


//MARK: - Extensions : CGFloat (degrees to rad && rad to degrees)
extension CGFloat {
    
    public var toDegrees: CGFloat { return self * CGFloat(M_PI / 180) }
    
    public var toRad: CGFloat { return self * CGFloat(180 / M_PI) }
    
}


//MARK: - Extensions : CGFloat (Decimal to Scientific Notation)
extension CGFloat {
    
    struct Number {
        
        static var formatter = NSNumberFormatter()
        
    }
    
    var toScientific: String {
        
        Number.formatter.numberStyle = .ScientificStyle
        
        Number.formatter.positiveFormat = "0.###E+0"
        
        Number.formatter.exponentSymbol = "e"
        
        return Number.formatter.stringFromNumber(self) ?? description
        
    }
    
}


class Physics {
    
    
    // General Components
    var VectorVelocity = CGFloat()
    
    var finalVectorVelocity = CGFloat()
    
    var degrees = CGFloat()
    
    var finalDegrees = CGFloat()
    
    
    // Max Height
    var yMaxHeight = CGFloat?()
    
    var xMaxHeight = CGFloat?()
    
    var maxHeightTime = CGFloat?()
    
    
    // Time
    var time = CGFloat?()
    
    var firstTime = CGFloat?()
    
    var secondTime = CGFloat?()
    
    enum TimeInstance {
        
        case FirstInstance
        
        case SecondInstance
        
    }
    
    var currentInstance : TimeInstance = .SecondInstance
    
    
    // X - Components
    var xInitialVelocity = CGFloat?()
    
    var xFinalVelocity = CGFloat?()
    
    var xDisplacement = CGFloat?()
    
    var xAcceleration = CGFloat?()
    
    
    // Y - Components
    var yInitialVelovity = CGFloat?()
    
    var yFinalVelocity = CGFloat?()
    
    var yDisplacement = CGFloat?()
    
    var yAcceleration  = CGFloat?()
    
    
    // Units of Measurement
    var currentUnits : Units = .MetersPerSecond
    
    
    //Can be solved or not
    var canBeSolved = false
    
    
    //MARK: - initializer : default values
    init() {
        
        switch currentUnits {
            
        case .MetersPerSecond:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
        case .FeetPerSecond:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        }
        
    }
    
    
    //MARK: - initalizer : VecotrVelocity, degree, yDisplacement
    init(VectorVelocity: CGFloat, degree: CGFloat, yDisplacement: CGFloat, currentUnits : Units) {
        
        self.currentUnits = currentUnits
        
        switch currentUnits {
            
        case .MetersPerSecond:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
        case .FeetPerSecond:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        }
        
        self.VectorVelocity = VectorVelocity
        
        self.degrees = degree
        
        self.yDisplacement = yDisplacement
        
        
        findVelocity(VectorVelocity, degree: degree)
        
        self.canBeSolved = checkTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        self.time = findTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        if self.yDisplacement == 0 {
            
            self.maxHeightTime = self.time! / 2
            
            findMaxHeight(self.yInitialVelovity!, time: self.time!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        } else {
            
            self.maxHeightTime = findTime(self.yInitialVelovity!, xInitialVelocity: nil, yDisplacement: 0, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration!)
            
            findMaxHeight(self.yInitialVelovity!, time: self.maxHeightTime!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        }
        
        findXMaxHeight()
        
        findDisplacement(nil, yAcceleration: nil, xInitialVelocity: self.xInitialVelocity, xAcceleration: self.xAcceleration!, time: self.time!)
        
        findFinalVelocity(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: self.time!)
        
        findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.yMaxHeight!)
        
        self.firstTime = findFirstTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        self.secondTime = findSecondTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
    }
    
    
    //MARK: - initializer : VectorVelocity, degree, xDisplacement
    init(VectorVelocity: CGFloat, degree: CGFloat, xDisplacement: CGFloat, currentUnit : Units) {
        
        self.currentUnits = currentUnit
        
        switch currentUnits {
            
        case .MetersPerSecond:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
        case .FeetPerSecond:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        }
        
        self.VectorVelocity = VectorVelocity
        
        self.degrees = degree
        
        self.xDisplacement = xDisplacement
        
        
        findVelocity(VectorVelocity, degree: degree)
        
        self.canBeSolved = checkTime(nil, xInitialVelocity: self.xInitialVelocity, yDisplacement: nil, xDisplacement: self.xDisplacement, xAcceleration: self.xAcceleration, yAcceleration: nil)
        
        self.time = findTime(nil, xInitialVelocity: self.xInitialVelocity!, yDisplacement: nil, xDisplacement: self.xDisplacement!, xAcceleration: self.xAcceleration!, yAcceleration: nil)
        
        if self.xDisplacement == 0.0 && self.degrees == 90.0 {
            
            self.yDisplacement = 0
            
        } else {
            
            findDisplacement(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: nil, xAcceleration: nil, time: self.time!)
            
        }
        
        if self.yDisplacement == 0 {
            
            self.maxHeightTime = self.time! / 2
            
            findMaxHeight(self.yInitialVelovity!, time: self.time!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        } else {
            
            self.maxHeightTime = findTime(self.yInitialVelovity!, xInitialVelocity: nil, yDisplacement: 0, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration!)
            
            findMaxHeight(self.yInitialVelovity!, time: self.maxHeightTime!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        }
        
        findXMaxHeight()
        
        findFinalVelocity(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: self.time!)
        
        findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.yMaxHeight!)
        
        self.firstTime = findFirstTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        self.secondTime = findSecondTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
    }
    
    
    //MARK: - initializer : degree, xDisplacement, yDisplacement
    init(degree: CGFloat, xDisplacement: CGFloat, yDisplacement: CGFloat, currentUnits : Units) {
        
        self.currentUnits = currentUnits
        
        switch currentUnits {
            
        case .MetersPerSecond:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
        case .FeetPerSecond:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        }
        
        self.degrees = degree
        
        self.xDisplacement = xDisplacement
        
        self.yDisplacement = yDisplacement
        
        
        //Equation derived from Displacement = Vo * t - 4.9 t^2
        self.VectorVelocity = findVectorVelocity(self.xDisplacement, sy: self.yDisplacement, ax: self.xAcceleration, ay: self.yAcceleration, d: self.degrees)
        
        findVelocity(self.VectorVelocity, degree: degree)
        
        self.canBeSolved = checkTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        self.time = findTime(self.yInitialVelovity!, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        self.firstTime = findFirstTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        self.secondTime = findSecondTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        if self.yDisplacement == 0 {
            
            self.maxHeightTime = self.time! / 2
            
            findMaxHeight(self.yInitialVelovity!, time: self.time!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        } else {
            
            self.maxHeightTime = findTime(self.yInitialVelovity!, xInitialVelocity: nil, yDisplacement: 0, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration!)
            
            findMaxHeight(self.yInitialVelovity!, time: self.maxHeightTime!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        }
        
        findXMaxHeight()
        
        findFinalVelocity(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: self.time!)
        
        findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.yMaxHeight!)
        
    }
    
    
    //MARK: - Function : if neccessary, find initial velocity
    func findVectorVelocity(sx : CGFloat?, sy : CGFloat?, ax : CGFloat?, ay : CGFloat?, d : CGFloat) -> CGFloat {
        
        return (((ax!*sy!-ay!*sx!)*sqrt((((2)/((ax!*sin(d.toDegrees)-ay!*cos(d.toDegrees))*(sx!*sin(d.toDegrees)-sy!*cos(d.toDegrees)))))))/(2))
        
    }
    
    
    //MARK: - Function : find x / y components of Velocity
    func findVelocity(vectorVelocity: CGFloat, degree: CGFloat) {
        
        self.xInitialVelocity = cos(degree.toDegrees) * vectorVelocity
        
        self.yInitialVelovity = sin(degree.toDegrees) * vectorVelocity
        
    }
    
    
    //MARK: - Function : find time
    func findTime(yInitialVelocity: CGFloat?, xInitialVelocity: CGFloat?, yDisplacement: CGFloat?, xDisplacement: CGFloat?, xAcceleration: CGFloat?, yAcceleration: CGFloat?) -> CGFloat? {
        
        if yInitialVelocity != nil && yDisplacement != nil && yAcceleration != nil {
            
            self.firstTime = findFirstTime(yInitialVelocity, xInitialVelocity: nil, yDisplacement: yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: yAcceleration)
            
            self.secondTime = findSecondTime(yInitialVelocity, xInitialVelocity: nil, yDisplacement: yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: yAcceleration)
            
            switch currentInstance {
                
            case .FirstInstance:
                
                return self.firstTime!
                
            case .SecondInstance:
                
                return self.secondTime!
                
            }
            
        } else if xInitialVelocity != nil && xDisplacement != nil && xAcceleration != nil {
            
            if xAcceleration == 0 {
                
                return xDisplacement! / xInitialVelocity!
                
            } else {
                
                self.firstTime = findFirstTime(nil, xInitialVelocity: xInitialVelocity, yDisplacement: nil, xDisplacement: xDisplacement, xAcceleration: xAcceleration, yAcceleration: nil)
                
                self.secondTime = findSecondTime(nil, xInitialVelocity: xInitialVelocity, yDisplacement: nil, xDisplacement: xDisplacement, xAcceleration: xAcceleration, yAcceleration: nil)
                
                switch currentInstance {
                    
                case .FirstInstance:
                    
                    return self.firstTime!
                    
                case .SecondInstance:
                    
                    return self.secondTime!
                    
                }
                
            }
            
        } else {
            
            return 0
            
        }
        
    }
    
    
    //MARK : - Function : find first instance of time
    func findFirstTime(yInitialVelocity: CGFloat?, xInitialVelocity: CGFloat?, yDisplacement: CGFloat?, xDisplacement: CGFloat?, xAcceleration: CGFloat?, yAcceleration: CGFloat?) -> CGFloat? {
        
        if yInitialVelocity != nil && yDisplacement != nil && yAcceleration != nil {
            
            return ( (-yInitialVelocity!) + ( sqrt( (yInitialVelocity! * yInitialVelocity!) - (4 * (yAcceleration! / 2) * -yDisplacement! ) ) ) ) / ( (2 * (yAcceleration! / 2) ) )
            
        } else if xInitialVelocity != nil && xDisplacement != nil && xAcceleration != nil {
            
            return ( (-xInitialVelocity!) + ( sqrt( (xInitialVelocity! * xInitialVelocity!) - (4 * (xAcceleration! / 2) * -xDisplacement! ) ) ) ) / ( (2 * (xAcceleration! / 2) ) )
            
        } else {
            
            return 0
            
        }
        
    }
    
    
    //MARK : - Function : find first instance of time
    func findSecondTime(yInitialVelocity: CGFloat?, xInitialVelocity: CGFloat?, yDisplacement: CGFloat?, xDisplacement: CGFloat?, xAcceleration: CGFloat?, yAcceleration: CGFloat?) -> CGFloat? {
        
        if yInitialVelocity != nil && yDisplacement != nil && yAcceleration != nil {
            
            return ( (-yInitialVelocity!) - ( sqrt( (yInitialVelocity! * yInitialVelocity!) - (4 * (yAcceleration! / 2) * -yDisplacement! ) ) ) ) / ( (2 * (yAcceleration! / 2) ) )
            
        } else if xInitialVelocity != nil && xDisplacement != nil && xAcceleration != nil {
            
            return ( (-xInitialVelocity!) - ( sqrt( (xInitialVelocity! * xInitialVelocity!) - (4 * (xAcceleration! / 2) * -xDisplacement! ) ) ) ) / ( (2 * (xAcceleration! / 2) ) )
            
        } else {
            
            return 0
            
        }
        
    }
    
    
    //MARK: - Function : find time with displacement and acceleration
    func findTimeWithDisplacement(yDisplacement: CGFloat, yAcceleration: CGFloat) -> CGFloat? {
        
        let time = sqrt( (2 * yDisplacement) / yAcceleration)
        
        return time
        
    }
    
    
    //MARK: - Function : find max height
    func findMaxHeight(yInitialVelocity: CGFloat, time: CGFloat, yAcceleration: CGFloat, yDisplacement: CGFloat) {
        
        self.yMaxHeight = abs( (yInitialVelocity * (time / 2)) + ( (yAcceleration * (time * time / 4)) / 2 ) ) + abs(yDisplacement)
        
    }
    
    
    //MARK: - Function : find xMaxHeight
    func findXMaxHeight() {
        
        self.xMaxHeight = self.xInitialVelocity! * self.maxHeightTime!
        
    }
    
    
    //MARK: - Function : find displacement
    func findDisplacement(yInitialVelocity: CGFloat?, yAcceleration: CGFloat?, xInitialVelocity: CGFloat?, xAcceleration: CGFloat?, time: CGFloat) {
        
        if yInitialVelocity != nil && yAcceleration != nil {
            
            self.yDisplacement = (yInitialVelocity! * time) + ( ( yAcceleration! * (time * time) ) / 2)
            
        } else if xInitialVelocity != nil && xAcceleration != nil {
            
            self.xDisplacement = (xInitialVelocity! * time) + ( ( xAcceleration! * (time * time) ) / 2)
            
        }
        
    }
    
    
    //MARK: - Function : find final Velocity
    func findFinalVelocity(yInitialVelocity: CGFloat, yAcceleration: CGFloat, xInitialVelocity: CGFloat, xAcceleration: CGFloat, time: CGFloat) {
        
        self.yFinalVelocity = yAcceleration * time + yInitialVelocity
        
        if xAcceleration == 0 {
            
            self.xFinalVelocity = xInitialVelocity
            
        } else {
            
            self.xFinalVelocity = xAcceleration * time + xInitialVelocity
            
        }
        
    }
    
    
    //MARK: - Function : find final Vector Veocity
    func findFinalVectorVelocity(yFinalVelocity: CGFloat, xFinalVelocity: CGFloat, yDisplacement: CGFloat, maxHeight: CGFloat) {
        
        if yDisplacement > maxHeight {
            
            self.finalVectorVelocity = sqrt( (xFinalVelocity * xFinalVelocity) + (yFinalVelocity * yFinalVelocity) )
            
        } else {
            
            self.finalVectorVelocity = -1 * sqrt( (xFinalVelocity * xFinalVelocity) + (yFinalVelocity * yFinalVelocity) )
            
        }
        
        self.finalDegrees = atan( (yFinalVelocity) / (xFinalVelocity) ).toRad
        
    }
    
    
    //MARK: - Function : recalculates yDisplacemnet based on passed time
    func recalculateYDisplacement(time: CGFloat, VectorVelocity: CGFloat, degree: CGFloat, yDisplacement: CGFloat, currentUnit : Units) {
        
        self.currentUnits = currentUnit
        
        switch currentUnits {
            
        case .MetersPerSecond:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
        case .FeetPerSecond:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        }
        
        
        findVelocity(VectorVelocity, degree: degree)
        
        findDisplacement(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: nil, xAcceleration: nil, time: time)
        
        findDisplacement(nil, yAcceleration: nil, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: time)
        
        self.canBeSolved = checkTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        if self.yDisplacement == 0 {
            
            self.maxHeightTime = time / 2
            
            findMaxHeight(self.yInitialVelovity!, time: time, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        } else {
            
            self.maxHeightTime = findTime(self.yInitialVelovity!, xInitialVelocity: nil, yDisplacement: 0, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration!)
            
            findMaxHeight(self.yInitialVelovity!, time: self.maxHeightTime!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        }
        
        findXMaxHeight()
        
        findDisplacement(nil, yAcceleration: nil, xInitialVelocity: self.xInitialVelocity, xAcceleration: self.xAcceleration!, time: time)
        
        findFinalVelocity(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: time)
        
        findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.yMaxHeight!)
        
        self.firstTime = findFirstTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        self.secondTime = findSecondTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
    }
    
    
    //MARK: - Function : recalculates xDisplacement based on passed time
    func recalculateXDisplacement(time: CGFloat, VectorVelocity: CGFloat, degree: CGFloat, xDisplacement: CGFloat, currentUnit : Units) {
        
        self.VectorVelocity = VectorVelocity
        
        self.degrees = degree
        
        switch currentUnits {
            
        case .MetersPerSecond:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
        case .FeetPerSecond:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        }
        
        
        findVelocity(VectorVelocity, degree: degree)
        
        findDisplacement(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: nil, xAcceleration: nil, time: time)
        
        findDisplacement(nil, yAcceleration: nil, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: time)
        
        if self.yDisplacement == 0 {
            
            self.maxHeightTime = time
            
            findMaxHeight(self.yInitialVelovity!, time: time, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        } else {
            
            self.maxHeightTime = findTime(self.yInitialVelovity!, xInitialVelocity: nil, yDisplacement: 0, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration!)
            
            findMaxHeight(self.yInitialVelovity!, time: self.maxHeightTime!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        }
        
        findFinalVelocity(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: time)
        
        findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.yMaxHeight!)
        
    }
    
    
    //MARK: - Function : recalculates displacements
    func recalculateDisplacements(time: CGFloat, degree: CGFloat, xDisplacement: CGFloat, yDisplacement: CGFloat, vectorVelocity : CGFloat, currentUnit : Units) {
        
        self.currentUnits = currentUnit
        
        switch currentUnits {
            
        case .MetersPerSecond:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
        case .FeetPerSecond:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        }
        
        self.VectorVelocity = vectorVelocity
        
        self.degrees = degree
        
        self.xDisplacement = xDisplacement
        
        self.yDisplacement = yDisplacement
        
        
        findVelocity(self.VectorVelocity, degree: degree)
        
        self.canBeSolved = checkTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        self.firstTime = findFirstTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        self.secondTime = findSecondTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        if self.yDisplacement == 0 {
            
            self.maxHeightTime = time / 2
            
            findMaxHeight(self.yInitialVelovity!, time: time, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        } else {
            
            self.maxHeightTime = findTime(self.yInitialVelovity!, xInitialVelocity: nil, yDisplacement: 0, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration!)
            
            findMaxHeight(self.yInitialVelovity!, time: self.maxHeightTime!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        }
        
        findXMaxHeight()
        
        findFinalVelocity(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: time)
        
        findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.yMaxHeight!)
        
        findDisplacement(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: nil, xAcceleration: nil, time: time)
        
        findDisplacement(nil, yAcceleration: nil, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: time)
    }
    
    
    //MARK: - Function : Check to see if time exists
    func checkTime(yInitialVelovity : CGFloat?, xInitialVelocity: CGFloat?, yDisplacement: CGFloat?, xDisplacement: CGFloat?, xAcceleration: CGFloat?, yAcceleration: CGFloat?) -> Bool {
        
        switch self.currentInstance {
            
        case .FirstInstance:
            
            if yInitialVelovity != nil && yDisplacement != nil && yAcceleration != nil && self.VectorVelocity > 0 {
                
                if (yInitialVelovity! * yInitialVelovity!) < (4 * (yAcceleration! / 2) * (-yDisplacement!)) {
                    
                    return false
                    
                } else {
                    
                    return true
                    
                }
                
            } else if xInitialVelocity != nil && xDisplacement != nil && xAcceleration != nil && self.VectorVelocity > 0 {
                
                if (xInitialVelocity! * xInitialVelocity!) < (4 * (xAcceleration! / 2) * (-xDisplacement!)) {
                    
                    return false
                    
                } else {
                    
                    return true
                    
                }
                
            } else {
                
                return false
                
            }
            
        case .SecondInstance:
            
            if yInitialVelovity != nil && yDisplacement != nil && yAcceleration != nil && self.VectorVelocity > 0 {
                
                if (yInitialVelovity! * yInitialVelovity!) < (4 * (yAcceleration! / 2) * (-yDisplacement!)) {
                    
                    return false
                    
                } else {
                    
                    return true
                    
                }
                
            } else if xInitialVelocity != nil && xDisplacement != nil && xAcceleration != nil && self.VectorVelocity > 0 {
                
                if (xInitialVelocity! * xInitialVelocity!) < (4 * (xAcceleration! / 2) * (-xDisplacement!)) {
                    
                    return false
                    
                } else {
                    
                    return true
                    
                }
                
            } else {
                
                return false
                
            }
            
        }
        
    }
    
    //MARK: - Function : Error alert with brief description - very basic
    func presentErrorAlert(textFields : [UITextField]) -> UIAlertController {
        
        let errorAlert = UIAlertController(title: "Logical Error", message: "The values that you have entered cannot physically happen.", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            
            for t in textFields {
                
                t.text = nil
                
            }
            
        }
        
        errorAlert.addAction(okAction)
        
        return errorAlert
        
    }
    
}