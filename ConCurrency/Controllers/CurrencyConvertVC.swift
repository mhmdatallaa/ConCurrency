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
    
    var currencies: [Currency] = []
    let favoriteListVC = FavoriteListVC()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProtofolioCell", bundle: nil), forCellReuseIdentifier: "ProtofolioCell")
        tableView.isScrollEnabled = false

        
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let currencies):
                self.currencies = currencies
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
            }
        }
        configureViewsApperance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("appear")
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
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FavoriteListVC") as! FavoriteListVC
        vc.delegate = self
        present(vc, animated: true)
    }
    
}

// MARK: - Extensions

extension CurrencyConvertVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProtofolioCell") as? ProtofolioCell else {
            LoggerManager.error(message: "Couldn't cast Favorite cell")
            return UITableViewCell()
        }
        let currency = currencies[indexPath.row]
        cell.configureCellViews(name: currency.name, imageURL: currency.flagURL)
        return cell
    }
    
    
}

extension CurrencyConvertVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension CurrencyConvertVC: CurrencyFavoriting {
    func favorite(currency: Currency, actionType: ActionType) {
        switch actionType {
        case .add:
            currencies.append(currency)
        case .remove:
            currencies.removeAll {$0.currencyCode == currency.currencyCode}
        }
        tableView.reloadData()
    }
}
