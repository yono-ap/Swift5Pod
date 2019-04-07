//
//  AppCenterViewController.swift
//  Swift5Pod
//
//  Created by yoshiyuki ono on 2019/04/07.
//  Copyright © 2019 yono-ap. All rights reserved.
//

import UIKit

class AppCenterViewController: UIViewController {
    @IBOutlet weak var labelDescription: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        appTrace()
        labelDescription.text = "App Center’s SDK".localized
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
