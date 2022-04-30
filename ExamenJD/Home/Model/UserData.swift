//
//  UserData.swift
//  ExamenJD
//
//  Created by YEiK on 29/04/22.
//

import Foundation
import UIKit
import SwiftyJSON

open class UserData {
    
    var name: String
    var image : UIImage?
    var urlImg : String
    var darkMode : Bool
    
    init(name : String, image : UIImage, urlImg : String, darkMode : Bool){
        self.name = name
        self.image = image
        self.urlImg = urlImg
        self.darkMode = darkMode
    }
    
    init(){
        self.name = ""
        self.image = nil
        self.urlImg = ""
        self.darkMode = false
    }
}
