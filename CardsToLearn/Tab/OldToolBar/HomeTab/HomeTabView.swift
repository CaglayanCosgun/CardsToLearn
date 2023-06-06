//
//  HomeTab.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 01.06.23.
//

import SwiftUI
import CoreData



struct HomeTabBarView: View {
    @State private var activeTab: Tab = .home
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero
    @EnvironmentObject var viewModel: CardViewModel
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    @EnvironmentObject var quizViewModel: QuizViewModel
    @EnvironmentObject var quotesViewModel: ApiQuotesViewModel
    
    @State var isPresentingCardCreateView = false
    @State var selectedCard: Card?
    @State var selectedCategory: String?

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                LearningTipsView()
                    .tag(Tab.home)
                    .toolbar(.hidden, for: .tabBar)
                    

                QuotesView()
                    .environmentObject(quotesViewModel)
                    .tag(Tab.quotes)
                    .toolbar(.hidden, for: .tabBar)

                VStack {
                    Picker("Select category", selection: $selectedCategory) {
                        Text("All categories")
                        ForEach(viewModel.categories.sorted(), id: \.self) { category in
                            Text(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal)

                    CardListView(selectedCard: $selectedCard, viewModel: viewModel)
                }
                .navigationBarTitle("Flashcards")
                .tag(Tab.cards)

                QuizSelectionView(flashcards: viewModel.cards)
                    .tag(Tab.quiz)

                ProfileView()
                    .tag(Tab.profile)
            }
            CustomTabBar()
        }
    }

    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color("Blue"), _ inactiveTint: Color = .blue) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: tab,
                    animation: animation,
                    activeTab: $activeTab,
                    position: $tabShapePosition
                )
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(
            content: {
                TabShape(midpoint: tabShapePosition.x)
                    .fill(.white)
                    .ignoresSafeArea()
                    .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
                    .blur(radius: 2)
                    .padding(.top, 25)
            }
        )
        .animation(
            .interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7),
            value: activeTab
        )
    }
}



struct TabItem: View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab
    @Binding var position: CGPoint
    @State private var tabPosition: CGPoint = .zero

    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .white : inactiveTint)
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
                .background {
                    if activeTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }

            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activeTab == tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion: { rect in
            tabPosition.x = rect.midX

            if activeTab == tab {
                position.x = rect.midX
            }
        })
        .onTapGesture {
            activeTab = tab

            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                position.x = tabPosition.x
            }
        }
    }
}

struct TabShape: Shape {
    var midpoint: CGFloat

    var animatableData: CGFloat {
        get { midpoint }
        set {
            midpoint = newValue
        }
    }

    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.addPath(Rectangle().path(in: rect))

            path.move(to: .init(x: midpoint - 60, y: 0))

            let to = CGPoint(x: midpoint, y: -25)
            let control1 = CGPoint(x: midpoint - 25, y: 0)
            let control2 = CGPoint(x: midpoint - 25, y: -25)

            path.addCurve(to: to, control1: control1, control2: control2)

            let to1 = CGPoint(x: midpoint + 60, y: 0)
            let control3 = CGPoint(x: midpoint + 25, y: 0)
            let control4 = CGPoint(x: midpoint + 25, y: -25)

            path.addCurve(to: to1, control1: control3, control2: control4)
        }
    }
}

struct PositionKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func viewPosition(completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader { geometry in
                    let rect = geometry.frame(in: .global)

                    Color.clear
                        .preference(key: PositionKey.self, value: rect)
                        .onPreferenceChange(PositionKey.self, perform: completion)
                }
            }
    }
}


