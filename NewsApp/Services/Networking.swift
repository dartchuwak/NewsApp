//
//  Networking.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 24.02.2023.
//

import Foundation

final class NetworkManager {
    
    static var shared = NetworkManager()
    
    func fetchNewsData(completion: @escaping ([Article]) -> ()) {
        let urlString = "https://newsapi.org/v2/everything?q=keyword&apiKey=c70c643125554893aeecc898703e50a1"
        guard let url = URL(string: urlString) else { return }
        
        // getting data with URLSassion
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка получения данных: \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            
            do {
                // decoding JSON
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                let articles = newsResponse.articles
                completion(articles)
                
            } catch let error {
                print("Ошибка парсинга данных: \(error.localizedDescription)")
            }
        }.resume()
    }
}
