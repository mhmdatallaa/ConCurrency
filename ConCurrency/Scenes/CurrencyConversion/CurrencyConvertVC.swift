//
//  CurrencyConvertVC.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import UIKit
import iOSDropDown

class CurrencyConvertVC: UIViewController {
    
    // MARK: - Properties
    
    private var favoriteCurrencies: [Currency] = []
    private var allCurrencies: [Currency] = []
    private var exchangeRates: [ExchageRate] = []
    private var sourceCurrency = "EGP"
    private var targetCurrency = "EGP"
    private let favoriteListVC = FavoriteListVC()
    private lazy var presenter = CurrencyConvertPresenter(view: self)
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private(set) var amountTextFiled: UITextField!
    @IBOutlet weak private(set) var sourceDropDown: DropDown!
    @IBOutlet weak private(set) var targetDropDown: DropDown!
    @IBOutlet weak private(set) var resultAmountLabel: CCLabel!
    @IBOutlet weak private(set) var convertButton: UIButton!
    @IBOutlet weak private(set) var addToFavoriteButton: UIButton!
    @IBOutlet weak private(set) var tableView: UITableView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTextFiled.delegate = self
        configureViewsApperance()
        configureTableView()

        presenter.fetchConversionRates(for: "USD")
//        exchangeRate(for: "USD")
        presenter.fetchAllCurrencies()
        
        presenter.getFavoriteCurrencies()
        
    }
    
    // MARK: - Configs
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProtofolioCell", bundle: nil), forCellReuseIdentifier: "ProtofolioCell")
        tableView.isScrollEnabled = false
    }
    
    private func configureFromDropDown() {
         let emojis: [String] = allCurrencies.map { $0.currencyCode.intoEmoji() + $0.currencyCode }
        sourceDropDown.optionArray = emojis
        sourceDropDown.selectedIndex = 0
        sourceDropDown.didSelect{ [weak self] (selectedText, index, _) in
            guard let self else { return }
            print(selectedText, index)
            let selectedCurrency = self.allCurrencies[index].currencyCode
            self.sourceCurrency = selectedCurrency
            self.presenter.fetchConversionRates(for: selectedCurrency)
        }
    }
    
    private func configureToDropDown() {
        let emojis: [String] = allCurrencies.map { $0.currencyCode.intoEmoji() + $0.currencyCode }
        targetDropDown.optionArray = emojis
        targetDropDown.selectedIndex = 0
        targetDropDown.didSelect{ [weak self] (selectedText, index, id) in
            guard let self else { return }
            print(selectedText, index)
            let selectedCurrency = self.allCurrencies[index].currencyCode
            self.targetCurrency = selectedCurrency
        }
    }

    private func configureViewsApperance() {
        let views: [UIView] = [sourceDropDown, amountTextFiled, convertButton, targetDropDown, addToFavoriteButton]
        for view in views {
            view.roundCorner()
        }
        addToFavoriteButton.layer.borderWidth = 1
    }
    

    // MARK: - Actions
    
    @IBAction private func convertButtonTapped(_ sender: Any) {
        print("Convert")
        // TODO: handle empty textField state
        presenter.convert(amount: amountTextFiled.text!, from: sourceCurrency, to: targetCurrency)
    }
    
    @IBAction private func addToFavoriteButtonTapped(_ sender: Any) {
        print("go To favorite")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FavoriteListVC") as! FavoriteListVC
        vc.presenter.delegate = self
        present(vc, animated: true)
    }
    
}

// MARK: - CurrencyConvertViewProtocol Extension

extension CurrencyConvertVC: CurrencyConvertViewProtocol {
    func updateConversionRate(_ rates: [ExchageRate]) {
        exchangeRates = rates
        presenter.getFavoriteCurrencies()
    }
    
    func updateResult(_ result: String) {
        resultAmountLabel.text = result
    }
    
    func showFavoriteCurrencies(_ currencies: [Currency]) {
        favoriteCurrencies = currencies
        tableView.reloadData()
    }
    
    func getAllCurrencies(_ currencies: [Currency]) {
        allCurrencies = currencies
        configureFromDropDown()
        configureToDropDown()
    }
    
    func showErrorAlert() {
        showAlert(title: "Ooops 😶", message: "Server Error ❌, Please check your internet connection or try again later.")
    }
}

// MARK: - UITableViewDataSource Extension

extension CurrencyConvertVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProtofolioCell") as? ProtofolioCell else {
            LoggerManager.error(message: "Couldn't cast Favorite cell")
            return UITableViewCell()
        }
        let currency = favoriteCurrencies[indexPath.row]
        
        for exchangeRate in exchangeRates {
            if exchangeRate.code == currency.currencyCode {
                cell.exchangeRateLabel.text = "\(exchangeRate.rate)"

            }
        }
        cell.configureCellViews(currencyName: currency.name, imageURL: currency.flagURL)
        return cell
    }
}

// MARK: - UITableViewDelegate Extension

extension CurrencyConvertVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

// MARK: - CurrencyFavoritingDelegate Extension

extension CurrencyConvertVC: CurrencyFavoritingDelegate {
    func favorite(currency: Currency, actionType: ActionType) {
        switch actionType {
        case .add:
            favoriteCurrencies.append(currency)
        case .remove:
            favoriteCurrencies.removeAll {$0.currencyCode == currency.currencyCode}
        }
        tableView.reloadData()
    }
}

// MARK: - UITextFieldDelegate Extension

extension CurrencyConvertVC: UITextFieldDelegate {
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


