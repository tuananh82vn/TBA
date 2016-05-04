import UIKit

extension UIView {
    
    
	func startRotating(duration: CFTimeInterval = 2.0, completionDelegate: AnyObject? = nil) {
        
        let kAnimationKey = "rotation"

		let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
		rotateAnimation.fromValue = 0.0
		rotateAnimation.toValue = CGFloat(M_PI * 2.0)
		rotateAnimation.duration = duration
		
		if let delegate: AnyObject = completionDelegate {
			rotateAnimation.delegate = delegate
		}
        
		self.layer.addAnimation(rotateAnimation, forKey: kAnimationKey)
	}
    
//    func startRotating(duration: Double = 1) {
//        let kAnimationKey = "rotation"
//        
//        if self.layer.animationForKey(kAnimationKey) == nil {
//            let animate = CABasicAnimation(keyPath: "transform.rotation")
//            animate.duration = duration
//            animate.repeatCount = Float.infinity
//            animate.fromValue = 0.0
//            animate.toValue = Float(M_PI * 2.0)
//            self.layer.addAnimation(animate, forKey: kAnimationKey)
//        }
//    }
    
    func stopRotating() {
        let kAnimationKey = "rotation"
        
        if self.layer.animationForKey(kAnimationKey) != nil {
            self.layer.removeAnimationForKey(kAnimationKey)
        }
    }
}