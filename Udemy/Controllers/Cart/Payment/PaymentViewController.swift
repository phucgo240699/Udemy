//
//  PaymentViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 04/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    
    // Closure
    var onTapPayCourseSuccess: (() -> Void)?
    
    var name: String?
    var email: String?
    var stripeToken: String?
    var idCourse: String?
    var idUser: String?

    @IBOutlet weak var tfCode: UITextField!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfCvv: UITextField!
    @IBOutlet weak var paymentBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Payment Button
        paymentBtn.afterEffect(cornerRadius: 5.0, borderWidth: 0.0, borderColor: .clear)
        paymentBtn.dropShadow(color: Common.color.textColor, opacity: 0.5, offSet: CGSize(width: 2, height: 3), radius: 3.0, scale: false)
    }
    @IBAction func payBtnPressed(_ sender: UIButton) {
        RequestAPI.shared.getPaymentKey { (key) in
            RequestAPI.shared.payCourse(name: self.name, email: self.email, stripeToken: self.stripeToken, amount: 1, idCourse: self.idCourse, idUser: self.idUser) {

                if let onTapPayCourseSuccess = self.onTapPayCourseSuccess {
                    onTapPayCourseSuccess()
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
