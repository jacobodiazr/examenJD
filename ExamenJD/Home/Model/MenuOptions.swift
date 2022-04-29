//
//  MenuOptions.swift
//  ExamenJD
//
//  Created by YEiK on 28/04/22.
//

import Foundation
import UIKit

open class ItemHome {
    var title: String
    var icon : UIImage?
    var iconBackgroundColor : UIColor
    var typeCell : TypeCell
    
    init(){
        self.title = ""
        self.icon = UIImage(systemName: "house")
        self.iconBackgroundColor = .systemBlue
        self.typeCell = .empty
    }
}

open class ItemHomeSwitch {
    var title: String
    var icon : UIImage?
    var iconBackgroundColor : UIColor
    var typeCell : TypeCell
    var isOn : Bool
    
    init(){
        self.title = ""
        self.icon = UIImage(systemName: "house")
        self.iconBackgroundColor = .systemBlue
        self.typeCell = .empty
        self.isOn = false
    }
}

struct Sections {
    let title : String
    let options : [OptionsCellType]
}
