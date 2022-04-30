//
//  GraphicsViewController.swift
//  ExamenJD
//
//  Created by YEiK on 29/04/22.
//

import UIKit

class GraphicsViewController: UIViewController {
    
    var graphics = [Graphics]()

    @IBOutlet weak var graphicsTbl: UITableView!{
        didSet{
            graphicsTbl.register(UINib(nibName: "GraphicTableViewCell", bundle: nil), forCellReuseIdentifier: "graphicCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        graphicsTbl.delegate = self
        graphicsTbl.dataSource = self
        graphics = appDelegate.graphics
    }
    
}

extension GraphicsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return graphics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "graphicCell", for: indexPath) as? GraphicTableViewCell else {
            return UITableViewCell()
        }
        cell.config(itemGraphic: graphics[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.60
    }

}
