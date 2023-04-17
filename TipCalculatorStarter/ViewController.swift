//
//  ViewController.swift
//  TipCalculatorStarter
//
//  Created by Chase Wang on 9/19/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var themeSwitch: UISwitch!
    // MARK: - View Lifecycle
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func tipPercentChanged(_ sender: UISegmentedControl) {
            calculate()
    }
    @IBOutlet weak var totalAmountTitleLabel: UILabel!
    @IBOutlet weak var tipAmountTitleLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBAction func resetButtonTapped(_ sender: Any) {
            clear()
    }
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipPercentageSegmentedControl: UISegmentedControl!
    @IBOutlet weak var outputCardView: UIView!
    @IBOutlet weak var billAmountTextField: BillAmountTextField!
    @IBOutlet weak var inputCardView: UIView!
    @IBAction func themeToggled(_ sender: UISwitch) {
        if sender.isOn{
            print("switch toggled on")
        } else {
            print("switch toggled off")
        }
    }
    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        billAmountTextField.calculateButtonAction = {
            self.calculate()
        }
    }
    
    func calculate() {
        if self.billAmountTextField.isFirstResponder {
               self.billAmountTextField.resignFirstResponder()
           }
        
        // 1
        guard let billAmountText = self.billAmountTextField.text,
            let billAmount = Double(billAmountText) else {
                clear()
                return
        }
        
        let roundedBillAmount = (100 * billAmount).rounded() / 100
        
        let tipPercent: Double
        
        switch tipPercentageSegmentedControl.selectedSegmentIndex {
        case 0:
            tipPercent = 0.15
        case 1:
            tipPercent = 0.18
        case 2:
            tipPercent = 0.20
        default:
            preconditionFailure("Unexpected index")
        }
        
        let tipAmount = roundedBillAmount * tipPercent
        let roundedTipAmount = (100 * tipAmount).rounded() / 100
        
        let totalAmount = roundedBillAmount + roundedTipAmount

        self.billAmountTextField.text = String(format: "%.2f", roundedBillAmount)
        self.tipAmountLabel.text = String(format: "%.2f", roundedTipAmount)
        self.totalAmountLabel.text = String(format: "%.2f", totalAmount)
    }
    
    func clear() {
        self.billAmountTextField.text = nil
        self.tipPercentageSegmentedControl.selectedSegmentIndex = 0
        self.tipAmountLabel.text = "$0.00"
        self.totalAmountLabel.text = "$0.00"
    }
    
    func setupViews() {
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1)
            headerView.layer.shadowOpacity = 0.05
            headerView.layer.shadowColor = UIColor.black.cgColor
            headerView.layer.shadowRadius = 35
        
        inputCardView.layer.cornerRadius = 8
        inputCardView.layer.masksToBounds = true
        outputCardView.layer.cornerRadius = 8
        outputCardView.layer.masksToBounds = true
        
        resetButton.layer.cornerRadius = 8
        resetButton.layer.masksToBounds = true
        
        outputCardView.layer.borderWidth = 1
        outputCardView.layer.borderColor = UIColor.tcHotPink.cgColor
    }
}
