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

class FavoriteListVC: UIViewController {
    
    // MARK: Properties
    lazy var presenter = FavoriteListPresenter(view: self)
    private var allCurrencies: [Currency] = []
    private var favoriteCurrencies: [Currency] = []
    
    // MARK: IBOutlets    
    @IBOutlet weak private(set) var tableView: UITableView!
    @IBOutlet weak private(set) var containerView: UIView!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.getFavoriteCurrencies()
        presenter.fetchAllCurrencies()
        configureTableView()
        
    }
    
    // MARK: - Configs
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        containerView.layer.cornerRadius = 20
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
    }
    
    // MARK: - Actions
    
    @IBAction private func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}

// MARK: - FavoriteListViewProtocol Extension

extension FavoriteListVC: FavoriteListViewProtocol {
    func getAllCurrencies(_ currencies: [Currency]) {
        allCurrencies = currencies
        tableView.reloadData()
    }
    
    func markFavoriteCurrencies(_ currencies: [Currency]) {
        favoriteCurrencies = currencies
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource Extension

    extension FavoriteListVC: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print(allCurrencies.count)
            return allCurrencies.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as? FavoriteCell else {
                LoggerManager.error(message: "Couldn't cast to Favorite cell")
                return UITableViewCell()
            }
            
            let currency = allCurrencies[indexPath.row]
            cell.configureCellViews(name: currency.name, imageURL: currency.flagURL)
            cell.selectionStyle = .none
            if let _ = favoriteCurrencies.firstIndex(of: currency) {
                cell.setImage(for: "checkmark.circle.fill")
            }
            
            return cell
        }
    
    
}

// MARK: - UITableViewDelegate Extension

extension FavoriteListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FavoriteCell else {
            LoggerManager.error(message: "Couldn't cast cell to FavoriteCell")
            return
        }
        let currency = allCurrencies[indexPath.row]
        
        if cell.checkMarkImage.image == UIImage(systemName: "checkmark.circle.fill") {
            presenter.removeFromFavorite(currency)
            cell.checkMarkImage.image = UIImage(systemName: "circle")
            return
        }
        
        presenter.addToFavorite(currency)
        cell.checkMarkImage.image = UIImage(systemName: "checkmark.circle.fill")
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FavoriteCell else {
            LoggerManager.error(message: "Couldn't cast cell to FavoriteCell")
            return
        }
        let currency = allCurrencies[indexPath.row]
        
        if cell.checkMarkImage.image == UIImage(systemName: "circle") {
            presenter.addToFavorite(currency)
            cell.checkMarkImage.image = UIImage(systemName: "checkmark.circle.fill")
            return
        }
        
        cell.checkMarkImage.image = UIImage(systemName: "circle")
        presenter.removeFromFavorite(currency)
    }
}
