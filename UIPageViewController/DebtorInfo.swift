//
//  DebtorInfo.swift
//  UIPageViewController
//
//  Created by andy synotive on 4/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import Foundation


class DebtorInfo {
    
    var ReferenceNumber : String
    var AccountCode : String
    var DebtorCode : String
    var TotalOutstanding : Float
    var NextPaymentInstallmentAmount : String
    var MerchantId : String
    
    var IsSuccess : Bool
    var Errors : [Error]
    
    init() {
        ReferenceNumber = ""
        AccountCode = ""
        DebtorCode = ""
        TotalOutstanding = 0
        NextPaymentInstallmentAmount = ""
        MerchantId = ""
        IsSuccess = false
        Errors = [Error]()
    }
    
//    public virtual Decimal TotalOutstanding { get; set; }
//    
//    public virtual Nullable<Double> OtherAmount { get; set; }
//    
//    public virtual String TotalOtherAmount { get { return string.Format(“{0:c}”, this.OtherAmount); } }
//
//    public virtual Decimal MinimumWeeklyOutstanding { get; set; }
//
//    public virtual Decimal MinimumFortnightlyOutstanding { get; set; }
//
//    public virtual Decimal MinimumMonthlyOutstanding { get; set; }
//
//    public virtual String AccountCode { get; set; }
//
//    public virtual String ClientCode { get; set; }
//
//    public virtual String ClientName { get; set; }
//
//    public virtual String DebtorCode { get; set; }
//
//    public virtual String FirstName { get; set; }
//
//    public virtual String LastName { get; set; }
//
//    public virtual String FullName { get { return FirstName + ” ” + LastName; } }
//
//    public virtual String MobileNumbers { get; set; }
//
//    public virtual String MobileNumberFormatted
//
//
//    public virtual String PaymentHistoryPresent { get; set; }
//
//    public virtual Double FirstPaymentInstallment { get; set; }
//
//    public virtual String FirstPaymentInstallmentAmount { get { return string.Format(“{0:c}”, this.FirstPaymentInstallment); } }
//
//    public virtual Double NextPaymentInstallment { get; set; }
//
//    public virtual String NextPaymentInstallmentAmount { get { return string.Format(“{0:c}”, this.NextPaymentInstallment); } }
//
//    public virtual Int32 PaymentType { get; set; }
//
//
//    public virtual String DateOfBirths { get; set; }
//
//    public virtual String RegNumbers { get; set; }
//
//    public virtual String Address1s { get; set; }
//
//    public virtual String Address2s { get; set; }
//
//    public virtual String Address3s { get; set; }
//
//    public virtual String Suburbs { get; set; }
//
//    public virtual String States { get; set; }
//
//    public virtual String PostCodes { get; set; }
//
//    public virtual String Countrys { get; set; }
//
//
//    public virtual String TotalOutstandingAmount { get { return string.Format(“{0:c}”, this.TotalOutstanding); } }
//
//    public virtual String Name
//
//
//    public virtual String MobileNumber
//
//
//    public virtual bool IsPaymentHistoryPresent
//
//
//    public virtual ListClient Client { get; set; }
//
//    public virtual String DriverLicenseNumber { get; set; }
//    public virtual int MaxNoPay { get; set; }
//    public virtual String DateOfDebt { get; set; }
//
//    public virtual String NTID { get; set; }
//
//    public virtual String MerchantId
//
//    public virtual bool IsExistingArrangementDD { get; set; }
//
//    public virtual bool IsExistingArrangementCC { get; set; }
//
//    public virtual bool IsExistingArrangement { get; set; }
//
//    public virtual bool IsCoBorrowers { get; set; }
//
//    public virtual string PinNumber { get; set; }
//
//    public virtual string PinNumberInput { get; set; }
//
//    public virtual string Netcode { get; set; }
//
//    public virtual string ArrangementDebtor { get; set; }
//
//    public virtual bool IsArrangementUnderThisDebtor { get; set; }
//
//    public virtual string ArrangementType { get; set; }
//
//    public virtual DebtorPayment CurrentPayment { get; set; }
//
//    public virtual bool IsSMSchecked { get; set; }
//
//    public virtual bool IsPinNumberChecked { get; set; }
//
//    public virtual bool IsMobileAvailable { get; set; }
//
//    public virtual bool isVerify { get; set; }
//
//
//    public virtual bool IsSendFuturePaymentSmsReminder { get; set; }
//
//    public virtual int SmsReminderDays { get; set; }
//
//
//    public virtual bool IsSendFuturePaymentEmailReminder { get; set; }
//
//    public virtual int EmailReminderDays { get; set; }
//
//    public string EmailAddress { get; set; }
//
//    public virtual bool IsFutureDate { get; set; }
//
//    public virtual bool IsCoBorrowerSelected { get; set; }
//
//    public virtual List<string> CoDebtorCode { get; set; }
//    public virtual List<string> CoFirstName { get; set; }
//    public virtual List<string> CoLastName { get; set; }
//    public virtual List<string> CoMobileNumbers { get; set; }
//    public virtual List<string> CoDriverLicenseNumber { get; set; }
//
//    public virtual List<InstalmentSchedule> InstalmentScheduleList { get; set; }
//    public virtual List<HistoryPayment> HistoryPaymentList { get; set; }
//    public virtual List<HistoryInstalmentSchedule> HistoryInstalmentScheduleList { get; set; }
//
//    public virtual string Action { get; set; }
//    public virtual string NumberInstalmentRemain { get; set; }
//    public virtual string FinalInstalmentDate { get; set; }
//    public virtual string TotalPaid { get; set; }
//    public bool IsPinNumberExits { get; set; }
    

}