//
//  ViewController.swift
//  networking part
//
//  Created by Вова on 27.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var recipeImageView: UIImageView!

    @IBOutlet weak var processLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func reloadPressed(_ sender: UIButton) {
        fetchData()
    }
    
    private func fetchData() {
        APICaller.shared.getPopularRecipes { results in
            switch results {
            case .success(let recipes) : self.updateUI(with: recipes); print(recipes[0].extendedIngredients)
            case .failure(let error): print (error)
        }
            
        }
    }
    
    func updateUI (with recipes: ([Recipe])) {
        DispatchQueue.main.async { [self] in
            if let name = recipes[0].title {
                nameLabel.text = "Recipe name: \(name)"
            }
            if let likes = recipes[0].aggregateLikes {
                likesLabel.text = "Likes: \(likes)"
            }
//            if let descr = recipes[0].
            
            if let imageURL = recipes[0].image {
                APICaller.shared.downloadImage(from: imageURL) { result in
                    switch result {
                    case .success(let imageData):
                        DispatchQueue.main.async {
                            self.recipeImageView.image = UIImage(data: imageData)
                        }
                    case .failure(let error): print(error)
                }
                }
            }
            
        }
    }

}

