//
//  VertexValidator.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

class VertexValidator: IVertexValidator {
    
    // MARK: - Memory Management
    
    let transitionMatrix: TransitionMatrix
    
    init(_ transitionMatrix: TransitionMatrix) {
        self.transitionMatrix = transitionMatrix
    }
    
    // MARK: - IRouteValidator
    
    func canStartRoute(from vertex: Int) -> Bool {
        return !transitionMatrix.getToVertices(from: vertex).isEmpty
    }
    
    func canFinishRoute(in vertex: Int) -> Bool {
        return !transitionMatrix.map{ $0[vertex] }.filter{ $0 > 0 }.isEmpty
    }
}
