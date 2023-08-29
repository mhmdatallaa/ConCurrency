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
    private var sourceCurrency = Constants.defaultSourceCurrency
    private var targetCurrency = Constants.defualTargetCurrency
    private let favoriteListVC = FavoriteListVC()
    private let protofolioDataSource = ProtofolioDataSource()
    private lazy var presenter = CurrencyConvertPresenter(view: self)
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private(set) var amountTextFiled: UITextField!
    @IBOutlet weak private(set) var sourceDropDown: DropDown!
    @IBOutlet weak private(set) var targetDropDown: DropDown!
    @IBOutlet weak private(set) var resultAmountLabel: CCLabel!
    @IBOutlet weak private(set) var convertButton: UIButton!
    @IBOutlet weak private(set) var addToFavoriteButton: UIButton!
    @IBOutlet weak private(set) var tableView: UITableView!
    @IBOutlet weak private(set) var emptyFavoriteLabel: UILabel!
    @IBOutlet weak private(set) var buttonIndicator: UIActivityIndicatorView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTextFiled.delegate = self
        
        configureViewsApperance()
        configureTableView()

        presenter.fetchConversionRates(for: Constants.defaultSourceCurrency)
        presenter.fetchAllCurrencies()
        presenter.getFavoriteCurrencies()
    }
    
    // MARK: - Superclass methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // Dismiss the keyboard by resigning first responder
        amountTextFiled.resignFirstResponder()
    }
    
    // MARK: - Configs
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = protofolioDataSource
        tableView.register(UINib(nibName: CellConstant.protofolioCellIdentifier, bundle: nil), forCellReuseIdentifier: CellConstant.protofolioCellIdentifier)
    }
    
    private func configureDropDown() {
        let dropDowns: [DropDown] = [sourceDropDown, targetDropDown]
        for dropDown in dropDowns {
            let emojis: [String] = allCurrencies.map { $0.currencyCode.intoEmoji() + $0.currencyCode }
          dropDown.optionArray = emojis
          dropDown.selectedIndex = 0
        }
        configureSourceDropDown()
        configureTargetDropDown()
    }
    
    private func configureSourceDropDown() {
        sourceDropDown.didSelect{ [weak self] (selectedText, index, _) in
            guard let self else { return }
            let selectedCurrency = self.allCurrencies[index].currencyCode
            self.sourceCurrency = selectedCurrency
            self.presenter.fetchConversionRates(for: selectedCurrency)
        }
    }
    
    private func configureTargetDropDown() {
        targetDropDown.didSelect{ [weak self] (selectedText, index, id) in
            guard let self else { return }
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
        // TODO: handle empty textField state
        let amount = amountTextFiled.text!.trimm
        buttonIndicator.startAnimating()
        convertButton.setTitle(Constants.emptyconvertButtonTitle, for: .normal)
        presenter.convert(amount: amount, from: sourceCurrency, to: targetCurrency)
    }
    
    @IBAction private func addToFavoriteButtonTapped(_ sender: Any) {
        goToFavoriteScreen()
    }
    
    private func goToFavoriteScreen() {
        let sb = UIStoryboard(name: Constants.storyboardName, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: Constants.FavoriteListScreenIdentifer) as! FavoriteListVC
        vc.presenter.delegate = self
        present(vc, animated: true)
    }
    
}

// MARK: - CurrencyConvertViewProtocol Extension

extension CurrencyConvertVC: CurrencyConvertViewProtocol {
    func updateConversionRate(_ rates: [ExchageRate]) {
        exchangeRates = rates
        protofolioDataSource.exchangeRates = exchangeRates
        tableView.reloadData()
        presenter.getFavoriteCurrencies()
    }
    
    func updateResult(_ result: String) {
        resultAmountLabel.text = "   " + result
        convertButton.setTitle(Constants.convertButtonTitle, for: .normal)
        buttonIndicator.stopAnimating()
    }
    
    func showFavoriteCurrencies(_ currencies: [Currency]) {
        favoriteCurrencies = currencies
        protofolioDataSource.favoriteCurrencies = favoriteCurrencies
        emptyFavoriteLabel.isHidden = favoriteCurrencies.isEmpty ? false : true
        tableView.reloadData()
    }
    
    func getAllCurrencies(_ currencies: [Currency]) {
        allCurrencies = currencies
        configureDropDown()
    }
    
    func showErrorAlert() {
        showAlert(title: Constants.alerttitleError, message: Constants.alertMessageError)
    }
}

// MARK: - UITableViewDelegate Extension

extension CurrencyConvertVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
}

// MARK: - CurrencyFavoritingDelegate Extension

extension CurrencyConvertVC: CurrencyFavoritingDelegate {
    func favorite(currency: Currency, actionType: ActionType) {
        switch actionType {
        case .add:
            favoriteCurrencies.append(currency)
            protofolioDataSource.updateFavoriteCurrencies(currency, action: .add)
        case .remove:
            favoriteCurrencies.removeAll { $0.currencyCode == currency.currencyCode }
            protofolioDataSource.updateFavoriteCurrencies(currency, action: .remove)
        }
        emptyFavoriteLabel.isHidden = favoriteCurrencies.isEmpty ? false : true
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


private enum Constants {
    static let defaultSourceCurrency = "EGP"
    static let defualTargetCurrency = "EGP"
    static let storyboardName = "Main"
    static let alerttitleError = "Ooops 😶"
    static let alertMessageError = "Server Error ❌, Please check your internet connection or try again later."
    static let cellHeight: CGFloat = 80
    static let convertButtonTitle = "Convert"
    static let emptyconvertButtonTitle = ""
    static let FavoriteListScreenIdentifer = "FavoriteListVC"
}
