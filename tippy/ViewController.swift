//
//  ViewController.swift
//  tippy
//
//  Created by tianhe_wang on 7/16/16.
//  Copyright © 2016 tianhe_wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!

    @IBOutlet weak var totalLabel: UILabel!

    @IBOutlet weak var billField: UITextField!

    @IBOutlet weak var tipControl: UISegmentedControl!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let defaults = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTipPercentage")
        calculateTip(tipControl)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(sender: AnyObject) {

        let tipPercentages = [0.15, 0.18, 0.2]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip

        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

}

