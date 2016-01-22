//: Playground - noun: a place where people can play.

import UIKit
import Foundation


//MARK: - Extensions : CGFloat (degrees to rad && rad to degrees)
extension CGFloat {
    
    public var toDegrees: CGFloat { return self * CGFloat(M_PI / 180) }
    
    public var toRad: CGFloat { return self * CGFloat(180 / M_PI) }
    
}

enum Units {
    
    case InternationalSystem
    
    case MetricSystem
    
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
    var currentUnits : Units = .MetricSystem
    
    
    //Can be solved or not
    var canBeSolved = false
    
    
    //MARK: - initializer : default values
    init() {
        
        switch currentUnits {
            
        case .MetricSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
        case .InternationalSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        }
        
    }
    
    
    //MARK: - initializer : VectorVelocity, degree, xDisplacement
    init(VectorVelocity: CGFloat, degree: CGFloat, xDisplacement: CGFloat, currentUnits : Units) {
        
        self.currentUnits = currentUnits
        
        switch currentUnits {
            
        case .MetricSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        case .InternationalSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
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
    
    
    //MARK: - initalizer : VecotrVelocity, degree, yDisplacement
    init(VectorVelocity: CGFloat, degree: CGFloat, yDisplacement: CGFloat, currentUnits : Units) {
        
        self.currentUnits = currentUnits
        
        switch currentUnits {
            
        case .MetricSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        case .InternationalSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
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
    
    
    //MARK: - initializer : xDisplacement, degree
    init(xDisplacement: CGFloat, degree: CGFloat, currentUnits : Units) {
        
        self.currentUnits = currentUnits
        
        switch currentUnits {
            
        case .MetricSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        case .InternationalSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
        }
        
        self.xDisplacement = xDisplacement
        
        self.degrees = degree
        
        
        //Equation derived from Displacement = Vo * t - 4.9 t^2
        self.VectorVelocity = sqrt( (xDisplacement * xDisplacement) / (((sin(degree.toDegrees)) * (xDisplacement / cos(degree.toDegrees)) / 4.9) * (cos(degree.toDegrees) * cos(degree.toDegrees))) )
        
        findVelocity(self.VectorVelocity, degree: degree)
        
        self.canBeSolved = checkTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: 0, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        self.time = findTime(self.yInitialVelovity!, xInitialVelocity: nil, yDisplacement: 0, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        self.firstTime = findFirstTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        self.secondTime = findSecondTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        findDisplacement(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: nil, xAcceleration: nil, time: self.time!)
        
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
    
    
    
    
    //MARK: - initializer : degree, xDisplacement, yDisplacement
    init(degree: CGFloat, xDisplacement: CGFloat, yDisplacement: CGFloat, currentUnits : Units) {
        
        self.currentUnits = currentUnits
        
        switch currentUnits {
            
        case .MetricSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        case .InternationalSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
        }
        
        self.degrees = degree
        
        self.xDisplacement = xDisplacement
        
        self.yDisplacement = yDisplacement
        
        
        //Equation derived from Displacement = Vo * t - 4.9 t^2
        self.VectorVelocity = findVectorVelocity(self.xDisplacement, yDisplacement: self.yDisplacement, xAcceleration: self.xAcceleration, yAcceleration: self.yAcceleration, degree: self.degrees.toRad)
        
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
    func findVectorVelocity(xDisplacement : CGFloat?, yDisplacement : CGFloat?, xAcceleration : CGFloat?, yAcceleration : CGFloat?, degree : CGFloat) -> CGFloat {
        
        let t1 = (xAcceleration! * yDisplacement! - yAcceleration! * xDisplacement!)
        
        let t2 = ( xAcceleration! * sin(degree) - yAcceleration! * cos(degree) )
        
        let t3 = ( xDisplacement! * sin(degree) - yDisplacement! * cos(degree) )
        
        let fin = ( (t1) * sqrt( (2) / (t2 * t3) ) ) / 2
        
        return fin
        
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
    
    
    //MARK: - Function : recalculates xDisplacement based on passed time
    func recalculateXDisplacement(time: CGFloat, VectorVelocity: CGFloat, degree: CGFloat, xDisplacement: CGFloat, currentUnit : Units) {
        
        self.VectorVelocity = VectorVelocity
        
        self.degrees = degree
        
        switch currentUnits {
            
        case .MetricSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
        case .InternationalSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        }
        
        
        findVelocity(VectorVelocity, degree: degree)
        
        findDisplacement(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: nil, xAcceleration: nil, time: time)
        
        findDisplacement(nil, yAcceleration: nil, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: time)
        
        if self.yDisplacement == 0 {
            
            self.maxHeightTime = self.time
            
            findMaxHeight(self.yInitialVelovity!, time: self.time!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        } else {
            
            self.maxHeightTime = findTime(self.yInitialVelovity!, xInitialVelocity: nil, yDisplacement: 0, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration!)
            
            findMaxHeight(self.yInitialVelovity!, time: self.maxHeightTime!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        }
        
        findFinalVelocity(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: time)
        
        findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.yMaxHeight!)
        
    }
    
    
    //MARK: - Function : recalculates yDisplacemnet based on passed time
    func recalculateYDisplacement(time: CGFloat, VectorVelocity: CGFloat, degree: CGFloat, yDisplacement: CGFloat, currentUnit : Units) {
        
        self.VectorVelocity = VectorVelocity
        
        self.degrees = degree
        
        switch currentUnits {
            
        case .MetricSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
        case .InternationalSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        }
        
        
        findVelocity(VectorVelocity, degree: degree)
        
        if self.yDisplacement == 0 {
            
            self.maxHeightTime = self.time
            
            findMaxHeight(self.yInitialVelovity!, time: self.time!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        } else {
            
            self.maxHeightTime = findTime(self.yInitialVelovity!, xInitialVelocity: nil, yDisplacement: 0, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration!)
            
            findMaxHeight(self.yInitialVelovity!, time: self.maxHeightTime!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        }
        
        findDisplacement(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: nil, xAcceleration: nil, time: time)
        
        findDisplacement(nil, yAcceleration: nil, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: time)
        
        findFinalVelocity(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: time)
        
        findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.yMaxHeight!)
        
    }
    
    
    //MARK: - Function : recalculates angleDisplacement based on passed time
    func recalculateAngleDisplacement(time: CGFloat, xDisplacement: CGFloat, degree: CGFloat, currentUnit : Units) {
        
        self.xDisplacement = xDisplacement
        
        self.degrees = degree
        
        switch currentUnits {
            
        case .MetricSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
        case .InternationalSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        }
        
        
        //Equation derived from Displacement = Vo * t - 4.9 t^2
        self.VectorVelocity = sqrt( (xDisplacement * xDisplacement) / (((sin(degree.toDegrees)) * (xDisplacement / cos(degree.toDegrees)) / 4.9) * (cos(degree.toDegrees) * cos(degree.toDegrees))) )
        
        findVelocity(self.VectorVelocity, degree: degree)
        
        findDisplacement(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: nil, xAcceleration: nil, time: time)
        
        findDisplacement(nil, yAcceleration: nil, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: time)
        
        if self.yDisplacement == 0 {
            
            self.maxHeightTime = self.time
            
            findMaxHeight(self.yInitialVelovity!, time: self.time!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        } else {
            
            self.maxHeightTime = findTime(self.yInitialVelovity!, xInitialVelocity: nil, yDisplacement: 0, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration!)
            
            findMaxHeight(self.yInitialVelovity!, time: self.maxHeightTime!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        }
        
        findFinalVelocity(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: time)
        
        findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.yMaxHeight!)
        
    }
    
    
    //MARK: - Function : recalculates displacements
    func recalculateDisplacements(time: CGFloat, degree: CGFloat, xDisplacement: CGFloat, yDisplacement: CGFloat, currentUnit : Units) {
        
        self.currentUnits = currentUnit
        
        switch currentUnits {
            
        case .MetricSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -32
            
        case .InternationalSystem:
            
            self.xAcceleration = 0
            
            self.yAcceleration = -9.8
            
        }
        
        self.degrees = degree
        
        self.xDisplacement = xDisplacement
        
        self.yDisplacement = yDisplacement
        
        
        //Equation derived from Displacement = Vo * t - 4.9 t^2
        self.VectorVelocity = findVectorVelocity(self.xDisplacement, yDisplacement: self.yDisplacement, xAcceleration: self.xAcceleration, yAcceleration: self.yAcceleration, degree: self.degrees.toRad)
        
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
            
            if yInitialVelovity != nil && yDisplacement != nil && yAcceleration != nil && self.VectorVelocity == 0 {
                
                if (yInitialVelovity! * yInitialVelovity!) < (4 * (yAcceleration! / 2) * (-yDisplacement!)) {
                    
                    return false
                    
                } else {
                    
                    return true
                    
                }
                
            } else if xInitialVelocity != nil && xDisplacement != nil && xAcceleration != nil && self.VectorVelocity == 0 {
                
                if (xInitialVelocity! * xInitialVelocity!) < (4 * (xAcceleration! / 2) * (-xDisplacement!)) {
                    
                    return false
                    
                } else {
                    
                    return true
                    
                }
                
            } else {
                
                return false
                
            }
            
        case .SecondInstance:
            
            if yInitialVelovity != nil && yDisplacement != nil && yAcceleration != nil && self.VectorVelocity == 0 {
                
                if (yInitialVelovity! * yInitialVelovity!) < (4 * (yAcceleration! / 2) * (-yDisplacement!)) {
                    
                    return false
                    
                } else {
                    
                    return true
                    
                }
                
            } else if xInitialVelocity != nil && xDisplacement != nil && xAcceleration != nil && self.VectorVelocity == 0 {
                
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
    
}



var myPhysics = Physics(degree: 30, xDisplacement: 100, yDisplacement: 100, currentUnits: .InternationalSystem)

myPhysics.VectorVelocity

myPhysics.finalVectorVelocity

myPhysics.degrees

myPhysics.finalDegrees

myPhysics.time

myPhysics.firstTime

myPhysics.secondTime

myPhysics.yMaxHeight

myPhysics.xMaxHeight

myPhysics.maxHeightTime


myPhysics.yInitialVelovity

myPhysics.yFinalVelocity

myPhysics.yDisplacement

myPhysics.yAcceleration


myPhysics.xInitialVelocity

myPhysics.xFinalVelocity

myPhysics.xDisplacement

myPhysics.xAcceleration

myPhysics.canBeSolved


//    //MARK: - initializer : degree, xDisplacement, yDisplacement
//    init(degree: CGFloat, xDisplacement: CGFloat, yDisplacement: CGFloat, currentUnits : Units) {
//
//        self.currentUnits = currentUnits
//
//        switch currentUnits {
//
//        case .MetricSystem:
//
//            self.xAcceleration = 0
//
//            self.yAcceleration = -32
//
//        case .InternationalSystem:
//
//            self.xAcceleration = 0
//
//            self.yAcceleration = -9.8
//
//        }
//
//        self.degrees = degree
//
//        self.xDisplacement = xDisplacement
//
//        self.yDisplacement = yDisplacement
//
//
//        if findTimeWithDisplacement(self.yDisplacement!, yAcceleration: self.yAcceleration!) == nil {
//
//            self.canBeSolved = false
//
//        } else {
//
//            self.canBeSolved = true
//
//        }
//
//        self.time = findTimeWithDisplacement(self.yDisplacement!, yAcceleration: self.yAcceleration!)
//
//        if self.degrees == 0 {
//
//            self.yInitialVelovity = 0
//
//            self.xInitialVelocity = self.xDisplacement! / self.time!
//
//            self.VectorVelocity = self.xInitialVelocity!
//
//            findFinalVelocity(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: self.time!)
//
//            findMaxHeight(self.yInitialVelovity!, time: self.time!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
//
//            if self.yMaxHeight! == self.yDisplacement! {
//
//                self.maxHeightTime = 0
//
//            } else {
//
//                self.maxHeightTime = findTime(self.yInitialVelovity!, xInitialVelocity: self.xInitialVelocity!, yDisplacement: 0, xDisplacement: self.xDisplacement!, xAcceleration: self.xAcceleration!, yAcceleration: self.yAcceleration!)
//
//            }
//
//            findXMaxHeight()
//
//            findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.yMaxHeight!)
//
//        } else {
//
//            canBeSolved = false
//
//        }
//
//    }



////MARK: - Functions and such to Plot Data
//var timeArray = [CGFloat]()
//
//var displacementArray = [CGFloat]()
//
//var xLabels = [String]()
//
//var yLabels = [String]()
//
//
//
////MARK: - Data to split number into # of equal segments
//func segment(time: CGFloat, segments: Int, maxHeightTime: CGFloat) -> [CGFloat] {
//    
//    var timeArray = [CGFloat]()
//    
//    for var count = 0; count <= segments; count++ {
//        
//        let tempTime = (time * CGFloat(count)) / CGFloat(segments)
//        
//        timeArray.append(tempTime)
//        
//    }
//    
//    timeArray.append(maxHeightTime)
//    
//    timeArray = timeArray.sort {
//        return $0 < $1
//    }
//    
//    return timeArray
//    
//}
//
//
////MARK: - Function : Finds corresponding y-values for x values
//func findDisplacement(timeArray: [CGFloat], initialVelocity: CGFloat, acceleration: CGFloat) -> [CGFloat] {
//    
//    var displacementArray = [CGFloat]()
//    
//    for time in timeArray {
//        
//        displacementArray.append((initialVelocity * time) + ((acceleration * (time * time)) / 2))
//        
//    }
//    
//    return displacementArray
//    
//}
//
//
////MARK: - Function : round an entire array
//func round(array: [CGFloat]) -> [CGFloat] {
//    
//    var returnArray = [CGFloat]()
//    
//    for item in array {
//        
//        returnArray.append(round(100 * item) / 100)
//        
//    }
//    
//    return returnArray
//    
//}
//
//
////MARK: - Function : returns an array as an array of Strings
//func toString(array: [CGFloat]) -> [String] {
//    
//    var returnArray = [String]()
//    
//    for item in array {
//        
//        returnArray.append(String(item))
//        
//    }
//    
//    return returnArray
//    
//}
//
//
//timeArray = segment(myPhysics.time!, segments: 10, maxHeightTime: myPhysics.maxHeightTime!)
//
//displacementArray = findDisplacement(timeArray, initialVelocity: myPhysics.yInitialVelovity!, acceleration: myPhysics.yAcceleration!)
//
//timeArray = round(timeArray)
//
//displacementArray = round(displacementArray)
//
//xLabels = toString(timeArray)
//
//yLabels = toString(displacementArray)
//
//for var x = 0; x < xLabels.count; x++ {
//    
//    print(xLabels[x] + ", " + yLabels[x])
//    
//}


