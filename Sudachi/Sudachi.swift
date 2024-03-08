//
//  Sudachi.swift
//  Sudachi
//
//  Created by Jarrod Norwell on 4/3/2024.
//

import Foundation
import QuartzCore.CAMetalLayer

public struct Sudachi {
    public static let shared = Sudachi()
    
    fileprivate let sudachiObjC = SudachiObjC.shared()
    
    public func configure(layer: CAMetalLayer) {
        sudachiObjC.configure(layer: layer)
    }
    
    public func information(for url: URL) -> SudachiInformation {
        sudachiObjC.gameInformation.information(for: url)
    }
    
    public func insert(game url: URL) {
        sudachiObjC.insert(game: url)
    }
    
    public func step() {
        sudachiObjC.step()
    }
    
    public func orientationChanged(orientation: UIInterfaceOrientation) {
        // sudachiObjC.orientationChanged(orientation)
    }
    
    public func touchBegan(at point: CGPoint, for index: UInt) {
        sudachiObjC.touchBegan(at: point, for: index)
    }
    
    public func touchEnded(for index: UInt) {
        sudachiObjC.touchEnded(for: index)
    }
    
    public func touchMoved(at point: CGPoint, for index: UInt) {
        sudachiObjC.touchMoved(at: point, for: index)
    }
    
    public func virtualControllerButtonDown(_ button: SudachiVirtualControllerButtonType) {
        sudachiObjC.virtualControllerButtonDown(button)
    }
    
    public func virtualControllerButtonUp(_ button: SudachiVirtualControllerButtonType) {
        sudachiObjC.virtualControllerButtonUp(button)
    }
}
