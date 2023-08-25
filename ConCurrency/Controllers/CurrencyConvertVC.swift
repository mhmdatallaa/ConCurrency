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
    @IBOutlet weak private(set) var convertButton: UIButton!
    @IBOutlet weak private(set) var addToFavoriteButton: UIButton!
    @IBOutlet weak private(set) var tableView: UITableView!
    
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewsApperance()
    }
    
    // MARK: Methods
    
    private func configureViewsApperance() {
        fromDropDown.roundCorner()
        amountTextFiled.roundCorner()
        convertButton.roundCorner()
        toDropDown.roundCorner()
        addToFavoriteButton.roundCorner()
        addToFavoriteButton.layer.borderWidth = 1
    }

    // MARK: Actions
    
    @IBAction private func convertButtonTapped(_ sender: Any) {
        print("Convert")
    }
    
    @IBAction private func addToFavoriteButtonTapped(_ sender: Any) {
        print("go To favorite")
    }
    
}

// MARK: - Extensions
