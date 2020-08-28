//
//  testcellcollection.swift
//  DuitkuSDkIos_Example
//
//  Created by Bambang Maulana on 03/08/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
class itemProduct: UICollectionViewCell {
    

    @IBOutlet weak var cardview: UIView!
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    func setupData(data: [String]) {
            
        title.text = data.first
        price.text = data.last
        
        Helper.setCardViewShadow(cardItem: self.cardview, radius: 1, opacity: 0.1)
                
        let a : String = String(data[1])
        let image: UIImage = UIImage(named: a)!
        imageview.image = image
    }
    
    
    
    
    
    
  
    
    
}
