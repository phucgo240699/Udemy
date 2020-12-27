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
import WebKit

fileprivate let cellID: String = "documentCell"

class DocumentsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbEmpty: UILabel!
    
    var documents: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleEmptyData()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DocumentCell", bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    func handleEmptyData() {
        if self.documents.count == 0 {
            self.tableView.isHidden = true
            self.lbEmpty.isHidden = false
        }
        else {
            self.tableView.isHidden = false
            self.lbEmpty.isHidden = true
        }
    }
}


// MARK: - UITableViewDataSource
extension DocumentsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? DocumentCell else {
            return UITableViewCell()
        }
        
        cell.setData(title: documents[indexPath.row])
        cell.onTapShare = {
            let activityVC = UIActivityViewController(activityItems: ["\(Common.link.getLessonSource)/\(self.documents[indexPath.row])"], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension DocumentsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: "\(Common.link.getLessonSource)/\(self.documents[indexPath.row])") {
            let urlRequest = URLRequest(url: url)
            
            let webview = WKWebView(frame: UIScreen.main.bounds)
            view.addSubview(webview)
            webview.navigationDelegate = self
            webview.load(urlRequest)
        }
    }
}


// MARK: - WKNavigationDelegate
extension DocumentsVC: WKNavigationDelegate {
    
}
