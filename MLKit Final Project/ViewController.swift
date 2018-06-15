//
//  ViewController.swift
//  MLKit Final Project
//
//  Created by Sai Kambampati on 5/20/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView?.addSubview(UIView(frame: .zero))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "Barcode Scanner"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Face Detection"
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "Image Labelling"
        } else if indexPath.row == 3 {
            cell.textLabel?.text = "Text Recognition"
        } else if indexPath.row == 4 {
            cell.textLabel?.text = "Landmark Recognition"
        }
        let footer = UIView(frame: .zero)
        tableView.tableFooterView = footer
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            performSegue(withIdentifier: "barcodeSegue", sender: self)
        } else if indexPath.row == 1 {
            performSegue(withIdentifier: "faceSegue", sender: self)
        } else if indexPath.row == 2 {
            performSegue(withIdentifier: "imageSegue", sender: self)
        } else if indexPath.row == 3 {
            performSegue(withIdentifier: "textSegue", sender: self)
        } else if indexPath.row == 4 {
            performSegue(withIdentifier: "landmarkSegue", sender: self)
        }
    }
}
