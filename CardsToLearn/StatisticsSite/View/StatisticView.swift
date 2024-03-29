//
//  StatisticView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 07.06.23.
//

import SwiftUI
import Charts

struct StatisticView: View {
    
    @State var sampleAnalytics: [Statistic] = sample_analytics
    @State var currentTabe: String = "7 Days"
    
    @State var currentActiveitem: Statistic?
    @State var plotWidth: CGFloat = 0
    
    @State var isLineGraph: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                
                VStack(alignment: .leading,spacing: 12){
                    
                    HStack{
                        
                        Text("Views")
                            .fontWeight(.semibold)
                        
                        Picker("", selection: $currentTabe){
                            Text("7 Days")
                                .tag("7 Days")
                            
                            Text("Week")
                                .tag("Week")
                            
                            Text("Month")
                                .tag("Month")
                        }
                        .pickerStyle(.segmented)
                        .padding(.leading,80)
                        
                    }
                    let totalValue = sampleAnalytics.reduce(0.0){ partialResult, item in
                        item.views + partialResult
                        
                    }
                    
                    Text(totalValue.stringFormat)
                        .font(.largeTitle.bold())
                    
                    AnimatedChart()
                    
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                        .fill(.white.shadow(.drop(radius: 2)))
                }
                
                Toggle("Line Graph",isOn: $isLineGraph)
                    .padding(.top)
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .padding()
            .navigationTitle("Learn Charts")
            .onChange(of: currentTabe) {newValue in
                sampleAnalytics = sample_analytics
                
                if newValue != "7 Days"{
                    for(index,_) in sampleAnalytics.enumerated(){
                        sampleAnalytics[index].views = .random(in: 1500...100000)
                    }
                }
                animateGraph(fromChange: true)
                
            }
        }
    }
    
    @ViewBuilder
    func AnimatedChart()->some View{
        
        let max = sampleAnalytics.max { item1, item2 in
            return item2.views > item1.views
        }?.views ?? 0
        
        Chart{
            ForEach(sampleAnalytics){ item in
                
                if isLineGraph{
                    LineMark(x: .value("Hour",item.hour,unit: .hour),
                            y: .value("Views",item.animate ? item.views : 0)
                    )
                    .foregroundStyle(Color("Blue").gradient)
                    .interpolationMethod(.catmullRom)
                }
                else{
                    BarMark(x: .value("Hour",item.hour,unit: .hour),
                            y: .value("Views",item.animate ? item.views : 0)
                    )
                    .foregroundStyle(Color("Blue").gradient)
                }
                if isLineGraph{
                    AreaMark(x: .value("Hour",item.hour,unit: .hour),
                            y: .value("Views",item.animate ? item.views : 0)
                    )
                    .foregroundStyle(Color("Blue").opacity(0.1).gradient)
                    .interpolationMethod(.catmullRom)
                }
                
                if let currentActiveitem,currentActiveitem.id == item.id{
                    RuleMark(x: .value("Hour", currentActiveitem.hour))
                        .lineStyle(.init(lineWidth: 2,miterLimit: 2,dash: [2],dashPhase: 5))
                        .offset(x: (plotWidth / CGFloat(sampleAnalytics.count)) / 2)
                        .annotation(position: .top){
                            VStack(alignment: .leading,spacing: 6){
                                Text("Views")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text(currentActiveitem.views.stringFormat)
                                    .font(.title3.bold())
                            }
                            .padding(.horizontal,10)
                            .padding(.vertical,4)
                            .background{
                                RoundedRectangle(cornerRadius: 6,style: .continuous)
                                    .fill(.white.shadow(.drop(radius: 2)))
                            }
                        }
                }
            }
            
        }
        .chartYScale(domain: 0...(max + 5000))
        .chartOverlay(content: { proxy in
            
            GeometryReader{innerProxy in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                    DragGesture()
                        .onChanged{value in
                            
                            let location = value.location
                            
                            if let date: Date = proxy.value(atX: location.x){
                                
                                let calendar = Calendar.current
                                let hour = calendar.component(.hour, from: date)
                                if let currentItem = sampleAnalytics.first(where:{ item in
                                    calendar.component(.day, from: item.hour) == hour
                                }){
                                    self.currentActiveitem = currentItem
                                    self.plotWidth = proxy.plotAreaSize.width
                                }
                                
                            }
                        }.onEnded{value in
                            self.currentActiveitem = nil
                        }
                    )
                
            }
            
        })
        .frame(height: 250)
        .onAppear{
            animateGraph()
        }
        
    }
    
    func animateGraph(fromChange: Bool = false){
        for(index,_) in sampleAnalytics.enumerated(){
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * (fromChange ? 0.03 : 0.05)){
                withAnimation(fromChange ? .easeInOut(duration: 0.8) : .interactiveSpring(response: 0.8,dampingFraction: 0.8,blendDuration: 0.8)){
                    sampleAnalytics[index].animate = true
                }
            }
           
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView()
    }
}


extension Double{
    
    var stringFormat: String{
        
        if self >= 10000 && self < 999999{
            return String(format: "%.1fK",self / 1000).replacingOccurrences(of: "", with: "")
        }
        
        if self > 999999{
            return String(format: "%.1fM",self / 1000000).replacingOccurrences(of: "", with: "")
        }
        
        return String(format: "%.0f",self)
    }
}
