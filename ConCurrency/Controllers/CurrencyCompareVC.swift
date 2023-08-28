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
    
    var compareService: CompareCurrecnyServicing!
    var allCurrencies = [Currency]()
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewsApperance()
        fetchAllCurrencies()
    }
    
    private func configureViewsApperance() {
        amountTextField.roundCorner()
        fromDropDown.roundCorner()
        targeted1DropDown.roundCorner()
        targeted2DropDown.roundCorner()
        compareButton.roundCorner()
    }
    
    private func fetchAllCurrencies() {
        NetworkingManager.shared.fetchAllCurrencies { result in
            switch result {
            case .success(let currencies):
                self.allCurrencies = currencies.data
                self.configrueDropDown()
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
            }
        }
    }
    
    private func compare(baseCurrency: String, firstTarget: String, secondTarget: String, amount: Double) {
        NetworkingManager.shared.fetchCompareCurrency(baseCurrency: baseCurrency, firstTarget: firstTarget, secondTarget: secondTarget, amount: amount) { result in
            switch result {
            case .success(let response):
                self.targeted1Label.text = "\(response.data.conversionRates.firstTargetRate)"
                self.targeted2Label.text = "\(response.data.conversionRates.secondTargetRate)"
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
            }
        }
    }
    private func configrueDropDown() {
        let emojis: [String] = allCurrencies.map { $0.currencyCode.intoEmoji() + " \($0.currencyCode)" }
        let dropDowns: [DropDown] = [fromDropDown, targeted1DropDown, targeted2DropDown]
        for dropDown in dropDowns {
            dropDown.optionArray = emojis
    //        toDropDown.selectedIndex = 1
            dropDown.didSelect{(selectedText , index ,id) in
                print(selectedText, index)
            }
        }
    }
    
    // MARK: Actions

    @IBAction private func compareButtonTapped(_ sender: Any) {
        print("compare")
        compare(baseCurrency: "AED", firstTarget: "EGP", secondTarget: "USD", amount: 200.5)
    }
    
    
}

