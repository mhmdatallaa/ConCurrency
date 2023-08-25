//
//  ViewController.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import UIKit

class CurrencyHandlerVC: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var convertSegmentView: UIView!
    @IBOutlet weak var compareSegmentView: UIView!
    
    @IBOutlet weak var segmentedView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.bringSubviewToFront(convertSegmentView)
        view.bringSubviewToFront(segmentControl)
        configureSegmentControl()
    }

    func configureSegmentControl() {
        segmentControl.layer.cornerRadius = segmentControl.bounds.height/2
        segmentControl.clipsToBounds = true
        segmentControl.layer.masksToBounds = true
    }
    
    @IBAction func didSwitchSegmentedControl(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
//            compareSegmentView.removeFromSuperview()
//            view.addSubview(convertSegmentView)
            view.bringSubviewToFront(convertSegmentView)
            view.bringSubviewToFront(segmentControl)

        case 1:
//            convertSegmentView.removeFromSuperview()
//            view.addSubview(compareSegmentView)
            view.bringSubviewToFront(compareSegmentView)
            view.bringSubviewToFront(segmentControl)

        default:
            break
        }
    }
    
}

