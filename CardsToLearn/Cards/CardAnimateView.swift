//
//  CardAnimateView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 06.06.23.
//

import SwiftUI
//
//struct CardAnimateView: View {
//
//    @State var currentImage = "dark10"
//
//    var body: some View {
//        ZStack{
//
//            GeometryReader{ proxy in
//
//                let size = proxy.size
//
//                Image(currentImage)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: size.width,height: size.height)
//                    .cornerRadius(1)
//
//            }
//            .ignoresSafeArea()
//            .overlay(.ultraThinMaterial)
//            .colorScheme(.dark)
//
//            TabView(selection: $currentImage){
//
//                ForEach(1...11,id: \.self){ index in
//                    CarousselBodyView(index: index)
//
//                }
//            }
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//        }
//    }
//}
//
//struct CardAnimateView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardAnimateView()
//    }
//}



struct CardAnimateView: View {
    let card: Card
    @State private var showingQuestion = true
    @EnvironmentObject var viewModel: CardViewModel
    @State private var selectedCard : Card?
    
    @State var currentImage = "dark10"

    var body: some View {
        ZStack{
            GeometryReader{ proxy in
                let size = proxy.size

                Image(currentImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(1)
            }
            .ignoresSafeArea()
            .overlay(.ultraThinMaterial)
            .colorScheme(.dark)

            TabView(selection: $currentImage) {
//                ForEach(viewModel.cards, id: \.self) { card in
                    CarousselBodyView(card: card)
//                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}


//struct CardAnimateView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardAnimateView()
//    }
//}
