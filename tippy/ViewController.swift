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

    @IBOutlet weak var eachBillLabel: UILabel!

    @IBOutlet weak var partySizeLabel: UILabel!

    @IBOutlet weak var billField: UITextField!

    @IBOutlet weak var tipControl: UISegmentedControl!

    @IBOutlet weak var partySizeControl: UIStepper!

    let currencyFormatter = NSNumberFormatter()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTipPercentage")
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fine-dining")!)
        calculateTip(tipControl)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // locale specific currency and currency thousands separators
        currencyFormatter.locale = NSLocale.currentLocale()
        currencyFormatter.numberStyle = .CurrencyStyle
        tipLabel.text = currencyFormatter.stringFromNumber(0)
        totalLabel.text = currencyFormatter.stringFromNumber(0)

        // initialize party size
        partySizeControl.value = 1

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
        var bill = Double(billField.text!) ?? 0
        // save bill amount
        let defaults = NSUserDefaults.standardUserDefaults()
        let billAmountString = billField.text! as String
        defaults.setObject(billAmountString, forKey: "lastBillAmount")
        defaults.setObject(NSDate(), forKey: "lastBillTimestamp")
        defaults.synchronize()

        let taxRate = defaults.doubleForKey("taxRate") / 100.0
        bill = bill / (1 + taxRate)
        let tax = bill * taxRate
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip + tax
        let each = total / partySizeControl.value

        tipLabel.text = currencyFormatter.stringFromNumber(tip)
        totalLabel.text = currencyFormatter.stringFromNumber(total)
        eachBillLabel.text = currencyFormatter.stringFromNumber(each)

        animateTotal()
        animateTip()
        animateEach()
    }

    @IBAction func partySizeChanged(sender: AnyObject) {
        var partySize = Int(partySizeControl.value) ?? 1
        if (partySize < 1) {
            partySizeControl.value = 1
            partySize = 1
        }
        partySizeLabel.text = String(partySize)
        calculateTip(tipControl)
    }

    func getLastBillAmount() -> String? {
        let now = NSDate()
        let defaults = NSUserDefaults.standardUserDefaults()
        let lastBillTimestamp = defaults.objectForKey("lastBillTimestamp") as! NSDate?
        // last bill amount persist for 10 minutes
        let isBillAmountExpired = lastBillTimestamp == nil || now.timeIntervalSinceDate(lastBillTimestamp!) > NSTimeInterval(10 * 60)

        if isBillAmountExpired {
            return nil
        } else {
            return defaults.stringForKey("lastBill_amount") as String?
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

    func animateEach() {
        self.eachBillLabel.alpha = 0
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn,
                animations: {
                     self.eachBillLabel.alpha = 1
            }, completion: nil)
    }
}

