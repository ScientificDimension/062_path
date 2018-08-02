//
//  Helpers.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

struct Position {
    let row: String
    let column: String
    
    var reversed: Position {
        return Position(row: column, column: row)
    }
}

extension Dictionary where Key == String, Value == [String: Path] {
    func getPath(by position: Position) -> Path? {
        return self[position.row]?[position.column]
    }
    
    subscript(_ position: Position) -> Path? {
        return self[position.row]?[position.column]
    }
}

extension Array where Element == [Int] {
    func getToVertices(from vertex: Int) -> [Int] {
        let toVertices = self[vertex]
            .enumerated()
            .compactMap{ return $1 > 0 ? $0 : nil  }
        
        return toVertices
    }
}

extension CGPoint {
    init(_ point: Point) {
        self.init()
        x = point.x
        y = point.y
    }
}

extension Int {
    var identifier: String {
        return "R-16716-\(self)"
    }
}

extension String  {
    var index: Int {
        return Int(split(separator: "-").last!)!
    }
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        let xDist = (x - point.x)
        let yDist = (y - point.y)
        
        return sqrt((xDist * xDist) + (yDist * yDist))
    }
}

extension CAShapeLayer {
    func clear() {
        path = nil
    }
}

extension Array where Element == Double {
    func getIndexOfMinimalElement() -> Index {
        let (position, _) = enumerated().reduce((-1, Element.greatestFiniteMagnitude)) { $0.1 < $1.1 ? $0 : $1 }

        return position
    }
}

extension Array where Element == CGFloat {
    func getIndexOfMinimalElement() -> Index {
        let (position, _) = enumerated().reduce((-1, Element.greatestFiniteMagnitude)) { $0.1 < $1.1 ? $0 : $1 }

        return position
    }
}

extension CGRect {
    init(squareInCenter: CGPoint, size: CGFloat){
        self = CGRect(
            x: squareInCenter.x - size / 2,
            y: squareInCenter.y - size / 2,
            width: size,
            height: size)
    }
}

extension UIBezierPath {
    func addLine(from start: CGPoint, to final: CGPoint) {
        move(to: start)
        addLine(to: final)
    }
    
    convenience init(pointIn: CGPoint, size: CGFloat) {
        self.init()
        let square = CGRect(squareInCenter: pointIn, size: size)
        let point = UIBezierPath(ovalIn: square)
        append(point)
    }
}
