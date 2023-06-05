//
//  ToolSideView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 03.06.23.
//

import SwiftUI

struct ToolSideView: View {
    @EnvironmentObject var viewModel: CardViewModel
    @State var selectedCard: Card?
    
    @State var tools: [Tool] = [
        .init(icon: "house", name: "Home", color: .gray),
        .init(icon: "quote.bubble", name: "Quotes", color: .gray),
        .init(icon: "square.grid.2x2", name: "Cards", color: .gray),
        .init(icon: "person.crop.circle", name: "Profile", color: .gray)
    ]
    
    @State var activeTool: Tool?
    @State var startedToolPosition: CGRect = .zero
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 12) {
                ForEach($tools) { $tool in
                    ToolView(tool: $tool)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(
                        Color.white
                            .shadow(.drop(color: .black.opacity(0.1), radius: 5, x: 5, y: 5))
                            .shadow(.drop(color: .black.opacity(0.05), radius: 5, x: -5, y: -5))
                    )
                    .frame(width: 65)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .coordinateSpace(name: "AREA")
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        guard let firstTool = tools.first else { return }
                        if startedToolPosition == .zero {
                            startedToolPosition = firstTool.toolPosition
                        }
                        let location = CGPoint(x: startedToolPosition.midX, y: value.location.y)
                        
                        if let index = tools.firstIndex(where: { tool in
                            tool.toolPosition.contains(location)
                        }), activeTool?.id != tools[index].id {
                            withAnimation(.interpolatingSpring(stiffness: 230, damping: 22)) {
                                activeTool = tools[index]
                            }
                            
                            // Wechsel zur entsprechenden Ansicht basierend auf dem ausgewählten Werkzeug
                            switch tools[index].name {
                            case "Home":
                                HomeTabBarView()
                                
                            case "Quotes":
                                QuotesView()
                                
                            case "Cards":
                                CardListView(selectedCard: $selectedCard, viewModel: viewModel)
                                
                            case "Profile":
                                ProfileView()
                                
                            default:
                                break
                            }
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 1, blendDuration: 1)) {
                            activeTool = nil
                            startedToolPosition = .zero
                        }
                    }
            )
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    @ViewBuilder
    func ToolView(tool: Binding<Tool>) -> some View {
        HStack(spacing: 5) {
            Image(systemName: tool.wrappedValue.icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 45, height: 45)
                .padding(.leading, activeTool?.id == tool.wrappedValue.id ? 5 : 0)
                .background {
                    GeometryReader { proxy in
                        let frame = proxy.frame(in: .named("AREA"))
                        Color.clear
                            .preference(key: RectKey.self, value: frame)
                            .onPreferenceChange(RectKey.self) { rect in
                                tool.wrappedValue.toolPosition = rect
                            }
                    }
                }
            
            if activeTool?.id == tool.wrappedValue.id {
                Text(tool.wrappedValue.name)
                    .padding(.trailing, 15)
                    .foregroundColor(.white)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(tool.wrappedValue.color)
        }
        .offset(x: activeTool?.id == tool.wrappedValue.id ? 60 : 0)
    }
}

struct RectKey: PreferenceKey {
    typealias Value = CGRect
    
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct ToolSideView_Previews: PreviewProvider {
    static var previews: some View {
        ToolSideView()
    }
}


