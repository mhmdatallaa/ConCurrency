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
        
        print("Compare")
        
        #warning("To remove")
        let client = URLSessionClient()
        let service = CurrencyExchangeRateService(client: client)
        service.fetchCurrencyExchangeRate(baseCurrency: "ABC"){ result in
            switch result {
            case .success(let response):
                LoggerManager.info(message: "\(response)")
            case .failure(let error):
                LoggerManager.error(message: "\(error.localizedDescription)")
            }
        }

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
                self.configureFromDropDown()
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
    
    private func configureFromDropDown() {
//        fromDropDown.optionArray = allCurrencies.map {$0.currencyCode}
        //Its Id Values and its optional
//        fromDropDown.optionIds = [1,23,54,22]

        // Image Array its optional
        let emojis: [String] = allCurrencies.map {
            let code = $0.currencyCode.dropLast()
            let base: UInt32 = 127397
            var emoji = ""
            for scalar in code.unicodeScalars {
                emoji.append(String(UnicodeScalar(base + scalar.value)!))
            }
            let text = emoji + " \($0.currencyCode)"
            let s = UIFont(name: "", size: 20)
            return text
        }
        fromDropDown.optionArray = emojis

//        print(emojis)
//        fromDropDown.optionImageArray = emojis
        
        // The the Closure returns Selected Index and String
        fromDropDown.didSelect{(selectedText , index ,id) in
            print(selectedText, index)
//        self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
        }
    }

    
    
    // MARK: Actions

    @IBAction private func compareButtonTapped(_ sender: Any) {
        print("compare")
        compare(baseCurrency: "", firstTarget: "", secondTarget: "", amount: 200.5)
    }
    
    
}
