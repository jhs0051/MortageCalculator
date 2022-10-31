//
//  ViewController.swift
//  Su22Assgn2aMortageCalculator
//
//  Created by Jon Houston Seibert on 6/11/22.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var loanAmountTxt: UITextField!
    
    @IBOutlet weak var numPayPeriodTxt: UITextField!
    
    @IBOutlet weak var interestRatePPPTxt: UITextField!
    
    @IBAction func OnTapGestureRecognized(_ sender: Any) {
        loanAmountTxt.resignFirstResponder()
        numPayPeriodTxt.resignFirstResponder()
        interestRatePPPTxt.resignFirstResponder()
    }
    
    @IBAction func calculatePaymentButton(_ sender: UIButton) {
        
        // Checks to make sure all user inputs are set, if not, alert error thrown
        if !loanAmountTxt.hasText || !numPayPeriodTxt.hasText || !interestRatePPPTxt.hasText {
            
            let controller = UIAlertController(title: "invalid input!", message: nil, preferredStyle: .actionSheet)
            let Action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            controller.addAction(Action)
            
            if let ppc = controller.popoverPresentationController {
                ppc.sourceView = sender
                ppc.sourceRect = sender.bounds
            }
            present(controller, animated: true, completion: nil)
            
            return totalPaymentAmountText.text = "Invalid Input!"
        }
        
        let loanAmount = Float(loanAmountTxt.text!)!
        let numOfPayments = Int(numPayPeriodTxt.text!)!
        let interestRatePPP = Float(interestRatePPPTxt.text!)!
        let totalPayment = payment(loanAmount, numOfPayments, interestRatePPP)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .currency

        let formattedLoan = numberFormatter.string(from: NSNumber(value: totalPayment))!
        
        totalPaymentAmountText.text = formattedLoan
        
        // Checks to make sure all user inputs are postive, if not, alert error thrown
        if loanAmount < 0 || numOfPayments < 0 || interestRatePPP < 0 {
            
            let controller = UIAlertController(title: "invalid input!", message: nil, preferredStyle: .actionSheet)
            let Action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            controller.addAction(Action)
            
            if let ppc = controller.popoverPresentationController {
                ppc.sourceView = sender
                ppc.sourceRect = sender.bounds
            }
            present(controller, animated: true, completion: nil)
            
            return totalPaymentAmountText.text = "Invalid Input!"
        }
    }
    
    @IBOutlet weak var totalPaymentAmountText: UILabel!
    
    func payment( _ loanAmount : Float, _ numOfPayments : Int, _ interestRatePPP : Float) -> Float
    {
        // convert interest rate to percentage
        let interestRatePercentage : Float = interestRatePPP / 100
        
        // seperating calculations into two parts for code readability
        let loanTotalPartOne = Float(loanAmount) * interestRatePercentage * pow(1 + interestRatePercentage, Float(numOfPayments))
        let loanTotalPartTwo = pow(1 + interestRatePercentage, Float(numOfPayments)) - 1
        
        return Float(loanTotalPartOne / loanTotalPartTwo)
    }
}
