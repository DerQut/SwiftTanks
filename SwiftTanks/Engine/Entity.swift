//
//  Entity.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 18/01/2025.
//

import Foundation
import SwiftUI

protocol Entity: Identifiable {
    var id: UUID { get }
    var position: CGPoint { get set }
    var angle: Angle { get set }
    var velocity: CGFloat { get set }
    var size: CGFloat { get }
}
