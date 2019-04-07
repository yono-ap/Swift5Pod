//
//  AppCenterViewController.swift
//  Swift5Pod
//
//  Created by yoshiyuki ono on 2019/04/07.
//  Copyright © 2019 yono-ap. All rights reserved.
//

import UIKit
import AppCenterAnalytics

class AppCenterViewController: UIViewController {
    @IBOutlet weak var labelDescription: UILabel!
    @IBAction func buttonTrackEvent(_ sender: UIButton) {
        MSAnalytics.trackEvent("[TEST EVENT] button clicked.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        appTrace()
        labelDescription.text = "App Center’s SDK".localized
    }

}
