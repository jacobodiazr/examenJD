//
//  PhotoViewController.swift
//  ExamenJD
//
//  Created by YEiK on 29/04/22.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var delgateSettingOptionsDataUser: SettingOptionsDataUser?
    
    var userData = UserData()
    var saveImg = false
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
            saveImg = true
            showPhotoBtn.isEnabled = true
            showPhotoBtn.alpha = 1
            imgUser.image = img
            imgHeighConstraint.constant = contentViewData.bounds.width * 0.90
        }else{
            showPhotoBtn.isEnabled = false
            showPhotoBtn.alpha = 0.5
            imgHeighConstraint.constant = 0
        }
    }

    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func showPhoto(_ sender: Any) {
        if saveImg {
            dismiss(animated: true, completion: {
                self.delgateSettingOptionsDataUser?.selfie(selfie: self.userData.image!)
            })
        }else{
            if let img = userData.image {
                imgUser.image = img
                imgHeighConstraint.constant = contentViewData.bounds.width * 0.90
            }
        }
        
    }
    
    @IBAction func takePhotoBtn(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension PhotoViewController: UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        guard let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        saveImg = true
        userData.image = img
        configView()
        
    }
    
}
