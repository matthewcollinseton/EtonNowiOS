//
//  ApiManager.swift
//  EtonNowiOS
//
//  Created by Collins, Matthew - MC on 22/02/2024.
//

import Foundation

class ApiManager: ObservableObject {
    static let shared = ApiManager()
    
    private init() {}
    
    private let baseURL = "http://localhost:3000/api/matches?depth=2"
    
    func getMatches(completion: @escaping ([Match]) -> Void) {
        guard let url = URL(string: "\(baseURL)") else {
            print("Invalid URL")
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error getting item: \(error.localizedDescription)")
                completion([])
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            guard let data = data, let matches = try? decoder.decode(MatchesApiResponse.self, from: data) else {
                print("Error decoding item")
                return
            }
            completion(matches.docs)
        }
        task.resume()
    }
}
