//
//  ProtofolioCell.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 26/08/2023.
//

import UIKit

class ProtofolioCell: UITableViewCell {

    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var exchangeRateLabel: UILabel!
    @IBOutlet weak var currencySubLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCellViews(currencyCode: String, currencyName: String, imageURL: String) {
        currencyNameLabel.text = currencyCode
        currencySubLabel.text = currencyName
        flagImage.roundCorner()
        flagImage.download(from: imageURL)
    }
}
