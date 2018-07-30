//
//  DrawingAssistant.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class DrawingAssistant: IDrawingAssistant {
    
    // MARK: - Memory Management
    
    let points: PointsVector
    
    init(_ points: PointsVector) {
        self.points = points
    }
    
    // MARK: - IDrawingAssistant
    
    func drawAllPoints(on layer: CAShapeLayer) {
        func getBezierPath(_ points: PointsVector) -> UIBezierPath {
            let path = UIBezierPath()
            let squres = points.map { CGRect(squareInCenter: $0, size: Constants.Drawing.Point.Size.`default`)}
            let paths = squres.map { UIBezierPath(ovalIn: $0) }
            paths.forEach{ path.append($0) }
            
            return path
        }
        
        layer.path = getBezierPath(points).cgPath
    }
    
    func draw(route: [Vertex], on layer: CAShapeLayer) {
        func getBezierPath(_ route: [Vertex]) -> UIBezierPath {
            precondition(!route.isEmpty, "Route should not be empry")
            let routePoints = route.map { points[$0] }
            let path = UIBezierPath()
            path.move(to: routePoints.first!)
            routePoints[1...].forEach{ path.addLine(to: $0) }

            return path
        }
        
        layer.path = getBezierPath(route).cgPath
    }
    
    func highlight(vertex: Vertex, type: VertexType, on layer: CAShapeLayer) {
        func getBezierPath(_ vertex: Vertex) -> UIBezierPath {
            let point = points[vertex]
            var size: CGFloat {
                switch type {
                case .start: return Constants.Drawing.Point.Size.start
                case .final: return Constants.Drawing.Point.Size.final
                }
            }
            let rect = CGRect(squareInCenter: point, size: size)
            let path = UIBezierPath(ovalIn: rect)
            
            return path
        }
        
        layer.path = getBezierPath(vertex).cgPath
    }
}
