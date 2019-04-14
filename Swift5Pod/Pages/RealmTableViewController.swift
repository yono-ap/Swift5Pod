//
//  RealmTableViewController.swift
//  Swift5Pod
//
//  Created by yoshiyuki ono on 2019/04/13.
//  Copyright © 2019 yono-ap. All rights reserved.
//

import UIKit
import RealmSwift

class RealmTableViewController: UIViewController {

    var notificationToken: NotificationToken?
    var items: Results<RepositoryObject>?

    let dateFormatter = DateFormatter()

    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var textFieldUrl: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBAction func buttonRefresh(_ sender: Any) {
        appTrace()
        if indicator.isAnimating {
            return
        }

        indicator.startAnimating()

        let serverApi = ServerApi<[ApiRepository]>()
        serverApi.apiGet(urlString: textFieldUrl.text ?? "", dataHandler: { apiRepository in
            do {
                let realm = try Realm()
                try realm.write {
                    apiRepository.forEach({ item in
                        let repositoryObject = RepositoryObject()
                        repositoryObject.repositoryId = item.repositoryId
                        repositoryObject.nodeId = item.nodeId
                        repositoryObject.repositoryName = item.repositoryName
                        repositoryObject.fullName = item.fullName
                        repositoryObject.repositoryDescription = item.repositoryDescription
                        repositoryObject.updatedAt = item.updatedAt

                        realm.add(repositoryObject, update: true)

                    })
                }
            } catch let error {
                DispatchQueue.main.async {
                    self.displayAlert(title: "Error", message: "\(error)")
                }
            }

            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.tableView.reloadData()
            }

        }, errorHandler: { data, response, error in
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.httpErrorHandler(data: data, response: response, error: error)
            }

        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        appTrace()
        dateFormatter.timeStyle = .full
        dateFormatter.dateStyle = .full
        labelDescription.text = "Realm Object.".localized
        textFieldUrl.text = "https://api.github.com/users/yono-ap/repos"

        tableView.delegate = self
        tableView.dataSource = self

        do {
            let realm = try Realm()
            let results = realm.objects(RepositoryObject.self)
            items = results

            notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
                guard let tableView = self?.tableView else { return }
                switch changes {
                case .initial:
                    // Results are now populated and can be accessed without blocking the UI
                    tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    // Query results have changed, so apply them to the UITableView
                    tableView.beginUpdates()
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .automatic)
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    tableView.endUpdates()
                case .error(let error):
                    // An error occurred while opening the Realm file on the background worker thread
                    fatalError("\(error)")
                }
            }
        } catch let error {
            appLog("Error : \(error)")
        }
    }

    deinit {
        notificationToken?.invalidate()
    }
}

// MARK: - UITableViewDelegate
extension RealmTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: - UITableViewDataSource
extension RealmTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        appLog("section=\(section)")
        guard let items = items else {
            appLog("items is nil.")
            return 0
        }

        appLog("count=\(items.count)")
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        appLog("indexPath=\(indexPath.section):\(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ??
            UITableViewCell(style: .subtitle, reuseIdentifier: "cell")

        guard let items = items else {
            appLog("items is nil.")
            return cell
        }

        if indexPath.row >= items.count {
            appLog("row=\(indexPath.row) count=\(items.count)")
            return cell
        }

        cell.textLabel?.text = items[indexPath.row].repositoryName
        cell.detailTextLabel?.text = dateFormatter.string(from: items[indexPath.row].updatedAt)
        return cell
    }

}
