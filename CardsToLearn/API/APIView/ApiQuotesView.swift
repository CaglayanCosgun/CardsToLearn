//
//  ApiQuotesView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 08.06.23.
//

import SwiftUI

struct ApiQuotesView: View {
    
    let categories = [
        "age", "alone", "amazing", "anger", "architecture", "art", "attitude", "beauty", "best",
        "birthday", "business", "car", "change", "communications", "computers", "cool", "courage",
        "dad", "dating", "death", "design", "dreams", "education", "environmental", "equality",
        "experience", "failure", "faith", "family", "famous", "fear", "fitness", "food", "forgiveness",
        "freedom", "friendship", "funny", "future", "god", "good", "government", "graduation", "great",
        "happiness", "health", "history", "home", "hope", "humor", "imagination", "inspirational",
        "intelligence", "jealousy", "knowledge", "leadership", "learning", "legal", "life", "love",
        "marriage", "medical", "men", "mom", "money", "morning", "movies", "success"
    ]
    
    @EnvironmentObject var quotesVM: ApiQuotesViewModel
    @State private var searchCategory: String = ""
    @State private var showMenu: Bool = false
    @State private var textOffset: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        VStack{
            
            VStack{
                
                HStack{
                    
                    Spacer()
                    
                    Button{
                        
                        
                    }label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.primary)
                        
                    }
                }
                .padding()
                
                HStack{
                    
                    (
                    
                        Text("My ")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        +
                        
                        Text("Quotes")
                            .foregroundColor(.gray)
                    
                    )
                    .font(.largeTitle)
                    
                    Spacer()
                    
                }
                .padding()
                
                HStack(spacing: 15){
                    
                    Button{
                        quotesVM.fetchQuote(category: searchCategory)
                    }label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 23,weight: .bold))
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $searchCategory)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.primary.opacity(0.05))
                    .cornerRadius(8)
                    .padding()
                    
                    }
                
                HStack{
                    
                    Text("RECENTS")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.6))
                        .frame(height: 0.5)

                }
                .padding()
            }
            
            ScrollView(.vertical,showsIndicators: false){
                
                VStack(spacing: 15){
                    
                    if !quotesVM.quotes.isEmpty {
                        ScrollView {
                            LazyVStack(spacing: 8) {
                                ForEach(quotesVM.quotes, id: \.self) { quote in
                                    VStack(spacing: 8) {
                                        
                                        Text("Category: \(quote.category)")
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.black)
                                        
                                        Text(quote.quote)
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.black)
                                        
                                        Text("- \(quote.author)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .fontWeight(.medium)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color: .gray, radius: 3, x: 0, y: 2)
                                }
                            }
                            .padding(.horizontal)
                        }
                    } else {
                        Text("Quotes not available")
                            .font(.body)
                            .foregroundColor(.red)
                    }
                    
                }
                
            }
        }
        .onAppear {
            quotesVM.fetchQuote(category: "happiness")
        }
    }
}

struct ApiQuotesView_Previews: PreviewProvider {
    static var previews: some View {
        ApiQuotesView()
    }
}
