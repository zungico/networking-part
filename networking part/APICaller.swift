//
//  APICaller.swift
//  networking part
//
//  Created by Вова on 27.02.2023.
//

import Foundation
import UIKit


struct Constants {
    static let APIKey = ["09713914275c4aa2bd64c3ae7d7293c9", // icloud
                         "7e31fd338a334d03aafda200f55348c0"] // yandex
    static let popularityURL = "https://api.spoonacular.com/recipes/complexSearch?sort=popularity&number=10&apiKey=7e31fd338a334d03aafda200f55348c0"
    
    static let basicURL = "https://api.spoonacular.com/recipes/"
    
}

class APICaller {
    static let shared = APICaller()
    
    func getPopularRecipes (completion: @escaping (Result<[Recipe], Error>) -> Void) {
        guard let url = URL(string: Constants.basicURL+"random"+"?apiKey="+Constants.APIKey[1]) else {return}
        
        print (url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, responce, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(popularRecipeResponce.self, from: data)
                completion(.success(results.recipes))

            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getDetailedRecipe (completion: @escaping (Result<[Recipe], Error>) -> Void) {
        
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

