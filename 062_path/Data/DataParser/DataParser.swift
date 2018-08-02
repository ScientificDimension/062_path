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
        let populatedMatrix = populateMatrix(
            emptyMatrix,
            data.paths,
            getElement: { [unowned self] row, column in
                let position = self.update(Position(row: row, column: column), basedOn: data.paths)
                let distance = data.paths[position]?.distance ?? 0
                
                return (forth: distance, back: distance)
        })
        
        return populatedMatrix
    }
    
    func getTransitionMatrix(from data: Container) -> TransitionMatrix {
        let emptyMatrix: TransitionMatrix = getEmptyMatrix(size: data.points.count, placeholder: 0)
        let pupulatedMatrix = populateMatrix(
            emptyMatrix,
            data.paths,
            getElement: { _ , _ in
                return (forth: 1, back: 1)
        })
        
        return pupulatedMatrix
    }
    
    func getVisiblePointsMatrix(from data: Container) -> VisiblePointsMatrix {
        let emptyMatrix: VisiblePointsMatrix = getEmptyMatrix(size: data.points.count, placeholder: [])
        let populatedMatrix = populateMatrix(
            emptyMatrix,
            data.paths,
            getElement: {[unowned self] row , column in
                let position = self.update(Position(row: row, column: column), basedOn: data.paths)
                let points = data.paths[position]?.visiblePoints.map { CGPoint($0)} ?? []
                
                return (forth: points, back: points)
        })
        
        return populatedMatrix
    }
    
    // MARK: - Updating Position
    
    private func update(_ position: Position, basedOn paths: ToVerticiesPaths) -> Position {
        let forth = paths[position]?.visiblePoints.map { CGPoint($0)} ?? []
        let back = paths[position.reversed]?.visiblePoints.map { CGPoint($0)} ?? []
        
        return forth.count > back.count ? position : position.reversed
    }
    
    // MARK: - Matix Building
    
    private func getEmptyMatrix<T>(size: Int, placeholder: T) -> [[T]] {
        let toVerticesRowVector = Array(repeating: placeholder, count: size)
        let matrix = Array(repeating: toVerticesRowVector, count: size)
        
        return matrix
    }

    private func populateMatrix<T>(
        isForthAndBack: Bool = true,
        _ emptyMatrix: [[T]],
        _ paths: ToVerticiesPaths,
        getElement: @escaping (_ row: String, _ column: String) -> (forth: T, back: T)) -> [[T]] {
        var populatedMatrix = emptyMatrix
        paths.forEach{ fromVertex, value in
            let toVertices = value.keys
            toVertices.forEach{ toVertix in
                let (forth, back) = getElement(fromVertex, toVertix)
                populatedMatrix[fromVertex.index][toVertix.index] = forth
                if isForthAndBack {
                    populatedMatrix[toVertix.index][fromVertex.index] = back
                }
            }
        }
        
        return populatedMatrix
    }
    
}
