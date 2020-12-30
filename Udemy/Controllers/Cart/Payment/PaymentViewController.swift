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
    @IBOutlet weak var tfYear: UITextField!
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
              let exp_month = tfDate.text,
              let exp_year = tfYear.text,
              let cvc = tfCvv.text else {
            return
        }
        let paramsStripe = CardStripeRequest(card: CardStripRequestDetail(number: Int(number), exp_month: Int(exp_month), exp_year: Int(exp_year), cvc: Int(cvc)))
        
        
        RequestAPI.shared.getStripeTokenObject(stripeToken: stripeToken, params: paramsStripe) { (stripeTokenObject) in
            guard let cardId = stripeTokenObject.card?.id,
                  let cardObject = stripeTokenObject.card?.object,
                  let tokenId = stripeTokenObject.id,
                  let tokenObject = stripeTokenObject.object,
                  let created = stripeTokenObject.created,
                  let type = stripeTokenObject.type,
                  let liveMode = stripeTokenObject.livemode,
                  let used = stripeTokenObject.used else {
                (UIApplication.shared.delegate as? AppDelegate)?.window?.showError("Paid fail", "Missing property in stripe token")
                return
            }
                  
            let cardPayment: PayCourseCardRequest = PayCourseCardRequest(
                id: cardId,
                object: cardObject)
            let tokenPayment: PayCourseTokenRequest = PayCourseTokenRequest(
                name: self.name,
                email: self.email,
                id: tokenId,
                object: tokenObject,
                created: created,
                type: type,
                livemode: liveMode,
                used: used,
                card: cardPayment)
            let cartPayment: PayCourseCartRequest = PayCourseCartRequest(_id: self.idCourse)
            
            let paramsPayment: PayCourseRequest = PayCourseRequest(token: tokenPayment, cart: [cartPayment], idUser: self.idUser)
            
            RequestAPI.shared.payCourse(params: paramsPayment, onSuccess: {
                self.navigationController?.popViewController(animated: true)
                if let onTapPayCourseSuccess = self.onTapPayCourseSuccess {
                    onTapPayCourseSuccess()
                }
            })
        }
    }
    
}
