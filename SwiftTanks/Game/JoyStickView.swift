//
//  JoyStickView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 11/01/2025.
//

import SwiftUI

struct JoyStickView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    @State private var location: CGPoint = .zero
    @State private var innerCircleLocation: CGPoint = .zero
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil
    
    private let bigCircleRadius: CGFloat = 75
    let forceAngleOffset: CGFloat
    
    var playerDelegateID: Int

    var fingerDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                // Calculate the distance between the finger location and the center of the blue circle
                let distance = sqrt(pow(value.location.x - location.x, 2) + pow(value.location.y - location.y, 2))
                
                // Calculate the angle between the center of the blue circle and the finger location
                let angle = atan2(value.location.y - location.y, value.location.x - location.x)
                
                // Calculate the maximum allowable distance within the blue circle
                let maxDistance = bigCircleRadius
                
                // Clamp the distance within the blue circle
                let clampedDistance = min(distance, maxDistance)
                
                // Calculate the new location at the edge of the blue circle
                let newX = location.x + cos(angle) * clampedDistance
                let newY = location.y + sin(angle) * clampedDistance
                
                innerCircleLocation = CGPoint(x: newX, y: newY)
                print(angleText, clampedDistance)
                
                if globalData.players[playerDelegateID] != nil {
                    globalData.players[playerDelegateID]!.angle = Angle.degrees(Double(angleText) ?? 0)
                    globalData.players[playerDelegateID]!.velocity = globalData.players[playerDelegateID]!.maxSpeed * clampedDistance/75
                }
            }
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
            .onEnded { value in
                // Snap the smaller circle to the center of the larger circle
                let center = location
                innerCircleLocation = center
                if globalData.players[playerDelegateID] != nil {
                    globalData.players[playerDelegateID]!.velocity = 0
                }
            }
    }
    
    var angleText: String {
        let angle = atan2(innerCircleLocation.y - location.y, innerCircleLocation.x - location.x) + self.forceAngleOffset
        var degrees = Int(-angle * 180 / .pi)
        
        // Convert the degrees to a positive value
        if degrees < 0 {
            degrees += 360
        }
        
        return "\(degrees)"
    }
    
    var body: some View {
        ZStack {
            // Larger circle (blue circle)
            Circle()
                .foregroundColor(.black)
                .frame(width: bigCircleRadius * 2, height: bigCircleRadius * 2)
                .position(location)
            
            // Smaller circle (green circle)
            Circle()
                .foregroundColor(.gray)
                .frame(width: 50, height: 50)
                .position(innerCircleLocation)
                .gesture(fingerDrag)
        }
    }
}

#Preview {
    ZStack {
        Color(.white)
            .ignoresSafeArea()
        PlayerControlView(forceAngleOffset: 0.0, playerDelegateID: 0)
            .opacity(0.5)
            .frame(height: 200)
    }
}
