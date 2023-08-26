//
//  FavoriteListVC.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 26/08/2023.
//

import UIKit


class FavoriteListVC: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private(set) var tableView: UITableView!
    
    // MARK: Properties
    
    var currencies: [Currency] = []
//    let currencies = AllCurrenciesMock.getAllCurrencies()
    var indexPath: IndexPath!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let client = URLSessionClient()
        let service = CurrenciesListService(client: client)
        service.fetchAllCurrencies { result in
            switch result {
            case .success(let currencies):
                self.currencies = currencies.data
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
    }
    
}

// MARK: - Extensions

extension FavoriteListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as? FavoriteCell else {
            LoggerManager.error(message: "Couldn't cast Favorite cell")
            return UITableViewCell()
        }
        let currency = currencies[indexPath.row]
        cell.configureCellViews(name: currency.name)
        cell.selectionStyle = .none
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favoriteCurrencies):
                if let _ = favoriteCurrencies.firstIndex(of: currency) {
                    cell.setImage(for: "checkmark.circle.fill")
                }
            case .failure(let error):
                LoggerManager.error(message: error.localizedDescription)
            }
        }
        
        return cell
    }
    
}

extension FavoriteListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as? FavoriteCell
        let currency = currencies[indexPath.row]
        
        if cell?.checkMarkImage.image == UIImage(systemName: "checkmark.circle.fill") {
            PersistenceManager.updateWith(favorite: currencies[indexPath.row], actionType: .remove) { _ in
                print("Errrrrrror")
            }
            cell?.checkMarkImage.image = UIImage(systemName: "circle")
            return
        }
        print(currency)
        PersistenceManager.updateWith(favorite: currency, actionType: .add) { error in
            if let error {
                cell?.checkMarkImage.image = UIImage(systemName: "circle")
                LoggerManager.error(message: error.localizedDescription)
            } else {
                cell?.checkMarkImage.image = UIImage(systemName: "checkmark.circle.fill")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as? FavoriteCell
        cell?.checkMarkImage.image = UIImage(systemName: "circle")
        PersistenceManager.updateWith(favorite: currencies[indexPath.row], actionType: .remove) { _ in
            print("Errrrrrror")
        }
    }
}

struct AllCurrenciesMock {
    static func getAllCurrencies() -> [Currency] {
        [
            Currency(name: "USD Dollar", currencyCode: "USD", flagURL: "https://flagcdn.com/32x24/us.png"),
            Currency(name: "Japan Yen", currencyCode: "JPY", flagURL:  "https://flagcdn.com/32x24/jp.png"),
            Currency(name: "Oman Riyal", currencyCode: "OMR", flagURL: "https://flagcdn.com/32x24/om.png")
        ]
    }
}
