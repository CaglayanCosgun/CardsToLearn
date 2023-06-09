//
//  LastCardView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 09.06.23.
//

import SwiftUI
import CoreData

//struct LastCardView: View {
//    @EnvironmentObject var cardVM: CardViewModel
//    let card: Card
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            HStack {
//                Button {
//                    // Handle left button action
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .font(.body.bold())
//                        .foregroundColor(.white)
//                        .frame(width: 40, height: 40)
//                        .background(
//                            RoundedRectangle(cornerRadius: 10)
//                                .strokeBorder(Color.white.opacity(0.6), lineWidth: 1)
//                        )
//                }
//                
//                Spacer()
//                
//                Button {
//                    // Handle skip button action
//                } label: {
//                    Text("Skip")
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                }
//                
//            }
//            .overlay(
//                HStack(spacing: 4) {
//                    // Add overlay content here if needed
//                }
//                
//            )
//            .padding()
//            
//            ScrollView(getRectLast().height < 750 ? .vertical : .init(), showsIndicators: false) {
//                VStack(spacing: 20) {
//                    Text(card.category ?? "")
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.white.opacity(0.6))
//                        .padding(.top, 20)
//                    
//                    Text("Your last \ncreated Card")
//                        .font(.system(size: 38, weight: .bold))
//                        .multilineTextAlignment(.center)
//                        .lineLimit(3)
//                        .foregroundColor(.white)
//                    
//                    if let lastCreatedCard = cardVM.cards.last {
//                        InfiniteCarouselView(card: lastCreatedCard)
//                    }
//                }
//                .padding()
//                .frame(maxWidth: .infinity, alignment: .center)
//                
//            }
//            
//            HStack {
//                Text("Flash Card")
//                    .font(.title3.bold())
//                    .foregroundColor(.white)
//                
//                Spacer()
//                
//                Button {
//                    // Handle right button action
//                } label: {
//                    Image(systemName: "chevron.right")
//                        .font(.body.bold())
//                        .foregroundColor(.white)
//                        .frame(width: 40, height: 40)
//                        .background(
//                            RoundedRectangle(cornerRadius: 10)
//                                .strokeBorder(Color.white.opacity(0.3), lineWidth: 1)
//                        )
//                }
//            }
//            .padding(.top, 25)
//            .padding(.horizontal, 30)
//            .padding(.bottom, 12)
//            .background(
//                Color.black
//                    .clipShape(CustomCornerLast(corners: [.topLeft, .topRight], radius: 38))
//                    .ignoresSafeArea()
//            )
//            
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(
//            LinearGradient(colors: [
//                Color("gray3"),
//                Color("gray2"),
//                Color("gray1"),
//            ], startPoint: .top, endPoint: .bottom)
//            .ignoresSafeArea()
//        )
//    }
//}
//
//
//
//struct CustomCornerLast: Shape{
//    
//    var corners: UIRectCorner
//    var radius: CGFloat
//    
//    func path(in rect: CGRect) -> Path {
//        
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        
//        return Path(path.cgPath)
//    }
//}
//
//extension View{
//    
//    func getRectLast()->CGRect{
//        return UIScreen.main.bounds
//    }
//}
//
//struct InfiniteCarouselView: View{
//    
//    let card: Card
//    
//    var body: some View{
//        
//        VStack(spacing: 18){
//            
//            Spacer()
//            
//            Text(card.question ?? "")
//                .font(.title3.bold())
//                .foregroundColor(.gray)
//                .multilineTextAlignment(.center)
//            
//            Text(card.answer ?? "")
//                .font(.title3.bold())
//                .foregroundColor(.gray)
//                .multilineTextAlignment(.center)
//            
//            Spacer()
//            
//            Image(systemName: "checkmark.circle")
//                .font(.system(size: 75,weight: .light))
//                .foregroundColor(.green)
//                .padding(.bottom)
//            
//            Spacer()
//            
//        }
//        .padding(.horizontal,20)
//        .frame(maxWidth: .infinity,maxHeight: .infinity)
//        .background(Color.white)
//        .cornerRadius(30)
//        .padding(.horizontal,50)
//    }
//}
