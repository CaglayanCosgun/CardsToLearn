//
//  APIClient.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 22.05.23.
//

import SwiftUI
import Foundation

class ApiCallViewModel: ObservableObject {
    
    @Published var quizzes: [ApiQuestions] = []
    @Published var selectedOption: Options?
    
    func fetchQuiz() {
        let headers = [
            "X-RapidAPI-Key": "f162300bbdmsha1477194188de25p1467c9jsnef8c389df48f",
            "X-RapidAPI-Host": "ases-quiz-api1.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://ases-quiz-api1.p.rapidapi.com/questions/random/20")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("Fehler bei der Datenanfrage: \(error)")
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(ApiResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.quizzes = response.questions
                    }
                } catch {
                    print("Fehler beim Analysieren der Daten: \(error)")
                }
            } else {
                print("Leere Daten erhalten.")
            }
        })
        dataTask.resume()
    }
}
