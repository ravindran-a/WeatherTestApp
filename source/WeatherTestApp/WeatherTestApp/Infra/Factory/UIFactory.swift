//
//  UIFactory.swift
//  WeatherTestApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation
import UIKit

struct UIFactory {
    
    static func getView(id accessibilityIdentifier: String) -> UIView {
        let view = UIView()
        view.accessibilityIdentifier = accessibilityIdentifier
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }
    
    static func getButton(id accessibilityIdentifier: String) -> UIButton {
        let button = UIButton()
        button.accessibilityIdentifier = accessibilityIdentifier
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        return button
    }
    
    static func getTableView(id accessibilityIdentifier: String, style: UITableView.Style, dataSource: UITableViewDataSource,
                             delegate: UITableViewDelegate, isAccessibilityElement: Bool = true) -> UITableView {
        let table = UITableView(frame: CGRect.zero, style: style)
        
        table.dataSource = dataSource
        table.delegate = delegate
        table.accessibilityIdentifier = accessibilityIdentifier
        table.cellLayoutMarginsFollowReadableWidth = false
        table.translatesAutoresizingMaskIntoConstraints = false
        table.estimatedRowHeight = UITableView.automaticDimension
        table.rowHeight = UITableView.automaticDimension
        table.sectionHeaderHeight = UITableView.automaticDimension
        table.estimatedSectionHeaderHeight = UITableView.automaticDimension
        table.backgroundColor = .white
        table.tableHeaderView = nil
        table.showsVerticalScrollIndicator = false
        table.contentInset = UIEdgeInsets.zero
        table.separatorInset = UIEdgeInsets.zero
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        }
        
        return table
    }
    
    static func getLabel(id accessibilityIdentifier: String, isAccessibilityElement: Bool = true) -> UILabel {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.accessibilityIdentifier  = accessibilityIdentifier
        label.isAccessibilityElement = isAccessibilityElement
        
        return label
    }
    
    static func getActivityIndicator(id accessibilityIdentifier: String, style: UIActivityIndicatorView.Style = .large,
                                     isAccessibilityElement: Bool = true) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: style)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.accessibilityIdentifier = accessibilityIdentifier
        activityIndicator.isAccessibilityElement = isAccessibilityElement
        activityIndicator.stopAnimating()
        
        return activityIndicator
    }
    
    static func getSegmentedControl(id accessibilityIdentifier: String, items: [String], isAccessibilityElement: Bool = true) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.accessibilityIdentifier = accessibilityIdentifier
        segmentedControl.isAccessibilityElement = isAccessibilityElement
        return segmentedControl
    }
    
    static func getImageView(id accessibilityIdentifier: String, contentMode: UIView.ContentMode = .scaleAspectFill,
                             isAccessibilityElement: Bool = true) -> UIImageView {
        let imageView = UIImageView()
        
        imageView.contentMode = contentMode
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = accessibilityIdentifier
        imageView.isAccessibilityElement = isAccessibilityElement
        
        return imageView
    }
    
}
