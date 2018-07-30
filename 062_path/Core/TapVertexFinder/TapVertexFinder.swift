//
//  TapVertexFinder.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class TapVertexFinder: ITapVertexFinder {
    
    // MARK: - Memory Management
    
    let points: PointsVector
    
    init(_ points: PointsVector) {
        self.points = points
    }
    
    // MARK: - ITapVertexFinder
    
    func findNearestVertex(to tap: CGPoint) -> Vertex {
        let distances = points.map{ $0.distance(to: tap) }
        let index = distances.getIndexOfMinimalElement()
        
        return index
    }
}

