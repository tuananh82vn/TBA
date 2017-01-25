import UIKit

extension UIView {
    
    
    func startRotating(duration: Double, clockwise: Bool) {
        let kAnimationKey = "rotation"
        var currentState = CGFloat(0)
        
        // Get current state
        if let presentationLayer = layer.presentation(), let zValue = presentationLayer.value(forKeyPath: "transform.rotation.z"){
            currentState = CGFloat((zValue as AnyObject).floatValue)
        }
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            animate.fromValue = currentState //Should the value be nil, will start from 0 a.k.a. "the beginning".
            animate.byValue = clockwise ? Float(M_PI * 2.0) : -Float(M_PI * 2.0)
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    
    /// Will stop a `startRotating(duration: _, clockwise: _)` instance.
    func stopRotating() {
        let kAnimationKey = "rotation"
        var currentState = CGFloat(0)
        
        // Get current state
        if let presentationLayer = layer.presentation(), let zValue = presentationLayer.value(forKeyPath: "transform.rotation.z"){
            currentState = CGFloat((zValue as AnyObject).floatValue)
        }
        
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
        
        // Leave self as it was when stopped.
        layer.transform = CATransform3DMakeRotation(currentState, 0, 0, 1)
    }
}
