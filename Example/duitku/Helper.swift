import UIKit

class Helper{
    
     //set Shadow (Card View)
     public static func setCardViewShadow(cardItem:UIView, radius:CGFloat , opacity:Float){
        
        cardItem.layer.shadowColor = UIColor.black.cgColor
        cardItem.layer.shadowOpacity = 0.07
        cardItem.layer.shadowOffset = .zero
        cardItem.layer.shadowRadius = 10
        
        
        
        
     }
    
    
    public static func showToast(message : String, context: UIViewController) {

        let toastLabel = UILabel(frame: CGRect(x: context.view.frame.size.width/2 - 150, y: context.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        context.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    
}
