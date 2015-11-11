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


class Physics {
    
    
    //General Components
    var VectorVelocity = CGFloat()
    
    var finalVectorVelocity = CGFloat()
    
    var time = CGFloat?()
    
    var degrees = CGFloat()
    
    var finalDegrees = CGFloat()
    
    var MaxHeight = CGFloat?()
    
    var maxHeightTime = CGFloat?()
    
    
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
    
    
    //Can be solved or not
    var canBeSolved = Bool()
    
    
    //MARK: - initializer : default values
    init() {
        
        self.xAcceleration = 0
        
        self.yAcceleration = -9.8
        
    }
    
    
    //MARK: - initializer : VectorVelocity, degree, xDisplacement
    init(VectorVelocity: CGFloat, degree: CGFloat, xDisplacement: CGFloat) {
        
        self.VectorVelocity = VectorVelocity
        
        self.degrees = degree
        
        self.xDisplacement = xDisplacement
        
        self.xAcceleration = 0
        
        self.yAcceleration = -9.8
        
        
        findVelocity(VectorVelocity, degree: degree)
        
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
        
        findFinalVelocity(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: self.time!)
        
        findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.MaxHeight!)
        
    }
    
    
    //MARK: - initalizer : VecotrVelocity, degree, yDisplacement
    init(VectorVelocity: CGFloat, degree: CGFloat, yDisplacement: CGFloat) {
        
        self.VectorVelocity = VectorVelocity
        
        self.degrees = degree
        
        self.yDisplacement = yDisplacement
        
        self.xAcceleration = 0
        
        self.yAcceleration = -9.8
        
        
        findVelocity(VectorVelocity, degree: degree)
        
        self.time = findTime(self.yInitialVelovity, xInitialVelocity: nil, yDisplacement: self.yDisplacement, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration)
        
        if self.yDisplacement == 0 {
            
            self.maxHeightTime = self.time! / 2
            
            findMaxHeight(self.yInitialVelovity!, time: self.time!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        } else {
            
            self.maxHeightTime = findTime(self.yInitialVelovity!, xInitialVelocity: nil, yDisplacement: 0, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration!)
            
            findMaxHeight(self.yInitialVelovity!, time: self.maxHeightTime!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        }
        
        findDisplacement(nil, yAcceleration: nil, xInitialVelocity: self.xInitialVelocity, xAcceleration: self.xAcceleration!, time: self.time!)
        
        findFinalVelocity(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: self.time!)
        
        findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.MaxHeight!)
        
    }
    
    
    //MARK: - initializer : xDisplacement, degree
    init(xDisplacement: CGFloat, degree: CGFloat) {
        
        self.xDisplacement = xDisplacement
        
        self.degrees = degree
        
        self.xAcceleration = 0
        
        self.yAcceleration = -9.8
        
        
        //Equation derived from Displacement = Vo * t - 4.9 t^2
        self.VectorVelocity = sqrt( (xDisplacement * xDisplacement) / (((sin(degree.toDegrees)) * (xDisplacement / cos(degree.toDegrees)) / 4.9) * (cos(degree.toDegrees) * cos(degree.toDegrees))) )
        
        findVelocity(self.VectorVelocity, degree: degree)
        
        self.time = findTime(self.yInitialVelovity!, xInitialVelocity: nil, yDisplacement: 0, xDisplacement: nil, xAcceleration: nil, yAcceleration: -9.8)
        
        findDisplacement(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: nil, xAcceleration: nil, time: self.time!)
        
        if self.yDisplacement == 0 {
            
           self.maxHeightTime = self.time! / 2
            
            findMaxHeight(self.yInitialVelovity!, time: self.time!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        } else {
            
            self.maxHeightTime = findTime(self.yInitialVelovity!, xInitialVelocity: nil, yDisplacement: 0, xDisplacement: nil, xAcceleration: nil, yAcceleration: self.yAcceleration!)
            
            findMaxHeight(self.yInitialVelovity!, time: self.maxHeightTime!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
        }
        
        findFinalVelocity(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: self.time!)
        
        findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.MaxHeight!)
        
    }
    
    
    //MARK: - initializer : degree, xDisplacement, yDisplacement
    init(degree: CGFloat, xDisplacement: CGFloat, yDisplacement: CGFloat) {
        
        self.degrees = degree
        
        self.xDisplacement = xDisplacement
        
        self.yDisplacement = abs(yDisplacement)
        
        self.xAcceleration = 0
        
        self.yAcceleration = -9.8
        
        
        self.time = findTimeWithDisplacement(self.yDisplacement!, yAcceleration: self.yAcceleration!)
        
        if self.degrees == 0 {
            
            self.yInitialVelovity = 0
            
            self.xInitialVelocity = self.xDisplacement! / self.time!
            
            self.VectorVelocity = self.xInitialVelocity!
            
            findFinalVelocity(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: self.time!)
            
            findMaxHeight(self.yInitialVelovity!, time: self.time!, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
            
            if self.MaxHeight! == self.yDisplacement! {
                
                self.maxHeightTime = 0
                
            } else {
                
                self.maxHeightTime = findTime(self.yInitialVelovity!, xInitialVelocity: self.xInitialVelocity!, yDisplacement: 0, xDisplacement: self.xDisplacement!, xAcceleration: self.xAcceleration!, yAcceleration: self.yAcceleration!)
                
            }
            
            findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.MaxHeight!)
            
        } else {
            
            canBeSolved = false
            
        }
        
    }
    
    
    //MARK: - Function : find x / y components of Velocity
    func findVelocity(vectorVelocity: CGFloat, degree: CGFloat) {
        
        self.xInitialVelocity = cos(degree.toDegrees) * vectorVelocity
        
        self.yInitialVelovity = sin(degree.toDegrees) * vectorVelocity
        
    }
    
    
    //MARK: - Function : find time
    func findTime(yInitialVelocity: CGFloat?, xInitialVelocity: CGFloat?, yDisplacement: CGFloat?, xDisplacement: CGFloat?, xAcceleration: CGFloat?, yAcceleration: CGFloat?) -> CGFloat {
        
        if yInitialVelocity != nil && yDisplacement != nil && yAcceleration != nil {
            
            return ( (-yInitialVelocity!) - ( sqrt( (yInitialVelocity! * yInitialVelocity!) - (4 * (yAcceleration! / 2) * yDisplacement! ) ) ) ) / ( (2 * (yAcceleration! / 2) ) )
            
        } else if xInitialVelocity != nil && xDisplacement != nil && xAcceleration != nil {
            
            if xAcceleration == 0 {
                
                return xDisplacement! / xInitialVelocity!
                
            } else {
                
                return ( (-xInitialVelocity!) - ( sqrt( (xInitialVelocity! * xInitialVelocity!) - (4 * (xAcceleration! / 2) * xDisplacement! ) ) ) ) / ( (2 * (xAcceleration! / 2) ) )
                
            }
            
        } else {
            
            return 0
            
        }
        
    }
    
    
    //MARK: - Function : find time with displacement and acceleration
    func findTimeWithDisplacement(yDisplacement: CGFloat, yAcceleration: CGFloat) -> CGFloat {
        
        let time = sqrt( (2 * abs(yDisplacement)) / abs(yAcceleration))
        
        return time
        
    }
    
    
    //MARK: - Function : find max height
    func findMaxHeight(yInitialVelocity: CGFloat, time: CGFloat, yAcceleration: CGFloat, yDisplacement: CGFloat) {
        
        self.MaxHeight = abs( (yInitialVelocity * (time / 2)) + ( (yAcceleration * (time * time / 4)) / 2 ) ) + abs(yDisplacement)
        
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
    func recalculateXDisplacement(time: CGFloat, VectorVelocity: CGFloat, degree: CGFloat, xDisplacement: CGFloat) {
        
        self.VectorVelocity = VectorVelocity
        
        self.degrees = degree
        
        self.xAcceleration = 0
        
        self.yAcceleration = -9.8
        
        
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
        
        findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.MaxHeight!)
        
    }
    
    
    //MARK: - Function : recalculates yDisplacemnet based on passed time
    func recalculateYDisplacement(time: CGFloat, VectorVelocity: CGFloat, degree: CGFloat, yDisplacement: CGFloat) {
        
        self.VectorVelocity = VectorVelocity
        
        self.degrees = degree
        
        self.xAcceleration = 0
        
        self.yAcceleration = -9.8
        
        
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
        
        findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.MaxHeight!)
        
    }
    
    
    //MARK: - Function : recalculates angleDisplacement based on passed time
    func recalculateAngleDisplacement(time: CGFloat, xDisplacement: CGFloat, degree: CGFloat) {
        
        self.xDisplacement = xDisplacement
        
        self.degrees = degree
        
        self.xAcceleration = 0
        
        self.yAcceleration = -9.8
        
        
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
        
        findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.MaxHeight!)
        
    }
    
    
    //MARK: - Function : recalculates displacements
    func recalculateDisplacements(time: CGFloat, degree: CGFloat, xDisplacement: CGFloat, yDisplacement: CGFloat) {
        
        self.degrees = degree
        
        self.xAcceleration = 0
        
        self.yAcceleration = -9.8
        
        
        if time > 0 {
        
            if self.degrees == 0 {
        
                self.yInitialVelovity = 0
        
                self.xInitialVelocity = self.xDisplacement! / time
        
                self.VectorVelocity = self.xInitialVelocity!
        
                findFinalVelocity(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: time)
        
                findMaxHeight(self.yInitialVelovity!, time: time, yAcceleration: self.yAcceleration!, yDisplacement: self.yDisplacement!)
        
                if self.MaxHeight! == self.yDisplacement! {
        
                    self.maxHeightTime = 0
        
                } else {
        
                    self.maxHeightTime = findTime(self.yInitialVelovity!, xInitialVelocity: self.xInitialVelocity!, yDisplacement: 0, xDisplacement: self.xDisplacement!, xAcceleration: self.xAcceleration!, yAcceleration: self.yAcceleration!)
        
                }
        
                findFinalVectorVelocity(self.yFinalVelocity!, xFinalVelocity: self.xFinalVelocity!, yDisplacement: self.yDisplacement!, maxHeight: self.MaxHeight!)
        
                findDisplacement(self.yInitialVelovity!, yAcceleration: self.yAcceleration!, xInitialVelocity: nil, xAcceleration: nil, time: time)
            
                findDisplacement(nil, yAcceleration: nil, xInitialVelocity: self.xInitialVelocity!, xAcceleration: self.xAcceleration!, time: time)
            
            } else {
        
                canBeSolved = false
        
            }
            
        }
        
    }
    
}