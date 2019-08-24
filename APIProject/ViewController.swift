//
//  ViewController.swift
//  TestingProject
//
//  Created by Jakob Driscoll on 8/22/19.
//  Copyright © 2019 Jakob Driscoll. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func AuthPayment(_ sender: Any) {
        do {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        let request = ListTerminal(merchantID: "800000000120")
        let jsonData = try encoder.encode(request)
        // 1

        // 2
        let string = String(data: jsonData, encoding: .utf8)!
            print(string)
        } catch {
            print("Something broken")
        }
        
        
    }
    
    @IBAction func GetTerminalList(_ sender: Any) {
        
        

        let boltClient = BoltAPIClient()
        let merchantID = "800000000120"

        boltClient.send(ListTerminal(merchantID: merchantID)) { response in
            print(response)
        }
        

        
        print("This is bananas")
    }
}

