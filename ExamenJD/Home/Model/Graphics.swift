//
//  Graphics.swift
//  ExamenJD
//
//  Created by YEiK on 30/04/22.
//

import Foundation
import SwiftyJSON

open class Graphics {
    var uid : String
    var title : String
    var itemsData : [ItemData]
    
    init(key: String, dictionary: Dictionary<String, AnyObject>){
        let json = SwiftyJSON.JSON(dictionary)
        self.uid = key
        self.title = json["title"].stringValue
        self.itemsData = [ItemData]()
        for(key, subJson) in json["items"] {
            let itemData : ItemData = ItemData()
            itemData.key = key
            itemData.title = subJson["title"].stringValue
            itemData.value = subJson["value"].doubleValue
            itemData.color = subJson["color"].stringValue
            itemsData.append(itemData)
        }
    }
}

open class ItemData {
    var key : String
    var title : String
    var value : Double
    var color : String
    
    init(){
        self.key = ""
        self.title = ""
        self.value = 0.0
        self.color = ""
    }
}
