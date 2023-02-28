//
//  APICaller.swift                             09713914275c4aa2bd64c3ae7d7293c9 icloud
//  networking part                             7e31fd338a334d03aafda200f55348c0 yandex
//
//  Created by Вова on 27.02.2023.
//

import Foundation
import UIKit


struct Constants {
    
    static let APIKey = "7e31fd338a334d03aafda200f55348c0"
    static let basicURL = "https://api.spoonacular.com/recipes/"
    
    static func exactURL(with id: Int) -> String {
        return "\(basicURL)\(id)/information?apiKey=\(APIKey)"
    }
    
    static let popularRecipesURL = "\(basicURL)complexSearch?sort=popularity&number=10&apiKey=\(APIKey)"
    
    static let randomURL = "\(basicURL)random?apiKey=\(APIKey)"
    
}

class APICaller {
    static let shared = APICaller()
    
    func getDetailedRecipe (completion: @escaping (Result<DeatiledRecipe, Error>) -> Void) {

      guard let url = URL(string: Constants.exactURL(with: 715467)) else {return}
        print (url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, responce, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(DeatiledRecipe.self, from: data)
                completion(.success(results))

            } catch {
                completion(.failure(error))
                print ("potracheno")
            }
        }
        task.resume()
    }
    
    func getSortedRecipes (completion: @escaping (Result<[Recipe], Error>) -> Void) {
        
        guard let url = URL(string: Constants.popularRecipesURL) else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, responce, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(SortedRecipes.self, from: data)
                completion(.success(results.recipes)
            } catch {
                completion(.failure(error))
                print ("potracheno")
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String,completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}

                completion(.success(data))

            
        }
        task.resume()
    }
}

