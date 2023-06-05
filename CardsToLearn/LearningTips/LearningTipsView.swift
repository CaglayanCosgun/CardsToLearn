//
//  LearningTipsView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 03.06.23.
//

import SwiftUI

struct LearningTipsView: View {
    
    @State var tips: [Tips] = sampleTips
    
    @State var currentIndex: Int = 0
    @State var currentTip: Tips = sampleTips.first!
    
    var body: some View {
        VStack(spacing: 0){
            Text(titleString)
                .font(.largeTitle)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.bottom,40)
            
            VStack{
                LearnTipArtScroller()
                    .zIndex(1)
                standView
                    .zIndex(0)
            }
            
            .padding(.horizontal,-15)
            .zIndex(1)
            
            
            TabView {
                ForEach($tips) { $tip in
                    TipCardView(tip: tip)
                        .offsetX { value,width in
                            if currentIndex == getIndex(tip: tip) {
                                
                                var offset = ((value > 0 ? -value : value) / width) * 80
                                offset = (-offset < 80 ? offset : -80)
                                tip.diskOffset = offset
                                
                            }
                            if value == 0 && currentIndex != getIndex(tip: tip) {
                                tip.diskOffset = 0
                                withAnimation(.easeInOut(duration: 0.6)) {
                                    tips[currentIndex].showDisk = false
                                    currentIndex = getIndex(tip: tip)
                                    currentTip = tips[currentIndex]
                                }
                                
                            }
                            
                        }
                }
            }
            .padding(.horizontal,-15)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .zIndex(0)
        }
        .padding(15)
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .background(Color("white"),ignoresSafeAreaEdges: .all)
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 1,blendDuration: 1).delay(0.4)) {
                tips[currentIndex].showDisk = true
            }
        }
    }
    
    
    func getIndex(tip: Tips)-> Int {
        return tips.firstIndex{ _tip in
            return _tip.id == tip.id
        } ?? 0
    }
    
    @ViewBuilder
    func TipCardView(tip: Tips) -> some View {
        VStack(alignment: .leading, spacing: 6){
            HStack{
                Text("Tip")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray.opacity(0.6))
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                HStack(spacing: 5){
                    ForEach(1...5,id: \.self) { index in
                        Image(systemName: "star.fill")
                            .font(.system(size: 8))
                            .foregroundColor(.gray.opacity(index >= tip.rating ? 0.2 : 1))
                        
                    }
                    Text("\(tip.rating).0")
                        .font(.caption)
                        .padding(.leading,5)
                    
                }
            }
            Text(tip.tipName)
                .font(.title.bold())
            
            Label {
                Text("Cards to Learn")
            }icon: {
                Text("By")
                    .foregroundColor(.gray.opacity(0.7))
            }
            .padding(.top,12)
            
            Text(tip.tipText)
                .foregroundColor(.gray.opacity(0.7))
                .padding(.top,10)
            
            HStack(spacing: 10) {
                ForEach(["Learn","Quiz","Cards","Student"],id: \.self) { tag in
                    Toggle(tag, isOn: .constant(false))
                        .toggleStyle(.button)
                        .buttonStyle(.bordered)
                        .tint(.gray)
                        .font(.caption)
                    
                }
            }
            .padding(.top)
        }
        .padding(.top,30)
        .padding([.horizontal,.bottom])
        .background {
            CustomCorners(corners: [.bottomLeft,.bottomRight], radius: 25).fill(.white.opacity(0.6))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal,30)
    }
    
    @ViewBuilder
    func LearnTipArtScroller() -> some View {
        
        GeometryReader { proxy in
            let size = proxy.size
            
            LazyHStack(spacing: 0) {
                ForEach($tips) { $tip in
                    HStack(spacing: 0) {
                        Image(tip.tipImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 170,height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5,x: 0,y: 10)
                            .zIndex(1)
                        
                        Image("round")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 160,height: 180)
                            .overlay {
                                Image(tip.tipImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60,height: 60)
                                    .clipShape(Circle())
                            }
                            .rotationEffect(.init(degrees: tip.showDisk ? 0 : 40))
                            .rotationEffect(.init(degrees: tip.diskOffset / -80) * 40)
                            .offset(x: tip.showDisk ? 80 : 0)
                            .offset(x: tip.showDisk ? tip.diskOffset : 0)
                            .scaleEffect(tip.showDisk ? 1 : 0.1)
                            .padding(.leading,-170)
                            .zIndex(0)
                    }
                    .offset(x: -35)
                    .frame(width: size.width, alignment: currentIndex > getIndex(tip: tip) ? .trailing : currentIndex == getIndex(tip: tip) ? .center : .leading)
                    .scaleEffect(currentTip.id == tip.id ? 1 : 0.8, anchor: .bottom)
                    .offset(x: currentIndex > getIndex(tip: tip) ? 100 : currentIndex == getIndex(tip: tip) ? 0 : -40)
                    
                }
            }
            .offset(x:CGFloat(currentIndex) * -size.width)
        }
        .frame(height: 180)
        
    }
    
    var standView: some View{
        Rectangle()
            .fill(.white.opacity(0.6))
            .shadow(color: .black.opacity(0.85), radius: 20,x: 0,y: 5)
            .frame(height: 10)
            .overlay(alignment: .top) {
                Rectangle()
                    .fill(.white.opacity(0.75).gradient)
                    .frame(height: 385)//385
                    .rotation3DEffect(.init(degrees: -98),axis: (x:1,y:0,z:0),anchor: .top,anchorZ: 0.5,perspective: 1)
                    .shadow(color: .black.opacity(0.08), radius: 25,x: 0,y: 5)
                    .shadow(color: .black.opacity(0.08), radius: 5,x: 0,y: 15)
            }
            .scaleEffect(1.5)
    }
    
    var titleString: AttributedString{
        var attString = AttributedString(stringLiteral: "My Learningtips")
        if let range = attString.range(of: "Learningtips"){
            attString[range].font = .largeTitle.bold()
        }
            
        return attString
    }
        
}

struct LearningTipsView_Previews: PreviewProvider {
    static var previews: some View {
        LearningTipsView()
    }
}


extension View {
    func offsetX(completion: @escaping (CGFloat,CGFloat)->())-> some View {
        self
            .overlay {
            GeometryReader {proxy in
                    Color.clear
                    .preference(key: OffsetXKey.self,value: proxy.frame(in: .global).minX)
                    .onPreferenceChange(OffsetXKey.self) { value in
                        
                        completion(value,proxy.size.width)
                        
                    }
            }
        }
    }
}


struct OffsetXKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
