//
//  FavoriteCell.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 26/08/2023.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    @IBOutlet weak private(set) var favoriteFlagImage: UIImageView!
    @IBOutlet weak private(set) var currencyCodeLabel: UILabel!
//    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var checkMarkImage: UIImageView!
    
    var image: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setImage(for currency: String) {
        checkMarkImage.image = UIImage(systemName: currency)
    }
    func configureCellViews(name: String, imageURL: String) {
        currencyCodeLabel.text = name
        favoriteFlagImage.roundCorner()
        favoriteFlagImage.download(from: imageURL)
    }
    
}
