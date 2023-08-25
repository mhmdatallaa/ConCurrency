//
//  CurrencyCompareVC.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import UIKit
import iOSDropDown

class CurrencyCompareVC: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private(set) var amountTextField: UITextField!
    @IBOutlet weak private(set) var fromDropDown: DropDown!
    @IBOutlet weak private(set) var targeted1DropDown: DropDown!
    @IBOutlet weak private(set) var targeted1Label: UILabel!
    @IBOutlet weak private(set) var targeted2DropDown: DropDown!
    @IBOutlet weak private(set) var targeted2Label: UILabel!
    @IBOutlet weak private(set) var compareButton: UIButton!
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewsApperance()
    }
    
    private func configureViewsApperance() {
        amountTextField.roundCorner()
        fromDropDown.roundCorner()
        targeted1DropDown.roundCorner()
        targeted2DropDown.roundCorner()
        compareButton.roundCorner()
    }
    
    
    // MARK: Actions

    @IBAction private func compareButtonTapped(_ sender: Any) {
        print("compare")
    }
    
    
}
