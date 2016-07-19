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

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        defaultTipControl.selectedSegmentIndex = defaults.integerForKey("defaultTipPercentage")
    }
    

    @IBAction func defaultPercentageChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let index = defaultTipControl.selectedSegmentIndex ?? 0
        defaults.setInteger(index, forKey: "defaultTipPercentage")
        defaults.synchronize()
    }

}
