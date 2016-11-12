import UIKit
import pop

class AnimationEngine {
    
    class var offScreenRightPosition: CGPoint {
        return CGPoint(x : UIScreen.main.bounds.width + 150, y : UIScreen.main.bounds.midY)
    }
    class var offScreenLeftPosition: CGPoint {
        return CGPoint(x : -UIScreen.main.bounds.width, y : UIScreen.main.bounds.midY)
    }
    class var offScreenTopPosition: CGPoint {
        return CGPoint(x: UIScreen.main.bounds.width / 2, y: -UIScreen.main.bounds.midY)
    }
    class var screenCenterPosition: CGPoint {
        return CGPoint(x : UIScreen.main.bounds.midX, y : UIScreen.main.bounds.midY)
    }
    
    let ANIM_DELAY = 0.8
    var originalConstants = [CGFloat]()
    var constraints: [NSLayoutConstraint]!
    
    init(constraints: [NSLayoutConstraint]) {
        for constraint in constraints {
            originalConstants.append(constraint.constant)
            constraint.constant = AnimationEngine.offScreenRightPosition.x
        }
        self.constraints = constraints
    }
    
    func animateOnScreen(delay: Int){
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(delay)) {
            var index = 0
            repeat {
                guard let moveAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant) else { return }
                moveAnimation.toValue = self.originalConstants[index]
                moveAnimation.springBounciness = 12
                moveAnimation.springSpeed = 12
                if (index > 0) {
                    moveAnimation.dynamicsFriction += 25 + CGFloat(index)
                }
                let constraint = self.constraints[index]
                constraint.pop_add(moveAnimation, forKey: "moveOnScreen")
                index = index + 1
            } while (index < self.constraints.count)
        }
    }
    class func animateToPosition(view: UIView, position: CGPoint, completion: @escaping ((POPAnimation?, Bool) -> Void)) {
        guard let moveAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPosition) else { return }
        moveAnimation.toValue = NSValue(cgPoint: position)
        moveAnimation.springBounciness = 8
        moveAnimation.springSpeed = 8
        moveAnimation.completionBlock = completion
        view.pop_add(moveAnimation, forKey: "moveToPosition")
    }
}
