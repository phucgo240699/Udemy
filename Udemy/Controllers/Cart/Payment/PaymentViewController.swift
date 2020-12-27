//
//  PaymentViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 04/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import SVProgressHUD

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
        guard let number = tfCode.text,
              let exp_month = tfDate.text?.split(separator: "/")[0],
              let exp_year = tfDate.text?.split(separator: "/")[1],
              let cvc = tfCvv.text else {
            return
        }
        let paramsStripe = CardStripeRequest(card: CardStripRequestDetail(number: number, exp_month: Int(exp_month), exp_year: Int(exp_year), cvc: cvc))
        
        
        RequestAPI.shared.getStripeTokenObject(params: paramsStripe) { (stripeToken) in
            
            let cardPayment: PayCourseCardRequest = PayCourseCardRequest(
                id: stripeToken.card?.id,
                object: stripeToken.card?.object)
            let tokenPayment: PayCourseTokenRequest = PayCourseTokenRequest(
                name: self.name,
                email: self.email,
                id: stripeToken.id,
                object: stripeToken.object,
                created: stripeToken.created,
                type: stripeToken.type,
                livemode: stripeToken.livemode,
                used: stripeToken.used,
                card: cardPayment)
            let cartPayment: [PayCourseCartRequest] = [PayCourseCartRequest(_id: self.idCourse)]
            
            let paramsPayment: PayCourseRequest = PayCourseRequest(token: tokenPayment, cart: cartPayment, idUser: self.idUser)
            
            RequestAPI.shared.payCourse(params: paramsPayment, onSuccess: {
                self.navigationController?.popViewController(animated: true)
                if let onTapPayCourseSuccess = self.onTapPayCourseSuccess {
                    onTapPayCourseSuccess()
                }
            })
        }
    }
    
}
