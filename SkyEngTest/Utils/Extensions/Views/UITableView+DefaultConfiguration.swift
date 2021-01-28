//
//  UITableView+Configuration.swift
//  SkyEngTest
//
//  Created by Svyatoslav Ivanov on 27.01.2021.
//

import Foundation
import UIKit

extension UITableView {
    static var defaultTableView: UITableView {
        let tableView = UITableView()
        tableView.backgroundColor = ColorPreference.tertiaryColor
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = ColorPreference.secondaryColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        return tableView
    }
}
