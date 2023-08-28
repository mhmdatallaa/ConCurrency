//
//  ViewController.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import UIKit

class CurrencyHandlerVC: UIViewController {
    
    // MARK: IBOutlets

    @IBOutlet weak private(set) var segmentControl: UISegmentedControl!
    @IBOutlet weak private(set) var convertSegmentView: UIView!
    @IBOutlet weak private(set) var compareSegmentView: UIView!
    
    // MARK: Life cycle
    
    @IBOutlet weak var segmentedView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("handler")
        setConvertView()
    }
    
    // MARK: Methods
    
    private func setConvertView() {
        view.bringSubviewToFront(convertSegmentView)
        view.bringSubviewToFront(segmentControl)
    }
    
    private func setCompareView() {
        view.bringSubviewToFront(compareSegmentView)
        view.bringSubviewToFront(segmentControl)
    }
    
    // MARK: Actions
    
    @IBAction private func didSwitchSegmentedControl(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            setConvertView()
        case 1:
            setCompareView()
        default:
            preconditionFailure("Unable to get the righ case.")
        }
    }
    
}

// MARK: - Extenstions
