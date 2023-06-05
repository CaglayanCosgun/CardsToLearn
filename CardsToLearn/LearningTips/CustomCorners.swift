//
//  CustomCorners.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 03.06.23.
//

import SwiftUI

struct CustomCorners: Shape {
    var corners : UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return .init(path.cgPath)
    }
    
}
