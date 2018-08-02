//
//  Processor.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 30/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class Processor: IProcessor {
    
    // MARK: - Memory Management
    
    weak var presenter: UIViewController?
    
    private let alertAssistant: IAlertAssistant
    
    init(_ presenter: UIViewController) {
        self.presenter = presenter
        self.alertAssistant = AlertAssistant(presenter)
    }
    
    // MARK: - Logic Infrastructure
    
    private let stateTracker: IStateTracker = StateTracker()
    private let dataProvider: IDataProvider = DataProvider()
    private let dataParser: IDataParser = DataParser()
    private let layerProvider: IDrawingLayerProvider = DrawingLayerProvider()
    
    private lazy var scaleAdjuster: IScaleAdjuster = {
        let adjuster = ScaleAdjuster()
        let rawPoints = dataParser.getPointsVector(from: data)
        adjuster.calibrate(rawPoints)
        return adjuster
    }()
    
    private lazy var data: Container = {
        return dataProvider.getData()
    }()
    private lazy var transitionMatrix: TransitionMatrix = {
        return dataParser.getTransitionMatrix(from: data)
    }()
    private lazy var distanceMatrix: DistanceMatrix = {
        return dataParser.getDistanceMatrix(from: data)
    }()
    private lazy var visiblePointsMatrix: VisiblePointsMatrix = {
        let rawMatrix = dataParser.getVisiblePointsMatrix(from: data)
        let adjustedMatrix = rawMatrix.map{ $0.map{ scaleAdjuster.adjustPointsToScreenSize($0) } }
        return adjustedMatrix
    }()
    private lazy var nodalPoints: PointsVector = {
        let rawPoints = dataParser.getPointsVector(from: data)
        let adjustedPoints = scaleAdjuster.adjustPointsToScreenSize(rawPoints)
        
        return adjustedPoints
    }()
    
    private lazy var routesCalculator: IRoutesCalculator = RoutesCalculator(transitionMatrix)
    private lazy var vertexValidator: IVertexValidator = VertexValidator(transitionMatrix)
    private lazy var drawingAssistant: IDrawingAssistant = DrawingAssistant(nodalPoints, visiblePointsMatrix)
    private lazy var tapVertexFinder: ITapVertexFinder = TapVertexFinder(nodalPoints)
    private lazy var distanceEstimator: IRouteDistanceEstimator = RouteDistanceEstimator(distanceMatrix)
    
    // MARK: - Terminal Rout Vertices
    
    private var start: Vertex = 0
    private var final: Vertex = 0
    
    // MARK: - IProcessor
    
    func tryToStartWorking() -> CanStartWorking {
        guard let presenter = presenter else {
            return false
        }
        configureBackgroundImage(presenter.view)
        configureDrawingLayers(presenter.view)
        configureMapPoints()
        configureTapHandler(presenter.view)
        
        return true
    }
    
    // MARK: - Configurations
    
    private func configureDrawingLayers(_ view: UIView) {
        layerProvider.configureLayers(for: view)
    }
    
    private func configureBackgroundImage(_ view: UIView) {
        let backgroung = UIImageView(image: #imageLiteral(resourceName: "background"))
        view.addSubview(backgroung)
        backgroung.translatesAutoresizingMaskIntoConstraints = false
        backgroung.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backgroung.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        backgroung.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backgroung.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    private func configureMapPoints() {
        drawingAssistant.drawAllPoints(on: layerProvider.pointsLayer)
    }
    
    private func configureTapHandler(_ view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Tap Action
    
    @objc
    private func tap(_ sender: UITapGestureRecognizer) {
        guard let presenter = presenter else {
            return
        }
        let point = sender.location(in: presenter.view)
        let tapVertex = tapVertexFinder.findNearestVertex(to: point)
        
        switch stateTracker.currentState {
            
        case .selectStartPoint:
            
            start = tapVertex
            drawingAssistant.highlight(vertex: tapVertex, type: .start, on: layerProvider.startPointLayer)
            guard vertexValidator.canStartRoute(from: start) else {
                alertAssistant.tryShowAlert(
                    title: .cannotStart,
                    completion: startPointSelectionAlertCallback)
                
                return
            }
            
        case .selectFinalPoint:
            
            final = tapVertex
            drawingAssistant.highlight(vertex: tapVertex, type: .final, on: layerProvider.finalPointLayer)
            guard vertexValidator.canFinishRoute(in: final) else {
                alertAssistant.tryShowAlert(
                    title: .cannotFinish,
                    completion: finalPointSelectionAlertCallback)
                
                return
            }
            guard start != final else {
                alertAssistant.tryShowAlert(
                    title: .cannotProceedDueToEqual,
                    completion: finalPointSelectionAlertCallback)

                return
            }
            let routes = routesCalculator.getRoutes(from: start, to: final)
            routesCalculator.log(routes)
            guard routes.count > 0 else {
                alertAssistant.tryShowAlert(
                    title: .routesNotFound,
                    completion: finalPointSelectionAlertCallback)

                return
            }
            let routeToDraw = distanceEstimator.getRouteWithMinimalDistance(routes)
            drawingAssistant.draw(route: routeToDraw, on: layerProvider.routesLayer, useVisible: true)
            
        case .completed:
            
            layerProvider.routesLayer.clear()
            layerProvider.startPointLayer.clear()
            layerProvider.finalPointLayer.clear()
        }
        
        stateTracker.next()
    }
    
    // MARK: - Alert Callbacks
    
    private lazy var startPointSelectionAlertCallback: EmptyClosure = { [unowned self] in
        self.layerProvider.startPointLayer.clear()
    }
    
    private lazy var finalPointSelectionAlertCallback: EmptyClosure = { [unowned self] in
        self.layerProvider.finalPointLayer.clear()
    }
}
