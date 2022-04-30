//
//  FirebaseDB.swift
//  ExamenJD
//
//  Created by YEiK on 29/04/22.
//

import Foundation
import UIKit
import Firebase
import SwiftyJSON

open class FirebaseDB {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let shared = FirebaseDB()
    private var refInfo : DatabaseReference = DatabaseReference()
    private var storage = Storage.storage().reference()
    
    init() {
        refInfo = Database.database(url: "https://upax-234303-default-rtdb.firebaseio.com/").reference()
    }
    
    public func saveUser(user: UserData, completion: @escaping (Bool, UserData) -> Void){
        let uid = UserDefaults.standard.string(forKey: "uid")
        print("uid: \(uid ?? "")")
        let data: [String: Any]! = [
            "name": user.name,
            "darkMode": user.darkMode,
        ]
        //Guadamos/Actualizamos Datos en Firebase
        if uid != nil {
            let locationRef = self.refInfo.child("Users/\(uid!)")
            locationRef.updateChildValues(data){(error: Error?, ref: DatabaseReference) in
                if let error = error {
                    print("Data could not be saved: \(error).")
                    completion(false, user)
                }else{
                    if let imageData = user.image?.pngData() {
                        self.storage.child("\(uid!)/\(user.name).png").putData(imageData, metadata: nil, completion: { _ , error in
                            if error != nil {
                                print("Failed to update")
                            }
                            self.storage.child("\(uid!)/\(user.name).png").downloadURL(completion: {url, error in
                                guard let url = url, error == nil else {
                                    completion(true, user)
                                    return
                                }
                                let urlString = url.absoluteString
                                let urlS : [String : Any]! = [
                                    "urlImg" : urlString
                                ]
                                self.refInfo.child("Users/\(uid!)/").updateChildValues(urlS)
                                self.appDelegate.userData.urlImg = urlString
                                completion(true, self.appDelegate.userData)
                            })
                            
                        })
                    }else{
                        completion(true, user)
                    }
                }
            }
            
        }else{
            if let keyUID = self.refInfo.child("Users").childByAutoId().key {
                let locationRef = self.refInfo.child("Users/\(keyUID)")
                locationRef.setValue(data){(error: Error?, ref: DatabaseReference) in
                    if let error = error {
                        print("Data could not be saved: \(error).")
                        completion(false, user)
                    }else{
                        UserDefaults.standard.set(keyUID, forKey:  "uid")
                        if let imageData = user.image?.pngData() {
                            self.storage.child("\(keyUID)/\(user.name).png").putData(imageData, metadata: nil, completion: { _ , error in
                                if error != nil {
                                    print("Failed to update")
                                }
                                self.storage.child("\(keyUID)/\(user.name).png").downloadURL(completion: {url, error in
                                    guard let url = url, error == nil else {
                                        completion(true, user)
                                        return
                                    }
                                    let urlString = url.absoluteString
                                    let urlS : [String : Any]! = [
                                        "urlImg" : urlString
                                    ]
                                    self.refInfo.child("Users/\(keyUID)/").updateChildValues(urlS)
                                    self.appDelegate.userData.urlImg = urlString
                                    completion(true, self.appDelegate.userData)
                                })
                            })
                        }
                    }
                }
            }
        }
        
    }
    
    
    func getUserByUID(completion: @escaping (_ success: Bool) -> Void){
        let uid = UserDefaults.standard.string(forKey: "uid")
        
        self.refInfo.child("Users/\(uid!)").observe(.value, with: { (snapshot) in
            let userData = UserData()
            if snapshot.childrenCount > 0 {
                let dict = snapshot.value as! [String : Any]
                userData.name = dict["name"] as? String ?? ""
                userData.darkMode = dict["darkMode"] as? Bool ?? false
                userData.urlImg = dict["urlImg"] as? String ?? ""
                if userData.urlImg != "" {
                    if let url = URL(string: userData.urlImg) {
                        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _ , error in
                            if error == nil {
                                DispatchQueue.main.async {
                                    let img = UIImage(data: data!)
                                    userData.image = img
                                    self.appDelegate.userData = userData
                                    completion(true)
                                }
                            }else{
                                self.appDelegate.userData = userData
                                completion(true)
                            }
                        })
                        task.resume()
                    }
                }else{
                    self.appDelegate.userData = userData
                    completion(true)
                }
                
            }else{
                completion(false)
            }
        })
    }
    
    func getGraphics(completion : @escaping () -> Void){
        
        let ref = self.refInfo.child("/Graphics/TypeGraphic/")
        ref.observe(.value) { (snapshot) in
            var listGraphics: [Graphics]!
            self.appDelegate.graphics.removeAll()
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                listGraphics = [Graphics]()
                for snap in snapshots {
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let events = Graphics(key: key, dictionary: postDictionary)
                        listGraphics.append(events)
                    }
                }
            }
            self.appDelegate.graphics = listGraphics
            completion()
        }
    }
}
