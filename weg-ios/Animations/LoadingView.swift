//
//  LoadingView.swift
//  weg-ios
//
//  Created by Taylor, James on 5/24/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import UIKit
import Lottie

class LoadingView: UIView {
    @IBOutlet weak var loadingView: LoadingView!
    var animationView : LOTAnimationView?
    
    static func getAndStartLoadingView() -> LoadingView {
        guard let rootView = UIApplication.shared.keyWindow?.rootViewController?.view else {
            return LoadingView()
        }
        guard let loadingView = Bundle.main.loadNibNamed("LoadingView",
                                                         owner: self,
                                                         options: nil)?.first as? LoadingView else {
                                                            return LoadingView()
        }
        loadingView.frame = rootView.frame
        rootView.addSubview(loadingView)
        loadingView.startAnimation()
        loadingView.startAnimation()
        return loadingView
    }
    func startAnimation(){
        animationView = LOTAnimationView(name: "loading")
        animationView?.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        loadingView.addSubview(animationView!)
        animationView?.loopAnimation = true
        animationView?.play()
    }
    func stopAnimation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.removeFromSuperview()
        }
        
    }
}
