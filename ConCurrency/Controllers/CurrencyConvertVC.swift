//
//  CurrencyConvertVC.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import UIKit
import iOSDropDown

class CurrencyConvertVC: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak private(set) var amountTextFiled: UITextField!
    @IBOutlet weak private(set) var fromDropDown: DropDown!
    @IBOutlet weak private(set) var toDropDown: DropDown!
    @IBOutlet weak private(set) var resultAmountLabel: CCLabel!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var addToFavoriteButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additiondal setup after loading the view.
//        setViewsLayout()
        
        fromDropDown.roundCorner()
        amountTextFiled.roundCorner()
        convertButton.roundCorner()
        toDropDown.roundCorner()
        addToFavoriteButton.roundCorner()
        addToFavoriteButton.layer.borderWidth = 1
    }
    
//    func setViewsLayout() {
////        fromDropDown.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            amountTextFiled.heightAnchor.constraint(equalToConstant: 48),
////            fromDropDown.heightAnchor.constraint(equalToConstant: 48)
//        ])
//    }

    // MARK: Actions
    
    @IBAction private func convertButtonTapped(_ sender: Any) {
        print("Convert")
    }
    
    @IBAction func addToFavoriteButtonTapped(_ sender: Any) {
        print("go To favorite")
    }
    
}
