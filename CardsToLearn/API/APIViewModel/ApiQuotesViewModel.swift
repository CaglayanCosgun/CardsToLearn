//
//  ApiQuotesViewModel.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 30.05.23.
//

import Foundation

class ApiQuotesViewModel: ObservableObject {

    @Published var quotes: [ApiQuotes] = []
    
    func fetchQuote(category: String) {
        let category = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category=\(category ?? "")")!
        var request = URLRequest(url: url)
        request.setValue("TA18tTouvZGeM0tZpCXG0w==7dShQUX3vvAl7dI3", forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.quotes = []
                }
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode([ApiQuotes].self, from: data) {
                DispatchQueue.main.async {
                    self?.quotes = decodedResponse
                }
            } else {
                DispatchQueue.main.async {
                    self?.quotes = []
                }
            }

            if let responseString = String(data: data, encoding: .utf8) {
                print(responseString)
            } else {
                DispatchQueue.main.async {
                    self?.quotes = []
                    print("Decoding failed")
                }
            }
        }
        task.resume()
    }
}
