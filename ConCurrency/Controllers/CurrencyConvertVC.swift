//
//  CurrencyConvertVC.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import UIKit
import iOSDropDown

class CurrencyConvertVC: UIViewController {
    
    // MARK: Properties
    
    var favoriteCurrencies: [Currency] = []
    var allCurrencies: [Currency] = []
    var conversionRatesCurrencies: [String: Double] = [:]
    var selectedFromCurrency = "USD"
    let favoriteListVC = FavoriteListVC()
    var convertService: ConvertCurrecnyServicing!
    var currencyListService: CurreciesListServicing!
    var exchangeRateService: CurrencyExchangeRateServicing!
    
    // MARK: IBOutlet
    
    @IBOutlet weak private(set) var amountTextFiled: UITextField!
    @IBOutlet weak  var fromDropDown: DropDown!
    @IBOutlet weak private(set) var toDropDown: DropDown!
    @IBOutlet weak private(set) var resultAmountLabel: CCLabel!
    @IBOutlet weak private(set) var convertButton: UIButton!
    @IBOutlet weak private(set) var addToFavoriteButton: UIButton!
    @IBOutlet weak private(set) var tableView: UITableView!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewsApperance()
        configureTableView()

        exchangeRate(for: "USD")
        fetchAllCurrencies()
        
    }
    
    // MARK: Configs
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProtofolioCell", bundle: nil), forCellReuseIdentifier: "ProtofolioCell")
        tableView.isScrollEnabled = false
    }
    
    private func configureFromDropDown() {
        let emojis: [String] = allCurrencies.map { $0.currencyCode.intoEmoji() + " \($0.currencyCode)" }
        fromDropDown.optionArray = emojis
        fromDropDown.selectedIndex = 0
        fromDropDown.didSelect{(selectedText , index ,id) in
            print(selectedText, index)
            let selectedCurrency = self.allCurrencies[index].currencyCode
            self.selectedFromCurrency = selectedCurrency
            self.exchangeRate(for: selectedCurrency)
            print(selectedCurrency)
        }
    }
    
    private func configureToDropDown() {
        let emojis: [String] = allCurrencies.map { $0.currencyCode.intoEmoji() + " \($0.currencyCode)" }
        toDropDown.optionArray = emojis
//        toDropDown.selectedIndex = 1
        toDropDown.didSelect{(selectedText , index ,id) in
            print(selectedText, index)
        }
    }
    
    // MARK: Methods
    
    private func retriverFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let currencies):
                self.favoriteCurrencies = currencies
                self.tableView.reloadData()
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
            }
        }
    }
    
    private func fetchAllCurrencies() {
        NetworkingManager.shared.fetchAllCurrencies { result in
            switch result {
            case .success(let currencies):
                self.allCurrencies = currencies.data
                self.configureFromDropDown()
                self.configureToDropDown()
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
            }
        }
    }
    
 
//
//    private func getFlagEmoji(flag: String) -> String {
//        let code = flag.dropLast()
//        let base: UInt32 = 127397
//        var emoji = ""
//        for scalar in code.unicodeScalars {
//            emoji.append(String(UnicodeScalar(base + scalar.value)!))
//        }
//        print(emoji)
//        return emoji
//    }
    
    private func convert(amount: String, from baseCurrency: String, to targetCurrency: String) {
        NetworkingManager.shared.fetchConvertCurrency(baseCurrency: baseCurrency, targetCurrency: targetCurrency, amount: amount) { result in
            switch result {
            case .success(let response):
                self.resultAmountLabel.text = response.data.conversionResult
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
            }
        }
    }
    
    private func exchangeRate(for currency: String) {
        NetworkingManager.shared.fetchCurrencyExchangeRate(baseCurrency: currency) { result in
               switch result {
               case .success(let response):
                   self.conversionRatesCurrencies = response.data.conversionRates
                   self.retriverFavorites()
               case .failure(let error):
                   LoggerManager.error(message: error.localizedDescription)
               }

        }
    }
    
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
        convert(amount: amountTextFiled.text!, from: "JPY", to: "KWD")
        exchangeRate(for: selectedFromCurrency)

    }
    
    @IBAction private func addToFavoriteButtonTapped(_ sender: Any) {
        print("go To favorite")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FavoriteListVC") as! FavoriteListVC
        vc.presenter.delegate = self
        present(vc, animated: true)
    }
    
}

// MARK: - Extensions

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
        
        if let exchangeRate = conversionRatesCurrencies[currency.currencyCode] {
            print(exchangeRate)
            cell.exchangeRateLabel.text = "\(exchangeRate)"
        }
        cell.configureCellViews(currencyName: currency.name, imageURL: currency.flagURL)
        return cell
    }
}

extension CurrencyConvertVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

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

extension CurrencyConvertVC: UITextFieldDelegate {
}
