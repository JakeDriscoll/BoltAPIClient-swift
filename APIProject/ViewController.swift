//
//  ViewController.swift
//  TestingProject
//
//  Created by Jakob Driscoll on 8/22/19.
//  Copyright © 2019 Jakob Driscoll. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var sessionID: String?
    var terminalID: String?
    let merchantID = "800000000120"
    let boltClient = BoltAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func AuthPayment(_ sender: Any) {

        guard let termID = self.terminalID else { return }
        boltClient.OpenTerminalSession(merchantId: self.merchantID, terminalID: termID) { response in
            do {
                self.sessionID = try response.get()
            } catch {
                print(error.localizedDescription)
            }
        }
        

    }
    
    @IBAction func GetTerminalList(_ sender: Any) {
        
         self.terminalID = "18233PP21555667"
        return
//        boltClient.send(ListTerminal(merchantId: self.merchantID)) { response in
//            do {
//                let terminalList = try response.get()
//                for terminal in terminalList.terminals {
//                    print(terminal)
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//            print(response)
//            self.terminalID = "18233PP21555667"
//        }
//        print("This is bananas")
    }

    @IBAction func AuthAgainstTerminal(_ sender: Any) {
        guard let termID = self.terminalID else {
            print("Need TerminalID for auth")
            return
        }
        guard let sessionID = self.sessionID else {
            print("Need sessionKey for auth")
            return
        }
        boltClient.send(AuthorizeCard(merchantId: self.merchantID, terminalID: termID, amount: "1000"), sessionID: sessionID)
        { response in
            do {
                let authResponse = try response.get()
                print(authResponse.token!)
                print(authResponse)
            } catch {
                print(error.localizedDescription)
                print("Fucked up")
            }
        }
        boltClient.send(DisconnectTerminal(merchantId: self.merchantID, terminalID: termID)) { response in
            print("We disconnected")
        }
    }
}

