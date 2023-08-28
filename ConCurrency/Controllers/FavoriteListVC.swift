//
//  FavoriteListVC.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 26/08/2023.
//

import UIKit

// MARK: - Action Type

enum ActionType {
    case add, remove
}

// MARK: - CurrencyFavoritingDelegate

protocol CurrencyFavoritingDelegate: AnyObject {
    func favorite(currency: Currency, actionType: ActionType)
}

// MARK: - FavoriteListVC

class FavoriteListVC: UIViewController, BaseView {
    
    // MARK: Properties
    lazy var presenter = FavoriteListPresenter(view: self)
    var currencies: [Currency] = []
    var isFavorite: Bool = false
    
    // MARK: IBOutlets    
    @IBOutlet weak private(set) var tableView: UITableView!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchAllCurrencies()
        
    }
    
    // MARK: - Actions
    
    // MARK: - Configs
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
    }
    
    // MARK: Methods
    
    private func fetchAllCurrencies() {
        NetworkingManager.shared.fetchAllCurrencies { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let currencies):
                self.currencies = currencies.data
                self.tableView.reloadData()
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
            }
        }

    }
    
    
}




// MARK: - Extensions

    extension FavoriteListVC: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print(currencies.count)
            return currencies.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as? FavoriteCell else {
                LoggerManager.error(message: "Couldn't cast to Favorite cell")
                return UITableViewCell()
            }
            
            let currency = currencies[indexPath.row]
            cell.configureCellViews(name: currency.name, imageURL: currency.flagURL)
            cell.selectionStyle = .none
            
            let favoriteCurrencies = retrieveFavoriteCurrencies()
            if let _ = favoriteCurrencies.firstIndex(of: currency) {
                cell.setImage(for: "checkmark.circle.fill")
            }
            
            return cell
        }
        
        
        
        private func retrieveFavoriteCurrencies() -> [Currency] {
            var currencies = [Currency]()
            PersistenceManager.retrieveFavorites { result in
                switch result {
                case .success(let favoriteCurrencies):
                    currencies = favoriteCurrencies
                case .failure(let error):
                    LoggerManager.error(message: error.localizedDescription)
                }
            }
            
            return currencies
        }
    
    
}

extension FavoriteListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = self.tableView.cellForRow(at: indexPath) as? FavoriteCell else {
            LoggerManager.error(message: "Couldn't cast cell to FavoriteCell")
            return
        }
        let currency = currencies[indexPath.row]
        
        if cell.checkMarkImage.image == UIImage(systemName: "checkmark.circle.fill") {
            presenter.removeFromFavorite(currency)
            cell.checkMarkImage.image = UIImage(systemName: "circle")
            return
        }
        
        presenter.addToFavorite(currency)
        cell.checkMarkImage.image = UIImage(systemName: "checkmark.circle.fill")
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = self.tableView.cellForRow(at: indexPath) as? FavoriteCell else {
            LoggerManager.error(message: "Couldn't cast cell to FavoriteCell")
            return
        }
        let currency = currencies[indexPath.row]
        
        if cell.checkMarkImage.image == UIImage(systemName: "circle") {
            presenter.addToFavorite(currency)
            cell.checkMarkImage.image = UIImage(systemName: "checkmark.circle.fill")
            return
        }
        
        cell.checkMarkImage.image = UIImage(systemName: "circle")
        presenter.removeFromFavorite(currency)
    }
}
