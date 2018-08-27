//
//  ScrollViewController.swift
//  BouncingHeaderView
//
//  Created by Gergely Nemeth on 2017. 11. 04..
//  Copyright © 2017. Gergely Nemeth. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsets(top: headerHeightConstraint.constant, left: 0, bottom: 0, right: 0)
    }
}

extension ScrollViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let newHeight = max(0, -scrollView.contentOffset.y)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: newHeight, left: 0, bottom: 0, right: 0)

        if newHeight != headerHeightConstraint.constant {
            headerHeightConstraint.constant = newHeight
        }
    }
}
