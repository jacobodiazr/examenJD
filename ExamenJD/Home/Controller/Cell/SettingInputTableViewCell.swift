//
//  SettingInputTableViewCell.swift
//  ExamenJD
//
//  Created by YEiK on 29/04/22.
//

import UIKit

class SettingInputTableViewCell: UITableViewCell {
    
    var delgateSettingOptionsDataUser: SettingOptionsDataUser?
    static let identifier = "SettingInputTableViewCell"
    
    private let iconContainer: UIView = {
        let view = UIView ()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImgView : UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .alphabet
        textField.autocapitalizationType = .words
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconContainer)
        contentView.addSubview(iconImgView)
        contentView.addSubview(textField)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size : CGFloat = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 10, y: 6, width: size, height: size)
        
        let imageSize : CGFloat = size / 1.5
        iconImgView.frame = CGRect(x: 0, y: 0, width: imageSize, height: imageSize)
        iconImgView.center = iconContainer.center
        
        textField.frame = CGRect (x: iconContainer.frame.size.width + 15, y: 0, width: contentView.frame.size.width - 15 - iconContainer.frame.size.width, height: contentView.frame.size.height)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconContainer.backgroundColor = nil
        iconImgView.image = nil
        textField.placeholder = nil
        
    }
    
    public func config(with model : ItemHome, userData : UserData){
        iconImgView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor
        textField.placeholder = model.title
        textField.text = userData.name
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
}

extension SettingInputTableViewCell : UITextFieldDelegate {
    @objc func textFieldDidChange(){
        delgateSettingOptionsDataUser?.inputData(inputData: textField.text ?? "")
    }
}
