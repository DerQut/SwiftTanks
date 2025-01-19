//
//  distance.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 19/01/2025.
//

import SwiftUI

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow((point.x - x), 2) + pow((point.y - y), 2))
    }
}
