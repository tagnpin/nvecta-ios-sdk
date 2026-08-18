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
        NVECTA.shared.show(userToken: nil, customRule: nil)
        NVECTA.shared.trackScreen(forScreenName: "")
//        notifyvisitors.show(nil, customRule: nil)
        // Do any additional setup after loading the view.
    }


}

