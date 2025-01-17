//
//  Bullet.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 17/01/2025.
//

import Foundation
import SwiftUI

enum BulletType: String, CaseIterable, Identifiable {
    case normal
    case fast
    case bouncy
    
    var id: String { self.rawValue.capitalized }
}


class Bullet: Entity {
    let id = UUID()
    
    let owner: Player
    let damage: Double
    let size: CGFloat
    var velocity: CGFloat
    
    var position: CGPoint
    var angle: Angle
    
    let maxBounces: Int
    var bouncesLeft: Int
    
    init(owner: Player, damage: Double, maxBounces: Int, size: CGFloat, velocity: CGFloat, position: CGPoint, angle: Angle) {
        self.owner = owner
        self.damage = damage
        self.size = size
        self.velocity = velocity
        self.position = position
        self.angle = angle
        self.maxBounces = maxBounces
        self.bouncesLeft = maxBounces
    }
}


class BulletFactory {
    
    func createBullet(owner: Player) -> Bullet {
        switch owner.bulletType {
        case .bouncy:
            return Bullet(owner: owner, damage: 8, maxBounces: 2, size: 20, velocity: 6, position: owner.position, angle: owner.angle)
        case .fast:
            return Bullet(owner: owner, damage: 9, maxBounces: 0, size: 15, velocity: 10, position: owner.position, angle: owner.angle)
        default:
            return Bullet(owner: owner, damage: 10, maxBounces: 1, size: 25, velocity: 8, position: owner.position, angle: owner.angle)
        }
    }
    
    func getRechargeTime(of bulletType: BulletType) -> Int {
        switch bulletType {
        case .bouncy:
            return 150
        case .fast:
            return 80
        default:
            return 120
        }
    }
}
