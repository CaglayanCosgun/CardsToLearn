//
//  WordApi.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 25.05.23.
//

import SwiftUI

class ApiWordViewModel: ObservableObject {
    @Published var words: ApiWordResponse?
    @Published var lastWord: String = "code"
    
    func fetchWord(word: String) {
        let encodedWord = word.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "https://api.api-ninjas.com/v1/dictionary?word=" + encodedWord)!
        var request = URLRequest(url: url)
        request.setValue("TA18tTouvZGeM0tZpCXG0w==7dShQUX3vvAl7dI3", forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.words = nil
                }
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode(ApiWordResponse.self, from: data) {
                DispatchQueue.main.async {
                    self?.words = decodedResponse
                }
            } else {
                DispatchQueue.main.async {
                    self?.words = nil
                }
            }
            if let responseString = String(data: data, encoding: .utf8) {
                print(responseString)
            } else {
                DispatchQueue.main.async {
                    self?.words = nil
                    print("Decoding failed")
                }
            }
        }
        task.resume()
    }
}

