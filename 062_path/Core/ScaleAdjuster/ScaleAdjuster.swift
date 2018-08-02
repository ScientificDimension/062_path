//
//  ScaleAdjuster.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class ScaleAdjuster: IScaleAdjuster {
    
    private var sourceX: Interval = .one
    private var targetX: Interval = .one
    private var sourceY: Interval = .one
    private var targetY: Interval = .one
    
    func calibrate(_ points: PointsVector) {
        precondition(!points.isEmpty, "PointsVector should not be empty")
        var sourceX: Interval {
            let maxX = points.map { $0.x }.max()!
            return Interval(min: 0, max: maxX)
        }
        var targetX: Interval {
            let screenWidth = UIScreen.main.bounds.width
            return Interval(
                min: Constants.ScreenScale.inset.left,
                max: screenWidth - Constants.ScreenScale.inset.right)
        }
        var sourceY: Interval {
            let maxY = points.map { $0.y }.max()!
            return Interval(min: 0, max: maxY)
        }
        var targetY: Interval {
            let screenHeight = UIScreen.main.bounds.height
            return Interval(
                min: Constants.ScreenScale.inset.bottom, max:
                screenHeight - Constants.ScreenScale.inset.top)
        }
        
        self.sourceX = sourceX
        self.targetX = targetX
        
        self.sourceY = sourceY
        self.targetY = targetY
    }
    
    func adjustPointsToScreenSize(_ points: PointsVector) -> PointsVector {
        guard !points.isEmpty else {
            return points
        }
        let adjustedPoints: PointsVector = points.map { oldPoint in
            let adjustedX = oldPoint.x.extrapolate(source: sourceX, target: targetX)
            let adjustedY = oldPoint.y.extrapolate(source: sourceY, target: targetY)
            
            return CGPoint(x: adjustedX , y: adjustedY)
        }
        
        return adjustedPoints
    }
}
