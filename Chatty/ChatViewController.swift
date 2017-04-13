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

    @IBOutlet var messageField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendMessage(_ sender: Any) {
        
        
        if let msgText = messageField.text {
            
            let message = PFObject.init(className: "Message")
            message["text"] = msgText
            message.saveInBackground(block: { (successful, error) in
                print("successful? \(successful)")
            })
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
