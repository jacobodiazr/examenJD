//
//  PhotoViewController.swift
//  ExamenJD
//
//  Created by YEiK on 29/04/22.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var userData = UserData()

    @IBOutlet weak var contentViewData: UIView!
    @IBOutlet weak var imgHeighConstraint: NSLayoutConstraint!
    @IBOutlet weak var showPhotoBtn: UIButton!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var takePhotoBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView(){
        if let img = userData.image {
            showPhotoBtn.isEnabled = true
            showPhotoBtn.alpha = 1
            imgUser.image = img
        }else{
            showPhotoBtn.isEnabled = false
            showPhotoBtn.alpha = 0.5
        }
    }

    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func showPhoto(_ sender: Any) {
        imgHeighConstraint.constant = contentViewData.bounds.width * 0.90
    }
    
    @IBAction func takePhotoBtn(_ sender: Any) {
        print("takePhotoBtn")
    }
}
