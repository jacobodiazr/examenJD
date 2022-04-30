//
//  HomeViewController.swift
//  ExamenJD
//
//  Created by YEiK on 28/04/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    var listSections = [Sections]()
    var userData = UserData()
    
    private let homeTbl : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SettingSwitchTableViewCell.self, forCellReuseIdentifier: SettingSwitchTableViewCell.identifier)
        table.register(SettingInputTableViewCell.self, forCellReuseIdentifier: SettingInputTableViewCell.identifier)
        return table
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        saveUser()
    }
    
    func saveUser(){
        saveButton.alpha = 0.5
        saveButton.isEnabled = false
        saveButton.setTitle("Sending...", for: .normal)
        FirebaseDB.shared.saveUser(user: userData, completion: { (success, userAppCreate) in
            if success {
                self.userData = userAppCreate
            }else{
                print("error...")
            }
            self.saveButton.alpha = 1
            self.saveButton.isEnabled = true
            self.saveButton.setTitle("Save", for: .normal)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configInit()
    }
    
    func loadInformation(){
        HomeBR.shared.getInfo() { (listSections) in
            self.userData = self.appDelegate.userData
            self.listSections = listSections
            self.viewMode(darkMode: self.userData.darkMode)
            self.homeTbl.delegate = self
            self.homeTbl.dataSource = self
            self.configButton()
            self.homeTbl.reloadData()
        }
    }
    
    func configInit(){
        self.title = "Profile Settings"
        view.addSubview(homeTbl)
        view.addSubview(saveButton)
        homeTbl.frame = view.bounds
        saveButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        configKeyBoard()
        configButton()
        loadInformation()
    }
    
    func configButton(){
        if userData.image != nil && userData.name != "" {
            saveButton.alpha = 1
            saveButton.isEnabled = true
        }else{
            saveButton.alpha = 0.5
            saveButton.isEnabled = false
        }
    }
    
    func configKeyBoard(){
        hideKeyboardWhenTappedAround()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.hidesBottomBarWhenPushed = true
        if segue.identifier == "goToPhoto"{
            if let vc = segue.destination as? PhotoViewController {
                vc.userData = self.userData
                vc.delgateSettingOptionsDataUser = self
            }
        }
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titleSection = listSections[section]
        return titleSection.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let itemHome = listSections[indexPath.section].options[indexPath.row]
        
        switch itemHome.self {
        case .inputCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingInputTableViewCell.identifier, for: indexPath) as? SettingInputTableViewCell else {
                return UITableViewCell()
            }
            cell.delgateSettingOptionsDataUser = self
            cell.config(with: model, userData: self.userData)
            return cell
        case .normalCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            cell.config(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingSwitchTableViewCell.identifier, for: indexPath) as? SettingSwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.delgateSettingOptionsDataUser = self
            cell.config(with: model, userData: self.userData)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = listSections[indexPath.section].options[indexPath.row]
       
        switch type.self {
        case .normalCell(let model):
            if model.typeCell == .selfie {
                self.performSegue(withIdentifier: "goToPhoto", sender: nil)
            }else if model.typeCell == .graphics {
                self.performSegue(withIdentifier: "goToGraphics", sender: nil)
            }
        default:
            print("another option")
        }
    }
}

extension HomeViewController : SettingOptionsDataUser {
    func inputData(inputData: String) {
        userData.name = inputData
        configButton()
    }
    
    func selfie(selfie: UIImage) {
        userData.image = selfie
        configButton()
    }
    
    func viewMode(darkMode: Bool) {
        userData.darkMode = darkMode
        UIView.animate(withDuration: 0.1, animations: {
                self.overrideUserInterfaceStyle = self.userData.darkMode ? .dark : .light
                self.view.backgroundColor = .systemBackground
                self.view.layoutIfNeeded()
            }) { (_) in
                let scenes = UIApplication.shared.connectedScenes
                let windowScene = scenes.first as? UIWindowScene
                let window = windowScene?.windows.first
                window?.overrideUserInterfaceStyle = self.overrideUserInterfaceStyle
            }
    }
    
}
