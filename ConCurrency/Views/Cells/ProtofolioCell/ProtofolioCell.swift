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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellViews(currencyName: String, imageURL: String) {
        currencyNameLabel.text = currencyName
        flagImage.roundCorner()
        flagImage.download(from: imageURL)
    }
}
