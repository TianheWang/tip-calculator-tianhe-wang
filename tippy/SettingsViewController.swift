//
//  SettingsViewController.swift
//  tippy
//
//  Created by tianhe_wang on 7/16/16.
//  Copyright © 2016 tianhe_wang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipControl: UISegmentedControl!

    @IBOutlet weak var pretaxSwitch: UISwitch!

    @IBOutlet weak var taxRateLabel: UILabel!

    @IBOutlet weak var taxRateInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        defaultTipControl.selectedSegmentIndex = defaults.integerForKey("defaultTipPercentage")
        let taxRate = defaults.doubleForKey("taxRate")
        if taxRate == 0 {
            taxRateInput.text = ""
        } else {
            taxRateInput.text = String(taxRate)
        }
        pretaxSwitch.on = defaults.boolForKey("taxRateOn")
    }

    @IBAction func defaultPercentageChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let index = defaultTipControl.selectedSegmentIndex ?? 0
        defaults.setInteger(index, forKey: "defaultTipPercentage")
        defaults.synchronize()
    }

    @IBAction func onPretaxSwitchChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if pretaxSwitch.on {
            taxRateLabel.hidden = false
            taxRateInput.hidden = false
            let taxRate = (Double(taxRateInput.text!) ?? 0)
            defaults.setDouble(taxRate, forKey: "taxRate")
            defaults.setBool(true, forKey: "taxRateOn")
        } else {
            taxRateLabel.hidden = true
            taxRateInput.hidden = true
            defaults.setDouble(0, forKey: "taxRate")
            defaults.setBool(false, forKey: "taxRateOn")
        }
        defaults.synchronize()
    }

    @IBAction func onTaxRateChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let taxRate = (Double(taxRateInput.text!) ?? 0)
        defaults.setDouble(taxRate, forKey: "taxRate")
        defaults.synchronize()
    }
}
