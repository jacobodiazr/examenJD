//
//  HomeViewController.swift
//  ExamenJD
//
//  Created by YEiK on 28/04/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var listSections = [Sections]()
    var userData = UserData()
    
    private let homeTbl : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SettingSwitchTableViewCell.self, forCellReuseIdentifier: SettingSwitchTableViewCell.identifier)
        table.register(SettingInputTableViewCell.self, forCellReuseIdentifier: SettingInputTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configInit()
    }
    
    func loadInformation(){
        HomeBR.shared.getListInfoHome() { (listSections) in
            self.listSections = listSections
            self.homeTbl.delegate = self
            self.homeTbl.dataSource = self
            self.homeTbl.reloadData()
        }
    }
    
    func configInit(){
        self.title = "Profile Settings"
        view.addSubview(homeTbl)
        homeTbl.frame = view.bounds
        configKeyBoard()
        loadInformation()
    }
    
    func configKeyBoard(){
        hideKeyboardWhenTappedAround()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.hidesBottomBarWhenPushed = true
        if segue.identifier == "goToPhoto"{
            if let vc = segue.destination as? PhotoViewController {
                vc.userData = self.userData
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
            cell.config(with: model)
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
            cell.config(with: model)
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
    }
    
    func selfie(selfie: UIImage) {
        print("selfie")
    }
    
    func viewMode(darkMode: Bool) {
        userData.darkMode = darkMode
        UIView.animate(withDuration: 0.5, animations: {
                self.overrideUserInterfaceStyle = self.userData.darkMode ? .dark : .light
                self.view.backgroundColor = .systemBackground
                self.view.layoutIfNeeded()
            }) { (_) in
                let scenes = UIApplication.shared.connectedScenes
                let windowScene = scenes.first as? UIWindowScene
                let window = windowScene?.windows.first
                window?.overrideUserInterfaceStyle = self.overrideUserInterfaceStyle
                
                self.userData.darkMode.toggle()
            }
    }
    
    
}
