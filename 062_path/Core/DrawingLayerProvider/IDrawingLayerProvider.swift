//
//  IDrawingLayerProvider.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol IDrawingLayerProvider {
    var pointsLayer: CAShapeLayer { get }
    var routesLayer: CAShapeLayer { get }
    var startPointLayer: CAShapeLayer { get }
    var finalPointLayer: CAShapeLayer { get }
}

extension IDrawingLayerProvider {
    
    func configureLayers(for view: UIView) {
        updateLayersFrame(with: view.bounds)
        addLayers(to: view)
    }
    
    private func updateLayersFrame(with newFrame: CGRect) {
        routesLayer.frame = newFrame
        pointsLayer.frame = newFrame
        startPointLayer.frame = newFrame
        finalPointLayer.frame = newFrame
    }

    private func addLayers(to view: UIView) {
        view.layer.addSublayer(routesLayer)
        view.layer.addSublayer(pointsLayer)
        view.layer.addSublayer(startPointLayer)
        view.layer.addSublayer(finalPointLayer)
    }

}
