//
//  testCollection.swift
//  DuitkuSDkIos_Example
//
//  Created by Bambang Maulana on 03/08/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class Main: UIViewController {
  
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var baner: UIView!
    @IBOutlet weak var statusPembayaran: UILabel!
    @IBOutlet weak var imageStatus: UIImageView!


    @IBOutlet weak var cardNotification: UIView!
    
    public static var statusNotifikasi : String = ""
    
    
     let localStatusData = [["Rp 250.000", "sepatu","Casual Shoes MA500"], ["Rp 10.000","ipod", "All New Earphone K200"]]
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            self.navigationController?.isNavigationBarHidden = true
               self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
               self.navigationController?.navigationBar.barTintColor = UIColor.white
            self.navigationController?.isNavigationBarHidden = false
            self.navigationItem.title = "Duitku Store"
            
             
            Helper.setCardViewShadow(cardItem: self.baner, radius: 1, opacity: 0.1)
            configureView()
        }
    
    
    
    
        override func viewWillAppear(_ animated: Bool) {
            
                        
            if Main.statusNotifikasi == "00" {
                self.cardNotification.isHidden = false
                imageStatus.image = UIImage(named: "icons8-checked")
                statusPembayaran.text = "Pembayaran Berhasil"
                Main.statusNotifikasi = ""
            } else if Main.statusNotifikasi == "01" {
                self.cardNotification.isHidden = false
                imageStatus.image = UIImage(named: "icons8-cancel")
                statusPembayaran.text = "Pembayaran Gagal"
                Main.statusNotifikasi = ""
            } else if Main.statusNotifikasi == "02" {
                self.cardNotification.isHidden = false
                imageStatus.image = UIImage(named: "icons8-cancel")
                statusPembayaran.text = "Pembayaran Pending"
                Main.statusNotifikasi = ""
            }else if Main.statusNotifikasi == "03" {
                self.cardNotification.isHidden = false
                imageStatus.image = UIImage(named: "icons8-cancel")
                statusPembayaran.text = "Pembayaran Gagal"
                Main.statusNotifikasi = ""
            }
            
        }
    
    

    @IBAction func alertDismiss(_ sender: UIButton) {
                
        self.cardNotification.isHidden = true
        
    }
}



extension Main: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource , UICollectionViewDelegate {
    
    func configureView() {
       // backgroundView.roundCorners(with: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 10)
        
        collection.register(UINib(nibName: "itemProduct", bundle: nil), forCellWithReuseIdentifier: "itemProduct")
       
        collection.delegate = self
        collection.dataSource = self
        collection.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 2
        default:
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemProduct", for: indexPath) as?itemProduct
                let data = localStatusData[indexPath.item]
                cell?.setupData(data: data)
                return cell ?? UICollectionViewCell()
        default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemProduct", for: indexPath) as?itemProduct
                    let data = localStatusData[indexPath.item]
                    cell?.setupData(data: data)
                    return cell ?? UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 1:
            let width = (collectionView.frame.width/2)
            let height = width/1.2
            return CGSize(width: width, height: height)
        case 2:
            let width = collectionView.frame.width
            return CGSize(width: width, height: 40)
        case 3:
            let width = collectionView.frame.width/3
            let height = width/1.2
            return CGSize(width: width, height: height)
        default:
            let width = (collectionView.frame.width/2)
            let height = width*1.5
            return CGSize(width: width, height: height)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
              
        switch indexPath.item {
             case 0:

                   let vc = storyboard?.instantiateViewController(withIdentifier:"order") as!Order
                   vc.product = "sepatu"
                   vc.detail = "All New Sepatu Casual"
                   self.navigationController?.pushViewController(vc, animated: true)
             case 1:
                   
                   let vc = storyboard?.instantiateViewController(withIdentifier:"order") as!Order
                  vc.product = "ipod"
                  vc.detail = "All New Sepatu Casual"
                  self.navigationController?.pushViewController(vc, animated: true)
             
             default:
                 return
             }
        

     }
    
   
    
    
    
}
