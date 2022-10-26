//Created by Alexander Skorulis on 25/10/2022.

import Foundation
import SwiftUI
import ASSwiftUI

// MARK: - Memory footprint

struct MoodIndicator {
    
    let value: Double
    
}

// MARK: - Rendering

extension MoodIndicator: View {
    
    var body: some View {
        Circle()
            .fill(faceColor)
            .overlay(face)
    }
    
    private var faceColor: Color {
        return Color.red.mix(other: Color.green, pct: value)
    }
    
    private var face: some View {
        MouthShape(value: value)
            .stroke(Color.black, lineWidth: 2)
    }
}

private struct MouthShape: Shape {
    
    let value: Double
    
    func path(in rect: CGRect) -> Path {
        let inset = rect.width / 4
        let eyeInset = rect.width / 3.2
        let eyeY = rect.height * 0.2
        let mouthY = rect.height * 0.65
        let eyeSize = rect.size.width * 0.1
        let mouthHeight = 0.5 * rect.height * (value - 0.5)
        let start = CGPoint(x: inset, y: mouthY)
        let end = CGPoint(x: rect.width - inset, y: mouthY)
        let cp1 = CGPoint(x: rect.width/4, y: mouthHeight + mouthY)
        let cp2 = CGPoint(x: 3 * rect.width/4, y: mouthHeight + mouthY)
        
        var path = Path()
        path.move(to: start)
        path.addCurve(to: end, control1: cp1, control2: cp2)
        
        path.addEllipse(in: CGRect(x: eyeInset - eyeSize/2, y: eyeY, width: eyeSize, height: eyeSize))
        path.addEllipse(in: CGRect(x: rect.width - eyeInset - eyeSize/2, y: eyeY, width: eyeSize, height: eyeSize))
        
        return path
    }
}

// MARK: - Previews

struct MoodIndicator_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            StatefulPreviewWrapper(0) { value in
                VStack {
                    MoodIndicator(value: value.wrappedValue)
                        .frame(width: 200, height: 200)
                    Slider(value: value)
                }
            }
            
            MoodIndicator(value: 0.5)
                .frame(width: 80)
        }
    }
}

