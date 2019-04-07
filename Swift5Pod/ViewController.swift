//
//  ViewController.swift
//  Swift5Pod
//
//  Created by yoshiyuki ono on 2019/04/06.
//  Copyright © 2019 yono-ap. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        appTrace()

        let viewController = HomeViewController()
        viewController.title = "Home"
        let navigationController = UINavigationController(rootViewController: viewController)
        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
    }

}
