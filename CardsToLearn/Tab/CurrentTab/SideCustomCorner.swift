//
//  SideCustomCorner.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.06.23.
//

import SwiftUI

struct SideCustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
