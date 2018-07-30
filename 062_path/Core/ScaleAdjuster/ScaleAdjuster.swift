//
//  ScaleAdjuster.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class ScaleAdjuster: IScaleAdjuster {
    
    func adjustPointsToScreenSize(_ points: PointsVector) -> PointsVector {
        precondition(!points.isEmpty, "PointsVector should not be empty")
        var sourceX: Interval {
            let maxX = points.map { $0.x }.max()!
            return Interval(min: 0, max: maxX)
        }
        var targetX: Interval {
            let screenWidth = UIScreen.main.bounds.width
            return Interval(
                min: Constants.ScreenScale.offsetX,
                max: screenWidth - Constants.ScreenScale.offsetX)
        }
        var sourceY: Interval {
            let maxY = points.map { $0.y }.max()!
            return Interval(min: 0, max: maxY)
        }
        var targetY: Interval {
            let screenHeight = UIScreen.main.bounds.height
            return Interval(
                min: Constants.ScreenScale.offsetY, max:
                screenHeight - Constants.ScreenScale.offsetY)
        }
        let adjustedPoints: PointsVector = points.map { oldPoint in
            let adjustedX = oldPoint.x.extrapolate(source: sourceX, target: targetX)
            let adjustedY = oldPoint.y.extrapolate(source: sourceY, target: targetY)
            
            return CGPoint(x: adjustedX , y: adjustedY)
        }
        
        return adjustedPoints
    }
}
