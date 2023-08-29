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
    @IBOutlet weak var checkMarkImage: UIImageView!
    @IBOutlet weak var currencyNameLabel: UILabel!
    
    var image: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImage(for currency: String) {
        checkMarkImage.image = UIImage(systemName: currency)
    }
    func configureCellViews(currencyCode: String, currencyName: String, imageURL: String) {
        currencyCodeLabel.text = currencyCode
        currencyNameLabel.text = currencyName
        favoriteFlagImage.roundCorner()
        favoriteFlagImage.download(from: imageURL)
    }
    
}
