//
//  Order.swift
//  DuitkuSDkIos_Example
//
//  Created by Bambang Maulana on 24/07/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import duitku


class Order: DuitkuClient{

    @IBOutlet weak var imgOrder: UIImageView!
    public var product : String = ""
    public var detail : String = ""
    
    @IBOutlet weak var cardPayment: UIView!
    @IBOutlet weak var jumlah: UILabel!
    @IBOutlet weak var CardTitle: UIView!
    
    @IBOutlet weak var cardTotal: UIView!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var judul: UILabel!
    @IBOutlet weak var harga: UILabel!
    
    var param = [DuitkuKit]()
    var itemDetails_ = [ItemDetails]()
    
    
    
    override func viewDidLoad() {
               
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Order"
        
        
        Helper.setCardViewShadow(cardItem: self.CardTitle, radius: 1, opacity: 0.1)
        Helper.setCardViewShadow(cardItem: self.cardPayment, radius: 1, opacity: 0.1)
        Helper.setCardViewShadow(cardItem: self.cardTotal, radius: 1, opacity: 0.1)
        
        
        if product == "ipod" {
            let yourImage: UIImage = UIImage(named: "ipod")!
            imgOrder.image = yourImage
            judul.text = "All New Earphone K200"
            harga.text = "Rp "+String(10000).convertDoubleToCurrency().replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ".00", with: "")
            total.text =  "Rp "+String(10000).convertDoubleToCurrency().replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ".00", with: "")
            
            
        }else if product == "sepatu" {
            let yourImage: UIImage = UIImage(named: "sepatu")!
            imgOrder.image = yourImage
            judul.text = "Casual Shoes MA500"
            harga.text = "Rp "+String(250000).convertDoubleToCurrency().replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ".00", with: "")
            total.text =  "Rp "+String(250000).convertDoubleToCurrency().replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ".00", with: "")
        }
        
    //    imgOrder.image = UIImage(contentsOfFile: "ipod")//
        
    }

    @IBAction func purchase(_ sender: Any) {
        
             let amount = (total.text)!.numericString
             let harga_ = (harga.text)!.numericString
             let jumlah_ = (jumlah.text)!
             let product = (judul.text)!
           
        
        let refreshAlert = UIAlertController(title: "Purchase", message: "Lanjut Pembayaran", preferredStyle: UIAlertControllerStyle.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
     
            self.settingMerchant(amount: amount, product: product, price: harga_, quantity: jumlah_)
            self.startPayment(context: self)
            
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
             
        }))

        present(refreshAlert, animated: true, completion: nil)
        
        
        
        
        
        
        
           
    }
    
    @IBAction func btn_kurang(_ sender: Any) {
        

        
        let jumlahPesan : String = (self.jumlah.text)!
        let harga: String = (self.harga.text)!.numericString
        
        if Int(jumlahPesan)!  > 1 {
            
          let total_jumlah_pesanan : Int =  Int(jumlahPesan)! - 1
          self.jumlah.text = String(total_jumlah_pesanan)
          let totalharga :Int =  Int(harga)! * total_jumlah_pesanan
          self.total.text = "Rp "+String(totalharga).convertDoubleToCurrency().replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ".00", with: "")
            
        }else{
           Helper.showToast(message: "Minimal 1 Pembelanjaan", context: self)
        }
        
        
        
    }
    
    @IBAction func btn_tambah(_ sender: Any) {
        let jumlahPesan : String = (self.jumlah.text)!
        let harga: String = (self.harga.text)!.numericString
        
        
        if Int(jumlahPesan)!  < 10 {
              let total_jumlah_pesanan =  Int(jumlahPesan)! + 1
              self.jumlah.text = String(total_jumlah_pesanan)
              let totalharga :Int = Int(harga)! * total_jumlah_pesanan
              self.total.text = "Rp "+String(totalharga).convertDoubleToCurrency().replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ".00", with: "")
        }else{
              Helper.showToast(message: "Stok Kurang dari 10", context: self)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
          runPayment(context: self)
        
          self.navigationController?.isNavigationBarHidden = false
          self.navigationItem.title = "Order"
          
    }
    
    
    override func onSuccess_(status: String, reference: String, amount: String, code: String, merchantOrderId: String) {
        Main.statusNotifikasi = code
        
        
  
        self.navigationController?.popViewController(animated: false)
        clearSdkTask()
        
    }
    
    override func onPending_(status: String, reference: String, amount: String, code: String, merchantOrderId: String) {
         Main.statusNotifikasi = code
        
         self.navigationController?.popViewController(animated: false)
        clearSdkTask()
    }
    
    override func onCanceled_(status: String, reference: String, amount: String, code: String, merchantOrderId: String) {
         Main.statusNotifikasi = code
         
         self.navigationController?.popViewController(animated: false)
        clearSdkTask()
    }
    
    
    
    
    
    func settingMerchant(amount : String, product : String , price : String , quantity : String){
                
        Util.merchantNotification = true
        Util.redirect = false
        
        
        DuitkuKit.data(
              paymentAmount: amount
             ,productDetails: product
             ,email: "bambangm88@gmail.com"
             ,phoneNumber: "08979713464"
             ,additionalParam: ""
             ,merchantUserInfo: "Bambang"
             ,customerVaName: "Bambang Maulana"
             ,callbackUrl: "http://182.23.85.8/callback"
             ,returnUrl: "http://182.23.85.8/return"
             ,expiryPeriod: "60"
             ,firstName: "bambang"
             ,lastName: "maulana"
             ,alamat: "cigugur"
             ,city: "kuningan"
             ,postalCode: "45552"
             ,countryCode: "ID"
             ,merchantOrderId: "" //can empty if merchant order id on web server
        )
        
        //star loop here
        ItemDetails.data(name: product, price: Int(price)!, quantity: Int(quantity)!) //optional
        //finish start loop
         
         // base url
        BaseRequestDuitku.data(
              baseUrlPayment: "http://182.23.85.8/sdkserver/api/sandbox/request/"
             ,requestTransaction: "transaksi"
             ,checkTransaction: "checktransaksi"
             ,listPayment: "listPayment"
         )
               

         //insert to object
        // itemsKit.duitku = param
        // itemsKit.itemDetail = itemDetails_
         
        
    }
    
    
    
    
    
    
}


 extension String{
    func convertDoubleToCurrency() -> String{
        let amount1 = Double(self)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "en_US")
        return numberFormatter.string(from: NSNumber(value: amount1!))!
    }
}


extension String {

    /// Returns a string with all non-numeric characters removed
    public var numericString: String {
        let characterSet = CharacterSet(charactersIn: "0123456789.").inverted
        return components(separatedBy: characterSet)
            .joined()
    }
}
