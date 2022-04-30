//
//  HomeBR.swift
//  ExamenJD
//
//  Created by YEiK on 28/04/22.
//

import Foundation
import UIKit
import Firebase

open class HomeBR {
    static let shared = HomeBR()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    private let ref: DatabaseReference? = Database.database().reference()
    
    func getInfo(completion: @escaping ([Sections])-> Void){
            FirebaseDB.shared.getGraphics { 
                self.getListInfoHome() { (listSections) in
                    completion(listSections)
                }
            }
    }
    
    func getListInfoHome(completion: @escaping ([Sections]) -> Void){
        
        var listSections = [Sections]()
        
        let inputInformation = ItemHome()
        inputInformation.typeCell = .inputInformation
        inputInformation.title = "Enter your name"
        inputInformation.icon = UIImage(systemName: "person.badge.plus")
        inputInformation.iconBackgroundColor = .systemBlue
        
        let selfie = ItemHome()
        selfie.typeCell = .selfie
        selfie.title = "Selfie"
        selfie.icon = UIImage(systemName: "camera.shutter.button")
        selfie.iconBackgroundColor = .systemGreen
        
        listSections.append(Sections(title: "User", options: [.inputCell(model: inputInformation), .normalCell(model: selfie)]))
        
        let graphics = ItemHome()
        graphics.typeCell = .graphics
        graphics.title = "Graphics"
        graphics.icon = UIImage(systemName: "books.vertical")
        graphics.iconBackgroundColor = .systemOrange
        
        listSections.append(Sections(title: "Graphics", options: [.normalCell(model: graphics)]))
        
        let darkMode = ItemHomeSwitch()
        darkMode.typeCell = .graphics
        darkMode.title = "Dark mode"
        darkMode.icon = UIImage(systemName: "moon")
        darkMode.iconBackgroundColor = .systemRed
        
        listSections.append(Sections(title: "Settings", options: [.switchCell(model: darkMode)]))
        
        completion(listSections)
    }
}
