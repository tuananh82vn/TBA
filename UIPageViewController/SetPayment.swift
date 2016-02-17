//
//  SetPayment.swift
//  UIPageViewController
//
//  Created by andy synotive on 16/02/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import UIKit

struct SetPayment {

    static func SetPayment(paymentType: Int) {
        
        
        //        1: Pay In Full
        //        2: Pay In 3 Part
        //        3: Pay In Installment
        //        4: Pay Other Amount
        //        5: Pay Next Instalment
        if(paymentType == 0){
            LocalStore.setMakePaymentInFull(false)
            LocalStore.setMakePaymentIn3Part(false)
            LocalStore.setMakePaymentInstallment(false)
            LocalStore.setMakePaymentOtherAmount(false)
        }
        else
        
        if(paymentType == 1){
            LocalStore.setMakePaymentInFull(true)
            LocalStore.setMakePaymentIn3Part(false)
            LocalStore.setMakePaymentInstallment(false)
            LocalStore.setMakePaymentOtherAmount(false)
        }
        else
            if(paymentType == 2){
                LocalStore.setMakePaymentInFull(false)
                LocalStore.setMakePaymentIn3Part(true)
                LocalStore.setMakePaymentInstallment(false)
                LocalStore.setMakePaymentOtherAmount(false)
        }
        else
                if(paymentType == 3){
                    LocalStore.setMakePaymentInFull(false)
                    LocalStore.setMakePaymentIn3Part(false)
                    LocalStore.setMakePaymentInstallment(true)
                    LocalStore.setMakePaymentOtherAmount(false)
        }
        else
                    if(paymentType == 4){
                        LocalStore.setMakePaymentInFull(false)
                        LocalStore.setMakePaymentIn3Part(false)
                        LocalStore.setMakePaymentInstallment(false)
                        LocalStore.setMakePaymentOtherAmount(true)
        }
    }
}