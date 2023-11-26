//
//  SpeakerArc.swift
//  Scrumdinger
//
//  Created by nat on 26/11/2023.
//

import SwiftUI

struct SpeakerArc: Shape {
    let speakerIndex: Int
    let totalSpeakers: Int
    
    //  calculate the degrees of a single arc
    private var degreesPerSpeaker: Double {
        360.0 / Double(totalSpeakers)
    }
    
    private var startAngle: Angle {
        //  The additional 1.0 degree is for visual separation between arc segments.
        Angle(degrees: degreesPerSpeaker * Double(speakerIndex) + 1.0)
    }
    
    private var endAngle: Angle {
        //  The subtracted 1.0 degree is for visual separation between arc segments.
        Angle(degrees: startAngle.degrees + degreesPerSpeaker - 1.0)
    }
    
    func path(in rect: CGRect) -> Path {
        //  the circle strokeBorder's width is 24
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        //  store the centre of the rectangle
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}
