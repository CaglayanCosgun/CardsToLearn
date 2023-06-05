//
//  HomeSideView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.06.23.
//

import SwiftUI

struct HomeSideView: View {
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack(alignment: .leading, spacing: 15) {
                Image("morning")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRectSlide().width - 30, height: 250)
                    .cornerRadius(18)
                
                Text("Good Morning")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Image("noon")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRectSlide().width - 30, height: 250)
                    .cornerRadius(18)
                
                Text("Good Day")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Image("evening")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRectSlide().width - 30, height: 250)
                    .cornerRadius(18)
                
                Text("Good Evening")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Image("night")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRectSlide().width - 30, height: 250)
                    .cornerRadius(18)
                
                Text("Good Night")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}

struct HomeSideView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSideView()
    }
}
