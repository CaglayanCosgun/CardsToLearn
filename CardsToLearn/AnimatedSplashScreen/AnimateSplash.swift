//
//  AnimateSplash.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.06.23.
//

import SwiftUI

struct AnimateSplash: View {
    var body: some View {
        VStack{
            HStack {
                
                Text("Cards to Learn")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("black"))
                
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(Color.white)
            
            Spacer()
        }
        .ignoresSafeArea(.all,edges: .top)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
    }
}

struct AnimateSplash_Previews: PreviewProvider {
    static var previews: some View {
        AnimateSplash()
    }
}
