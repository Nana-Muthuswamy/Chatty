//
//  ChatViewController.swift
//  Chatty
//
//  Created by Guoliang Wang on 4/12/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var messageField: UITextField!

    fileprivate var messages = Array<PFObject>() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    fileprivate var pullMsgTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 21.0

        pullMsgTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {[weak self] (_) in
            self?.fetchMessages()
        })

        pullMsgTimer.fire()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Action Method 

    @IBAction func sendMessage(_ sender: Any) {

        if let msgText = messageField.text {
            
            let message = PFObject.init(className: "Message")
            message["text"] = msgText
            message.saveInBackground(block: { (successful, error) in
                print("successful? \(successful)")
            })
        }
    }

    // MARK: Network

    func fetchMessages() {

        let query = PFQuery(className: "Message")

        query.findObjectsInBackground {[weak weakSelf = self] (results, error) in

            if error == nil && results != nil {
                weakSelf?.messages = results!
                print("results: \(weakSelf?.messages)")
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell")!

        if let msg = messages[indexPath.row]["text"] as? String {
            (cell.viewWithTag(1) as! UILabel).text = msg
        }

        return cell
    }
}
