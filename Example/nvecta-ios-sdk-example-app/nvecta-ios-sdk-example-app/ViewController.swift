//
//  ViewController.swift
//  nvecta-ios-sdk-example-app
//
//  Created by Notifyvisitors Macbook Pro 001  on 14/08/26.
//

import UIKit
import NVECTASDK
import notifyvisitors

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad called")
        
        NVECTA.shared.delegate = self
        NVECTA.shared.show(userToken: nil, customRule: nil)
       
        NVECTA.shared.trackEvent(forEventName: "", attributes: [:], ltv: "", scope: 1)
//        notifyvisitors.show(nil, customRule: nil)
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
    
    }

}

extension ViewController: NVECTADelegate {
    func nvectaDidTrackEventResponse(_ response: [String : Any]?) {
        
        notifyvisitors.getNotificationCenterData { (notificationsData: [AnyHashable : Any]?) in
            print("getNotificationCenterData response data = \(notificationsData ?? [:])")
        }
    }
    
}

