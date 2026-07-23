//
//  CyberGridView.swift
//  DNTWEAKS IOS
//

import SwiftUI

struct CyberGridView: View {
    var body: some View {
        Canvas { context, size in
            let spacing: CGFloat = 40
            let lineColor = Color.neonPurple.opacity(0.15)
            
            // Vertical lines
            for x in stride(from: 0, through: size.width, by: spacing) {
                var path = Path()
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x, y: size.height))
                context.stroke(path, with: .color(lineColor), lineWidth: 0.8)
            }
            
            // Horizontal lines
            for y in stride(from: 0, through: size.height, by: spacing) {
                var path = Path()
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
                context.stroke(path, with: .color(lineColor), lineWidth: 0.8)
            }
        }
    }
}
