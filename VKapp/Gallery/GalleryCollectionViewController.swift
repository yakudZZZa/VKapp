//
//  GalleryCollectionViewController.swift
//  Weather
//
//  Created by Евгений Иванов on 06/12/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class GalleryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    var interactor:Interactor? = nil

    @IBOutlet var recognizer: UIPanGestureRecognizer!
    @IBOutlet weak var galleryView: UICollectionView!
    
    var photoArr = [UIImage(named: "China"),
                    UIImage(named: "China1"),
                    UIImage(named: "Houses"),
                    UIImage(named: "Iceland"),
                    UIImage(named: "Maldives"),
                    UIImage(named: "New_Zealand")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArr.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! GalleryCollectionViewCell
        cell.galleryImage.image = photoArr[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return DismissAnimator()
//    }
//
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let destinationViewController = segue.destinationViewController as? ModalViewController {
//            destinationViewController.transitioningDelegate = self
//            destinationViewController.interactor = interactor
//        }
//    }
//
//    @IBAction func swipeDown(_ sender: UIPanGestureRecognizer) {
//        let percentThreshold:CGFloat = 0.3
//
//        let translation = sender.translation(in: view)
//        let verticalMovement = translation.y / view.bounds.height
//        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
//        let downwardMovementPercent = fminf(downwardMovement, 1.0)
//        let progress = CGFloat(downwardMovementPercent)
//        guard let interactor = interactor else { return }
//        switch sender.state {
//        case .began:
//            interactor.hasStarted = true
//            dismiss(animated: true, completion: nil)
//        case .changed:
//            let translation = recognizer.translation(in: recognizer.view)
//            let relativeTranslation = translation.y / (recognizer.view?.bounds.width ?? 1)
//            let progress = max(0, min(1, relativeTranslation))
//
//            interactor.shouldFinish = progress > 0.5
//
//            interactor.update(progress)
//            interactor.shouldFinish = progress > percentThreshold
//            interactor.update(progress)
//        case .ended:
//            interactor.hasStarted = false
//            interactor.shouldFinish
//                ? interactor.finish()
//                : interactor.cancel()
//        case .cancelled:
//            interactor.hasStarted = false
//            interactor.cancel()
//        default:
//            break
//        }
//    }
    

}

//@objc func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
//    switch recognizer.state {
//    case .began:
//        self.hasStarted = true
//        self.viewController?.navigationController?.popViewController(animated: true)
//    case .changed:
//        let translation = recognizer.translation(in: recognizer.view)
//        let relativeTranslation = translation.y / (recognizer.view?.bounds.width ?? 1)
//        let progress = max(0, min(1, relativeTranslation))
//
//        self.shouldFinish = progress > 0.5
//
//        self.update(progress)
//    case .ended:
//        self.hasStarted = false
//        self.shouldFinish ? self.finish() : self.cancel()
//    case .cancelled:
//        self.hasStarted = false
//        self.cancel()
//    default: return
//    }
//}

//class DismissAnimator : NSObject, UIViewControllerAnimatedTransitioning {
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.6
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
//        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
//
//        let containerView = transitionContext.containerView
//        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
//        let screenBounds = UIScreen.main.bounds
//        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
//        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
//
//        UIView.animate(
//            withDuration: transitionContext as! TimeInterval,
//            animations: {
//                fromVC.view.frame = finalFrame
//        },
//            completion: {
//                _ in
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        })
//    }
//}
//
//class Interactor: UIPercentDrivenInteractiveTransition {
//    var hasStarted = false
//    var shouldFinish = false
//}
