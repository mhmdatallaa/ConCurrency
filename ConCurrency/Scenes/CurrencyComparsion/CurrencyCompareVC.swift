//
//  CurrencyCompareVC.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import UIKit
import iOSDropDown

class CurrencyCompareVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private(set) var amountTextField: UITextField!
    @IBOutlet weak private(set) var sourceDropDown: DropDown!
    @IBOutlet weak private(set) var targeted1DropDown: DropDown!
    @IBOutlet weak private(set) var targeted1Label: UILabel!
    @IBOutlet weak private(set) var targeted2DropDown: DropDown!
    @IBOutlet weak private(set) var targeted2Label: UILabel!
    @IBOutlet weak private(set) var compareButton: UIButton!
    
    // MARK: - Properties
    
    lazy var presenter = CurrencyComparePresenter(view: self)
    private var allCurrencies: [Currency] = []
    private var sourceCurrency = "USD"
    private var target1Currency = "USD"
    private var target2Currency = "USD"
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.delegate = self
        configureViewsApperance()
        presenter.fetchAllCurrencies()
    }
    
    // MARK: - Configs
    
    private func configureViewsApperance() {
        amountTextField.roundCorner()
        sourceDropDown.roundCorner()
        targeted1DropDown.roundCorner()
        targeted2DropDown.roundCorner()
        compareButton.roundCorner()
    }
    
    private func configrueDropDown() {
        configureSourceDropDown()
        configuretarget1DropDown()
        configureTarget2DropDown()
    }
    
    private func configureSourceDropDown() {
        let emojis: [String] = allCurrencies.map { $0.currencyCode.intoEmoji() + " \($0.currencyCode)" }
        sourceDropDown.optionArray = emojis
        sourceDropDown.selectedIndex = 0
        sourceDropDown.didSelect{ [weak self] (selectedText , index ,_) in
            guard let self else { return }
            let selectedCurrency = self.allCurrencies[index].currencyCode
            self.sourceCurrency = selectedCurrency
        }
    }
    
    private func configuretarget1DropDown() {
        let emojis: [String] = allCurrencies.map { $0.currencyCode.intoEmoji() + " \($0.currencyCode)" }
        targeted1DropDown.optionArray = emojis
        targeted1DropDown.selectedIndex = 0
        targeted1DropDown.didSelect{ [weak self](selectedText , index ,_) in
            guard let self else { return }
            let selectedCurrency = self.allCurrencies[index].currencyCode
            self.target1Currency = selectedCurrency
        }
    }
    
    private func configureTarget2DropDown() {
        let emojis: [String] = allCurrencies.map { $0.currencyCode.intoEmoji() + " \($0.currencyCode)" }
        targeted2DropDown.optionArray = emojis
        targeted2DropDown.selectedIndex = 0
        targeted2DropDown.didSelect{ [weak self] (selectedText , index ,_) in
            guard let self else { return }
            print(selectedText, index)
            let selectedCurrency = self.allCurrencies[index].currencyCode
            self.target2Currency = selectedCurrency
        }
    }
    
    // MARK: - Actions

    @IBAction private func compareButtonTapped(_ sender: Any) {
        print("compare")
        // TODO: Handle empty text state & Dounle conversion
        let amount = amountTextField.text!
        presenter.compare(baseCurrency: sourceCurrency, firstTarget: target1Currency, secondTarget: target2Currency, amount: Double(amount)!)
    }
}

// MARK: - CurrencyCompareViewProtocol Extension

extension CurrencyCompareVC: CurrencyCompareViewProtocol {
    func updateResult(target1: String, target2: String) {
        targeted1Label.text = target1
        targeted2Label.text = target2
    }
    
    func getAllCurrencies(_ currencies: [Currency]) {
        allCurrencies = currencies
        configrueDropDown()
    }
}

// MARK: - UITextFieldDelegate Extension

extension CurrencyCompareVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentLocal = Locale.current
        let decimalSeperator = currentLocal.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeperator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeperator)
        
        if existingTextHasDecimalSeparator != nil,
           replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
    
}

