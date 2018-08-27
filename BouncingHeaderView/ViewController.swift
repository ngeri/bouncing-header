//
//  ViewController.swift
//  BouncingHeaderView
//
//  Created by Gergely Nemeth on 2017. 11. 03..
//  Copyright © 2017. Gergely Nemeth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: headerHeightConstraint.constant, left: 0, bottom: 0, right: 0)
    }
}

extension ViewController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let newHeight = max(0, -scrollView.contentOffset.y)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: newHeight, left: 0, bottom: 0, right: 0)

        if newHeight != headerHeightConstraint.constant {
            headerHeightConstraint.constant = newHeight
        }
    }
}

// MARK: - Just for the sample data

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Cell"
        cell.detailTextLabel?.text = "\(indexPath.row)"
        return cell
    }
}
