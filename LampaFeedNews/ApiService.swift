//
//  ApiService.swift
//  LampaFeedNews
//
//  Created by Tarasenko Jurik on 07.06.2018.
//  Copyright © 2018 Tarasenko Jurik. All rights reserved.
//

import UIKit

final class ApiService {
    
    static let sharedInstance = ApiService()
    private init() {}
    
    func fetchRequest(urlString: String, complition: @escaping ([Film]?, Error?) -> () ) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else { complition(nil, error); return }
            guard let unwrappedData = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers)
                
                DispatchQueue.main.async {
                    complition(self.setValue(json), error)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
    private func setValue(_ json: Any?) -> [Film] {
        
        var films = [Film]()
        
        if let dataContents = json as? [String: AnyObject],
            let clearData = dataContents["results"] as? [[String: AnyObject]] {
            
            for dataDictionary in clearData  {
                
                var film = Film()
                film.title = dataDictionary["title"] as? String
                film.vote = dataDictionary["vote_average"] as? Double
                film.voteCount = dataDictionary["vote_count"] as? Int
                film.image = dataDictionary["poster_path"] as? String
                film.language = dataDictionary["original_language"] as? String
                film.overview = dataDictionary["overview"] as? String
                film.release = dataDictionary["release_date"] as? String
                
                films.append(film)
            }
        }
        return films
    }
}








