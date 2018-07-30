//
//  RoutesCalculator.swift
//  017_test_dispatchGroup
//
//  Created by Oleg Kolomyitsev on 28/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

class RoutesCalculator: IRoutesCalculator {
    
    /// from row to column
    let transitionMatrix: TransitionMatrix

    // MARK: - Memory Management
    
    init(_ transitionMantrix: TransitionMatrix) {
        self.transitionMatrix = transitionMantrix
    }
    
    // MARK: - IRoutesCalculator
    
    func getRoutes(from start: Vertex, to final: Vertex) -> Routes {
        var newRoutes = [[start]]
        var toVertices = getToVertices(newRoutes, final)
        while !needToStop(toVertices: toVertices) { /// Be careful: potential infinite loop
            newRoutes = getNewRoutes(newRoutes, toVertices)
            toVertices = getToVertices(newRoutes, final)
        }
        let filteredRoutes = removeExcessRoutes(newRoutes, final)
        
        return filteredRoutes
    }
    
    func log(_ data: [[Vertex]]) {
        guard !data.isEmpty else {
            return
        }
        data.enumerated().forEach{
            $1.forEach{ print($0, terminator: " ")  }
            print()
        }
        print("---------------------------------")
    }
    
    // MARK: - Routes Calculation
    
    private func needToStop(toVertices: ToVertices) -> Bool {
        return toVertices.filter { !$0.isEmpty }.count == 0
    }
    
    private func removeExcessRoutes(_ routes: Routes, _ final: Vertex) -> Routes {
        routes.forEach{ precondition($0.last != nil, "Empty route not allowable") }
        return routes.filter{ $0.last == final }
    }
    
    private func getToVertices(_ routes: Routes, _ final: Vertex) -> ToVertices {
        let toVertices = getToVertices(routes)
        let toVerticesWithStop = zip(routes, toVertices).map { (zipped: (route: [Vertex], toVertices: [Vertex])) -> [Vertex] in
            return zipped.route.last == final ? [] : zipped.toVertices
        }
        
        return toVerticesWithStop
    }
    
    private func getToVertices(_ routes: Routes) -> ToVertices {
        routes.forEach{ precondition($0.last != nil, "Empty route not allowable") }
        let toVertices = routes.map{ transitionMatrix.getToVertices(from: $0.last!) }
        let toVerticesWithoutCycles = removeCycles(from: toVertices, using: routes)

        return toVerticesWithoutCycles
    }
    
    private func removeCycles(from toVertices: ToVertices, using routes: Routes) -> ToVertices {
        precondition(toVertices.count == routes.count, "Routes and vertices count must be equal")
        let toVerticesWithoutCycles = zip(routes, toVertices).map { (zipped: (route: [Vertex], toVertices: [Vertex])) -> [Vertex] in
            if zipped.toVertices.count > 0 {
                let needToRemove = Set(zipped.route).intersection(zipped.toVertices)
                return zipped.toVertices.filter { !needToRemove.contains($0) }
            } else {
                return zipped.toVertices
            }
        }
        
        return toVerticesWithoutCycles
    }
    
    private func getNewRoutes(_ oldRoutes: Routes, _ toVertices: ToVertices) -> Routes {
        precondition(oldRoutes.count == toVertices.count, "Routes and vertices count must be equal")
        let newRoutes = zip(oldRoutes, toVertices).map { (zipped: (rout: [Vertex], toVertices: [Vertex])) -> [[Vertex]] in
            if zipped.toVertices.count > 0 {
                let newRouts = Array(repeating: zipped.rout, count: zipped.toVertices.count)
                return newRouts.enumerated().map { $1 + [ zipped.toVertices[$0] ]}
            } else {
                return Array(repeating: zipped.rout, count: 1)
            }
        }
        
        return newRoutes.flatMap{ $0 }
    }
    
}
