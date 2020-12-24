//
//  DocumentsVC.swift
//  Udemy
//
//  Created by Phúc Lý on 24/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

fileprivate let cellID: String = "documentCell"

class DocumentsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var documents: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SimpleTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
    }
}

extension DocumentsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? SimpleTableViewCell else {
            return UITableViewCell()
        }
        
        cell.imgView?.image = UIImage(named: Common.imageName.document)
        cell.label?.text = documents[indexPath.row]
        
        return cell
    }
}

extension DocumentsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: "\(Common.link.getDocument)/\(documents[indexPath.row])") else {
            return
        }
        
        SVProgressHUD.show()
        
        let task = URLSession.shared.downloadTask(with: url) { (urlResponse, response, error) in
            
            SVProgressHUD.dismiss()
            
            guard let originalUrl = urlResponse else {
                return
            }
            
            do {
                // get path to file
                let path = try FileManager.default.url(for: .downloadsDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                
                // give name to file
                let newUrl = path.appendingPathComponent(self.documents[indexPath.row])
                
                print("newURL: \(newUrl)")
                
                // move file to newUrl
                try FileManager.default.moveItem(at: originalUrl, to: newUrl)
                
                
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
