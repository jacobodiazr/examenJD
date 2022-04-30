//
//  SettingSwitchTableViewCell.swift
//  ExamenJD
//
//  Created by YEiK on 29/04/22.
//

import UIKit

class SettingSwitchTableViewCell: UITableViewCell {
    
    var delgateSettingOptionsDataUser: SettingOptionsDataUser?
    static let identifier = "SettingSwitchTableViewCell"
    
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
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let mySwicth: UISwitch = {
        let mySwicth = UISwitch()
        return mySwicth
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconContainer)
        contentView.addSubview(iconImgView)
        contentView.addSubview(label)
        contentView.addSubview(mySwicth)
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
        
        label.frame = CGRect(x: iconContainer.frame.size.width + 15, y: 0, width: contentView.frame.size.width - 15 - iconContainer.frame.size.width, height: contentView.frame.size.height)
        
        mySwicth.sizeToFit()
        mySwicth.frame = CGRect(x: contentView.frame.size.width - mySwicth.frame.size.width - 20, y: (contentView.frame.size.height - mySwicth.frame.size.height)/2, width: mySwicth.frame.size.width, height: mySwicth.frame.size.height)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconContainer.backgroundColor = nil
        label.text = nil
        iconImgView.image = nil
        mySwicth.isOn = false
    }
    
    public func config(with model : ItemHomeSwitch, userData : UserData){
        iconImgView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor
        label.text = model.title
        mySwicth.isOn = userData.darkMode
        mySwicth.addTarget(self, action: #selector(switchOpenTriphChanged), for: UIControl.Event.valueChanged)
        
    }
    
    @objc func switchOpenTriphChanged(mySwitch: UISwitch) {
        print(mySwitch.isOn)
        delgateSettingOptionsDataUser?.viewMode(darkMode: mySwitch.isOn)
    }
}
