//
//  FeedViewController.swift
//  Post It
//
//  Created by Catalin Neculaide on 24.04.2021.
//

import UIKit
import SwiftyJSON

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let refreshControl = UIRefreshControl()
    
    var user = Users()
    
    var messages: [Message] = [Message]()
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        getAllMessages()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Refresh", style: .done, target: self, action: #selector (refreshTableView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_nav_logout"), style: .done, target: self, action: #selector(logout))

        feedTableView.delegate = self
        feedTableView.dataSource = self

    }
    
    @objc func refreshTableView(){
        getAllMessages()
    }
    
    func getAllMessages(){
        APIManagers.shared.getAllMessages { (isSuccess, error, json) in
            if isSuccess == true {
                self.configureJSON(jsons: json ?? [])
            } else {
                print("Cannot get messeges: \(error!)")
            }
        }
    }
    
    func configureJSON(jsons: [JSON]){
        messages = []
        for json in jsons {
            let message = Message()
            message.configure(json: json)
            messages.append(message)
        }
        feedTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageCell
        let messageItem = messages[indexPath.row]
        
        cell.configure(messageItem)
        
        return cell
        
    }
    
    
    
    @objc func logout(){
        _ = navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func addPostButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "segueToPost", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PostMsgViewController {
            let vc = segue.destination as? PostMsgViewController
            vc?.user = user
        }
    }
}
