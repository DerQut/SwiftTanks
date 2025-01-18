//
//  Bullet.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 17/01/2025.
//

import Foundation
import SwiftUI

enum BulletType {
    case normal
    case bouncy
    case fast
}


class Bullet: Entity {
    let id = UUID()
    
    let owner: Player
    let damage: Int
    let size: CGFloat
    var velocity: CGFloat
    
    var position: CGPoint
    var angle: Angle
    
    var bouncesLeft: Int
    
    init(owner: Player, damage: Int, maxBounces: Int, size: CGFloat, velocity: CGFloat, position: CGPoint, angle: Angle) {
        self.owner = owner
        self.damage = damage
        self.size = size
        self.velocity = velocity
        self.position = position
        self.angle = angle
        self.bouncesLeft = maxBounces
    }
}


class BulletFactory {
    
    func createBullet(owner: Player) -> Bullet {
        switch owner.bulletType {
        case .bouncy:
            return Bullet(owner: owner, damage: 8, maxBounces: 3, size: 4, velocity: 20, position: owner.position, angle: owner.angle)
        case .fast:
            return Bullet(owner: owner, damage: 10, maxBounces: 1, size: 5, velocity: 40, position: owner.position, angle: owner.angle)
        default:
            return Bullet(owner: owner, damage: 10, maxBounces: 2, size: 5, velocity: 20, position: owner.position, angle: owner.angle)
        }
    }
}
