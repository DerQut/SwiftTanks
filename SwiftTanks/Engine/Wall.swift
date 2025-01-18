//
//  Wall.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 18/01/2025.
//

import Foundation
import SwiftUI

enum Directions {
    case up
    case down
    case left
    case right
}

class Wall: Identifiable {
    let id: UUID = UUID()
    
    let position: CGPoint
    let size: CGSize
    
    init(position: CGPoint, size: CGSize) {
        self.position = position
        self.size = size
    }
    
    func checkIfCollided(with entity: any Entity) -> [Directions] {
        var confirmedCollisions: [Directions] = []
        
        let deltaX = abs(entity.position.x - self.position.x)
        let deltaY = abs(entity.position.y - self.position.y)
        
        // Check if entity directly above/below self
        if deltaX <= self.size.width/2 {
            
            // Check if entity clipped within an upper/lower wall
            if deltaY <= entity.size/2 + self.size.height/2 {
                if entity.position.y < self.position.y {
                    confirmedCollisions.append(.down)
                } else {confirmedCollisions.append(.up)}
            }
        }
        
        // Check if entity directly left/right to self
        if deltaY <= self.size.height/2 {
            
            // Check if entity clipped within a left/right wall
            if deltaX <= entity.size/2 + self.size.width/2 {
                if entity.position.x < self.position.x {
                    confirmedCollisions.append(.left)
                } else {confirmedCollisions.append(.right)}
            }
        }
        
        return confirmedCollisions
    }
}
