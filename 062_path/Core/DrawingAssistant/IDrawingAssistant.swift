//
//  IDrawingAssistant.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

enum VertexType {
    case start
    case final
}

protocol IDrawingAssistant {
    func drawAllPoints(on layer: CAShapeLayer)
    func draw(route: [Vertex], on layer: CAShapeLayer)
    func highlight(vertex: Vertex, type: VertexType, on layer: CAShapeLayer)
}
