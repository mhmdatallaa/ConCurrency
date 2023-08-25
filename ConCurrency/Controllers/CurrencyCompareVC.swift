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
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var fromDropDown: DropDown!
    @IBOutlet weak var targeted1DropDown: DropDown!
    @IBOutlet weak var targeted1Label: UILabel!
    
    @IBOutlet weak var targeted2DropDown: DropDown!
    @IBOutlet weak var targeted2Label: UILabel!
    
    @IBOutlet weak var compareButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        amountTextField.roundCorner()
        fromDropDown.roundCorner()
        targeted1DropDown.roundCorner()
        targeted2DropDown.roundCorner()
        compareButton.roundCorner()
    }
    
    
    // MARK: Actions

    @IBAction func compareButtonTapped(_ sender: Any) {
        print("compare")
    }
    
    
}
