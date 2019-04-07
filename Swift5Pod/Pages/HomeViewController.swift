//
//  HomeViewController.swift
//  Swift5Pod
//
//  Created by yoshiyuki ono on 2019/04/07.
//  Copyright © 2019 yono-ap. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var labelDescription: UILabel!

    struct CellItem {
        let title: String
        let name: String

        init(title: String, name: String) {
            self.title = title
            self.name = name
        }
    }

    struct SectionItem {
        let title: String
        let cellItems: [CellItem]

        init(title: String, cellItems: [CellItem]) {
            self.title = title
            self.cellItems = cellItems
        }
    }

    let items: [SectionItem] = [
        SectionItem(title: "AppCenter".localized, cellItems: [
            CellItem(title: "Analytics data", name: "Swift5Pod.AppCenterViewController")
            ]),
        SectionItem(title: "Realm".localized, cellItems: [
            CellItem(title: "Button", name: "v21"),
            CellItem(title: "Entry", name: "v22")
            ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        appTrace()
        labelDescription.text = "The following is a list of test programs.".localized
    }

}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let item = items[indexPath.section].cellItems[indexPath.row]
        appLog("index = \(indexPath.section) : \(indexPath.row) \(item.title)")

        let vcType = NSClassFromString(item.name) as? UIViewController.Type
        guard let aClass = vcType else {
            appLog("No such class \(item.name)")
            return
        }

        let viewController = aClass.init()
        viewController.title = item.title
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].cellItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        cell.textLabel?.text=items[indexPath.section].cellItems[indexPath.row].title
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].title
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
}
