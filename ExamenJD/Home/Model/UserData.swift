//
//  UserData.swift
//  ExamenJD
//
//  Created by YEiK on 29/04/22.
//

import Foundation
import UIKit

open class UserData {
    
    var name: String
    var image : UIImage?
    var darkMode : Bool
    
    init(){
        self.name = ""
        self.image = nil
        self.darkMode = false
    }
}
