//
//  ExtensionSpecial.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.06.23.
//

import SwiftUI

extension View {
    var safeAreas: UIEdgeInsets {
        if let safeAreas = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets{
            return safeAreas
        }
        return .zero
    }
}

extension View {
    func glows(_ color: Color, radius: CGFloat) -> some View {
        
        self
            .shadow(color: color, radius: radius / 2.5)
            .shadow(color: color, radius: radius / 2.5)
            .shadow(color: color, radius: radius / 2.5)
    }
}
