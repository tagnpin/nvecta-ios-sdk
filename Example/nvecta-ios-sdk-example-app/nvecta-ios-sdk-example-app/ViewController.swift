//
//  ViewController.swift
//  nvecta-ios-sdk-example-app
//
//  Created by Notifyvisitors Macbook Pro 001  on 14/08/26.
//

import UIKit
import NVECTASDK
//import notifyvisitors

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad called")
        self.view.backgroundColor = .red
        NVECTA.shared.delegate = self
        NVECTA.shared.show(userToken: nil, customRule: nil)

//        configuration.setFirstTab(label: "all", displayName: "All")
//        configuration.setSecondTab(label: "promotion", displayName: "Promotionals")
//        configuration.setThirdTab(label: "offer", displayName: "Offers")
        
//        NVECTA.shared.getNotificationCenterData { (notificationsData: [String : Any]?) in
//            print("getNotificationCenterData = \(notificationsData ?? [:])")
//        }
//        
//        
        
//        notifyvisitors.show(nil, customRule: nil)
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
    
    }

}

extension ViewController: NVECTADelegate {
    func nvectaDidTrackEventResponse(_ response: [String : Any]?) {
        print("[NVECTASDK]-{INFO}: did track event response = \(response ?? [:])")
    }
    
}

