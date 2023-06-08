//
//  ApiQuotesView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 07.06.23.
//

import SwiftUI

struct ApiQuotesView: View {
    
    @State var currentImage: QuotePic = sampleImages.first!
    
    
    @EnvironmentObject var quotesVM: ApiQuotesViewModel
    @State private var searchCategory: String = ""
    @State private var showMenu: Bool = false
    @State private var textOffset: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        VStack{
            HeaderView()
            
            QuoteSlider()
            
            ImageDetailView()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
    }
    
   
    func indexOf(image: QuotePic)-> Int{
        if let index = sampleImages.firstIndex(of: image){
            return index
        }
        return 0
    }
    
    @ViewBuilder
    func ImageDetailView()->some View{
        VStack{
            
            GeometryReader{
                let size = $0.size
                
                HStack(spacing: 0){
                    ForEach(sampleImages){image in
                        
                        let index = indexOf(image: image)
                        let currentIndex = indexOf(image: currentImage)
                        
                        VStack(alignment: .leading, spacing: 18){
                            Text(image.category)
                                .font(.largeTitle)
                                .foregroundColor(.black.opacity(0.7))
                                .offset(x: CGFloat(currentIndex) * -(size.width + 30))
                                .opacity(currentIndex == index ? 1 : 0 )
                                .animation(.interactiveSpring(response: 0.6,dampingFraction: 0.7,blendDuration: 0.7).delay(currentIndex < index ? 0.1 : 0), value: currentIndex == index)
                            Text(image.title)
                                .font(.title)
                                .foregroundColor(.black.opacity(0.7))
                                .offset(x: CGFloat(currentIndex) * -(size.width + 30))
                                .opacity(currentIndex == index ? 1 : 0 )
                                .animation(.interactiveSpring(response: 0.6,dampingFraction: 0.7,blendDuration: 0.7).delay(currentIndex > index ? 0.1 : 0), value: currentIndex == index)
                            Text(image.author)
                                .font(.headline)
                                .foregroundColor(.gray)
                                .offset(x: CGFloat(currentIndex) * -(size.width + 30))
                                .opacity(currentIndex == index ? 1 : 0 )
                                .animation(.interactiveSpring(response: 0.6,dampingFraction: 0.7,blendDuration: 0.7).delay(currentIndex > index ? 0.1 : 0), value: currentIndex == index)
                        }
                        .frame(width: size.width + 30,alignment: .leading)
                        
                    }
                    
                }
            }
            .padding(.horizontal,15)
            .frame(height: 300)
            .padding(.bottom,10)
            
            ZStack(alignment: .leading){
                Capsule()
                    .fill(.gray.opacity(0.4))
                
                GeometryReader{
                    
                    let size = $0.size
                    
                    Capsule()
                        .fill(.green)
                        .frame(width: CGFloat(indexOf(image: currentImage)) / CGFloat(sampleImages.count - 1) * size.width)
                        .animation(.interactiveSpring(response: 0.6,dampingFraction: 0.75,blendDuration: 0.75), value: currentImage)
                }
                
            }
            .frame(height: 4)
            .padding(.top,10)
            .padding([.horizontal,.bottom],15)
        }
    }
    
    
    @ViewBuilder
    func QuoteSlider()->some View{
        
        TabView(selection: $currentImage){
            ForEach(sampleImages){ image in
                ImageView(image: image)
                    .tag(image)
                
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        
    }
    
    
    @ViewBuilder
    func ImageView(image: QuotePic) -> some View {
        GeometryReader {
            let size = $0.size
            let rect = $0.frame(in: .global)
            let minX = (rect.minX - 50) < 0 ? (rect.minX - 50) : -(rect.minX - 50)
            let progress = (minX) / rect.width
            let rotation = progress * 45
            
            ZStack {
                
                IsoMetricsView(depth: 10) {
                    Color.white
                }bottom: {
                    Color.white
                }side: {
                    Color.white
                }
                .frame(width: size.width / 1.2, height: size.height / 1.5)
                .shadow(color: .black.opacity(0.12), radius: 5,x: 15,y: 8)
                .shadow(color: .black.opacity(0.1), radius: 6,x: -10,y: -8)
                
                Image(image.imageText)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width / 1.2, height: size.height / 1.5)
                    .clipped()
                    .shadow(color: .black.opacity(0.1), radius: 6,x: 10,y: 8)
                
                    .rotation3DEffect(.init(degrees: rotation), axis: (x: 0, y: 1, z: 0),anchor: .leading,perspective: 1)
                    .modifier(CustomProjection(value: 1 + (-progress < 1 ? progress : -1.0)))
                
               
            }
            .offset(x: indexOf(image: image) > 0 ? -(progress * 45) : 0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(.horizontal, 50)
    }

    
    @ViewBuilder
    func HeaderView()->some View{
        HStack(spacing: 15){
            Text("Quotes")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.7))
                .frame(maxWidth: .infinity,alignment: .leading)
            
            Button{
                
            }label: {
                Image(systemName: "quote.opening")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            
            Button{
                
            }label: {
                Image(systemName: "quote.closing")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
        .padding(15)
    }
}

struct ApiQuotesView_Previews: PreviewProvider {
    static var previews: some View {
        ApiQuotesView()
    }
}
