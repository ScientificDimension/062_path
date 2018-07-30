//
//  DataParser.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class DataParser: IDataParser {
    
    typealias ToVerticiesPaths = [String: [String: Path]]
    
    // MARK: - IDataParser
    
    func getPointsVector(from data: Container) -> PointsVector {
        let indexes = (0..<data.points.count)
        let keys = indexes.map { "R-\(data.plan_id)-\($0)"}
        let serverPoints = keys.compactMap { data.points[$0] }
        
        return serverPoints.map { CGPoint($0)}
    }
    
    func getDistanceMatrix(from data: Container) -> DistanceMatrix {
        let emptyMatrix: DistanceMatrix = getEmptyMatrix(size: data.points.count, placeholder: 0)
        let pupulatedMatrix = populateMatrix(emptyMatrix, data.paths) { row, column in
            return data.paths[row]?[column]?.distance ?? 0
        }

        return pupulatedMatrix
    }
    
    func getTransitionMatrix(from data: Container) -> TransitionMatrix {
        let emptyMatrix: TransitionMatrix = getEmptyMatrix(size: data.points.count, placeholder: 0)
        let pupulatedMatrix = populateMatrix(emptyMatrix, data.paths) { _ , _ in
            return 1
        }
        
        return pupulatedMatrix
    }
    
    // MARK: - Matix Building
    
    private func getEmptyMatrix<T: Numeric>(size: Int, placeholder: T) -> [[T]] {
        let toVerticesRowVector = Array(repeating: placeholder, count: size)
        let matrix = Array(repeating: toVerticesRowVector, count: size)
        
        return matrix
    }
    
    private func populateMatrix<T: Numeric>(
        _ emptyMatrix: [[T]],
        _ paths: ToVerticiesPaths,
        _ getElement: @escaping (_ row: String, _ column: String) -> T) -> [[T]] {
        var populatedMatrix = emptyMatrix
        paths.forEach{ fromVertex, value in
            let toVertices = value.keys
            toVertices.forEach{ toVertix in
                populatedMatrix[fromVertex.index][toVertix.index] = getElement(fromVertex, toVertix)
            }
        }
        
        return populatedMatrix
    }
    
}
