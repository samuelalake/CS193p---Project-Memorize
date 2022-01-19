//
//  Pie.swift
//  Memorize
//
//  Created by Samuel Alake on 1/18/22.
//

import SwiftUI

struct Pie: Shape{
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    //using var clockwise in struct as compared to let will allow use of free initialization to change value of clockwise in component if dev wants to
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)),
            y: center.y + radius * CGFloat(cos(startAngle.radians))
        )
        
        var p = Path()
        
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center,
                 radius: radius,
                 startAngle: startAngle,
                 endAngle: endAngle,
                 clockwise: !clockwise)
        //clockwise is actually flipped in Swift so initialize arc with anti-clockwise
        p.addLine(to: center)
        return p
    }
    
    
}
