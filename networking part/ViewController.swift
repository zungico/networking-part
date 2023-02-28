//
//  ViewController.swift
//  networking part
//
//  Created by Вова on 27.02.2023.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var processLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func reloadPressed(_ sender: UIButton) {
        fetchData()
    }
    
    private func fetchData() {
        APICaller.shared.getExactRecipe { results in
            switch results {
            case .success(let recipe) : self.updateUI(with: recipe); print(recipe.extendedIngredients)
            case .failure(let error): print (error)
            }
        }

    }
    
    func updateUI (with recipe: (Recipe)) {
        DispatchQueue.main.async { [self] in
            if let name = recipe.title {
                nameLabel.text = "Recipe name: \(name)"
            }
            if let likes = recipe.aggregateLikes {
                likesLabel.text = "Likes: \(likes)"
            }
            if let descr = recipe.summary {
                guard let safeDescription = convertHTML(from: descr) else {return}
                descriptionLabel.text = safeDescription.string
            }
            if let process = recipe.instructions {
                guard let safeProcess = convertHTML(from: process) else {return}
                processLabel.text = safeProcess.string
                        
            }
            
            if let imageURL = recipe.image {
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
    func convertHTML (from string: String) -> NSAttributedString?{
        do{
            let atrString = try NSAttributedString(data: string.data(using: .utf8) ?? .init(), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            return atrString
        }catch{
            print("Could not convert!")
            return nil
        }
    }
}
