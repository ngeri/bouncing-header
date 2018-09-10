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

    private let translucentPercentage: CGFloat = 0.5

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: headerHeightConstraint.constant, left: 0, bottom: 0, right: 0)
        tableView.contentInsetAdjustmentBehavior = .never
        setNavigationBarTransparent(with: 0, on: navigationController?.navigationBar)
    }

    private func setNavigationBarTransparent(with percentage: CGFloat, on navigationBar: UINavigationBar?) {
        let tintColor = UIColor(red: 1 - percentage, green: 1 - percentage, blue: 1 - percentage, alpha: 1)
        navigationBar?.titleTextAttributes = [.foregroundColor : tintColor]
        navigationBar?.tintColor = tintColor
        navigationBar?.isTranslucent = percentage != 1.0
        navigationBar?.shadowImage = percentage == 1.0 ? UINavigationBar().shadowImage : UIImage()
        navigationBar?.setBackgroundImage(UIImage(color: UIColor.white.withAlphaComponent(percentage)), for: .default)
        let newStatusBarStyle: UIStatusBarStyle = percentage < 0.5 ? .lightContent : .default
        if UIApplication.shared.statusBarStyle != newStatusBarStyle { UIApplication.shared.statusBarStyle = newStatusBarStyle }
    }
}

extension ViewController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let newHeight = max(0, -contentOffset)
        let originalHeight = scrollView.contentInset.top
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: newHeight, left: 0, bottom: 0, right: 0)
        if newHeight != headerHeightConstraint.constant {
            if newHeight < originalHeight {
                let alpha = max(0, (translucentPercentage - min(originalHeight, newHeight) / originalHeight) / translucentPercentage)
                setNavigationBarTransparent(with: alpha, on: navigationController?.navigationBar)
            }
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
