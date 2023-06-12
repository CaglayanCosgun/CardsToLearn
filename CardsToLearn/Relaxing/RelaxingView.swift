//
//  Relax.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 02.06.23.
//

import SwiftUI

struct Relax: View {
    
    @State var index = 0
    
    @State var titles = [
        "Clean your Mind from",
        "Unique experience",
        "The ultimate program"
    ]
    
    @State var subTitles = [
        "Negativity - Stress - Anexity",
        "prepare your mind for sweet dreams",
        "Healty mind - better sleep - well being"
    ]
    
    @State var currentIndex = 2
    
    @State var titleText: [TextAnimation] = []
    
    @State var subTitleAnimation: Bool = false
    @State var endAnimation = false
    var body: some View {
        
        ZStack {
            GeometryReader{ proxy in
                
                let size = proxy.size
                
                Color.black
                
                ForEach(1...7,id: \.self) { index in
                    
                    Image("pic\(index)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size.width, height: size.height)
                        .opacity(currentIndex == (index - 1) ? 1 : 0)
                    
                }
                
                LinearGradient(colors: [
                    .clear,
                    .black.opacity(0.5),
                    .black
                ], startPoint: .top, endPoint: .bottom)
                
            }
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                HStack(spacing: 0){
                    ForEach(titleText) { text in
                        
                        Text(text.text)
                            .offset(y: text.offset)
                    }
                    .font(.title.bold())
                }
                .offset(y: endAnimation ? -100 : 0)
                .opacity(endAnimation ? 0 : 1)
                
                Text(subTitles[currentIndex])
                    .opacity(0.7)
                    .offset(y: !subTitleAnimation ? 80 : 0)
                    .offset(y: endAnimation ? -100 : 0)
                    .opacity(endAnimation ? 0 : 1)
                
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .onAppear(perform: {
            currentIndex = 0
        })
        .onChange(of: currentIndex) { newValue in
            
            getSpilitedText(text: titles[currentIndex]) {
                
                withAnimation(.easeInOut(duration: 1)) {
                    endAnimation.toggle()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    
                    titleText.removeAll()
                    subTitleAnimation.toggle()
                    endAnimation.toggle()
                    
                    withAnimation(.easeIn(duration: 1.6)) {
                        if currentIndex < (titles.count - 1) {
                            currentIndex += 1
                        }
                        else {
                            currentIndex = 0
                        }
                    }
                }
            }
            
        }
    }
    func getSpilitedText(text: String,completion: @escaping()->()) {
        
        for (index,character) in text.enumerated() {
            
            titleText.append(TextAnimation(text:String(character)))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.03) {
                
                withAnimation(.easeInOut(duration: 0.5)) {
                    titleText[index].offset = 0
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(text.count) * 0.02) {
            
            withAnimation(.easeInOut(duration: 0.5)) {
                subTitleAnimation.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() +  0.95) {
                
                completion()
            }
        }
    }
}

struct TextAnimation: Identifiable {
    var id = UUID().uuidString
    var text : String
    var offset: CGFloat = 110
}


struct Relax_Previews: PreviewProvider {
    static var previews: some View {
        Relax()
    }
}
