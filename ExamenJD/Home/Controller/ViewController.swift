//
//  ViewController.swift
//  ExamenJD
//
//  Created by YEiK on 28/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitViewController()
        indicatorView.startAnimating()
    }
    
    func setInitViewController(){
        let uid = UserDefaults.standard.string(forKey: "uid")
        if uid != nil {
            FirebaseDB.shared.getUserByUID { _ in
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                self.manageVC()
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                self.manageVC()
            }
        }
    }
    
    private func manageVC(){
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        guard let rootViewController = window.rootViewController else {
            return
        }
        var mainNC : UIViewController = UIViewController()
        DispatchQueue.main.async {
            mainNC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: "Home")
            mainNC.view.frame = rootViewController.view.frame
            mainNC.view.layoutIfNeeded()
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                window.rootViewController = mainNC
            })
        }
    }
}

