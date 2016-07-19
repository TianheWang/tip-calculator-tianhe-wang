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

    let currencyFormatter = NSNumberFormatter()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let defaults = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTipPercentage")

        calculateTip(tipControl)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // locale specific currency and currency thousands separators
        currencyFormatter.locale = NSLocale.currentLocale()
        currencyFormatter.numberStyle = .CurrencyStyle
        tipLabel.text = currencyFormatter.stringFromNumber(0)
        totalLabel.text = currencyFormatter.stringFromNumber(0)

        if let lastBillAmount = getLastBillAmount() {
            billField.text = lastBillAmount
        }

        // billField become first responder
        billField.becomeFirstResponder()
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(sender: AnyObject) {
        let tipPercentages = [0.15, 0.18, 0.2]
        let bill = Double(billField.text!) ?? 0
        // save bill amount
        let defaults = NSUserDefaults.standardUserDefaults()
        let billAmountString = billField.text! as String
        defaults.setObject(billAmountString, forKey: "last_bill_amount")
        defaults.setObject(NSDate(), forKey: "last_bill_timestamp")
        defaults.synchronize()

        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip

        tipLabel.text = currencyFormatter.stringFromNumber(tip)
        totalLabel.text = currencyFormatter.stringFromNumber(total)

        animateTotal()
        animateTip()
    }

    func getLastBillAmount() -> String? {
        let now = NSDate()
        let defaults = NSUserDefaults.standardUserDefaults()
        let lastBillTimestamp = defaults.objectForKey("last_bill_timestamp") as! NSDate?
        // last bill amount persist for 10 minutes
        let isBillAmountExpired = lastBillTimestamp == nil || now.timeIntervalSinceDate(lastBillTimestamp!) > NSTimeInterval(10 * 60)

        if isBillAmountExpired {
            return nil
        } else {
            return defaults.stringForKey("last_bill_amount") as String?
        }
    }

    func animateTotal() {
        self.totalLabel.alpha = 0
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn,
                animations: {
                    self.totalLabel.alpha = 1
                }, completion: nil)
    }

    func animateTip() {
        self.tipLabel.alpha = 0
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn,
                                   animations: {
                                    self.tipLabel.alpha = 1
            }, completion: nil)
    }
}

