//
//  Enums.swift
//  ExamenJD
//
//  Created by YEiK on 28/04/22.
//

import Foundation

enum TypeCell {
    case inputInformation
    case selfie
    case graphics
    case modeAppearance
    case empty
}

enum OptionsCellType {
    case inputCell(model : ItemHome)
    case normalCell(model : ItemHome)
    case switchCell(model : ItemHomeSwitch)
}

enum GradientColorDirection {
    case vertical
    case horizontal
}
