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
    private let favoriteListDataSource = FavoriteListDataSource()
    
    // MARK: IBOutlets    
    @IBOutlet weak private(set) var tableView: UITableView!
    @IBOutlet weak private(set) var containerView: UIView!
    @IBOutlet weak private(set) var indicator: UIActivityIndicatorView!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        indicator.startAnimating()
        presenter.getFavoriteCurrencies()
        presenter.fetchAllCurrencies()
    }
    
    // MARK: - Configs
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = favoriteListDataSource
        containerView.layer.cornerRadius = Constants.containerViewCornerRadius
        tableView.register(UINib(nibName: Constants.cellName, bundle: nil), forCellReuseIdentifier: Constants.cellName)
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
        favoriteListDataSource.currencies = currencies
        indicator.stopAnimating()
        tableView.reloadData()
    }
    
    func markFavoriteCurrencies(_ currencies: [Currency]) {
        favoriteCurrencies = currencies
        favoriteListDataSource.favoriteCurrencies = favoriteCurrencies
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate Extension

extension FavoriteListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeigt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FavoriteCell else {
            LoggerManager.error(message: Constants.castingErrorMessage)
            return
        }
        let currency = allCurrencies[indexPath.row]
        
        if cell.checkMarkImage.image == UIImage(systemName: Constants.fillCircleCheckMark) {
            presenter.removeFromFavorite(currency)
            cell.checkMarkImage.image = UIImage(systemName: Constants.circleCheckMark)
            toastMessage(action: .remove)
            return
        }
        
        presenter.addToFavorite(currency)
        cell.checkMarkImage.image = UIImage(systemName: Constants.fillCircleCheckMark)
        toastMessage(action: .add)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FavoriteCell else {
            LoggerManager.error(message: Constants.castingErrorMessage)
            return
        }
        let currency = allCurrencies[indexPath.row]
        
        if cell.checkMarkImage.image == UIImage(systemName: Constants.circleCheckMark) {
            presenter.addToFavorite(currency)
            cell.checkMarkImage.image = UIImage(systemName: Constants.fillCircleCheckMark)
            toastMessage(action: .add)
            return
        }
        
        cell.checkMarkImage.image = UIImage(systemName: Constants.circleCheckMark)
        presenter.removeFromFavorite(currency)
        toastMessage(action: .remove)
    }
}

private enum Constants {
    static let circleCheckMark = "circle"
    static let fillCircleCheckMark = "checkmark.circle.fill"
    static let castingErrorMessage = "Couldn't cast cell to FavoriteCell"
    static let cellName = "FavoriteCell"
    static let containerViewCornerRadius: CGFloat = 20
    static let cellHeigt: CGFloat = 80
}
