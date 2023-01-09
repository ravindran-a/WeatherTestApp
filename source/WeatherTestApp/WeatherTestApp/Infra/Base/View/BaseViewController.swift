//
//  BaseViewController.swift
//  WeatherTestApp
//
//  Created by Ravindran on 05/01/23.
//

import Foundation
import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView = UIFactory.getActivityIndicator(id: AppAccessibilityIdentifiers.activityIndicator.rawValue, style: .large)
    private var errorLabel: UILabel! = UIFactory.getLabel(id: AppAccessibilityIdentifiers.errorLabel.rawValue)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func showLoader() {
        view.addSubview(self.activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorLabel(_ message: String) {
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(AppLayoutOffsetValues.defaultMarginOffset.rawValue)
            make.trailing.equalToSuperview().offset(-AppLayoutOffsetValues.defaultMarginOffset.rawValue)
            errorLabel.text = message
            errorLabel.font = UIFont.systemFont(ofSize: AppFontSizes.titleFontSize.rawValue)
            errorLabel.textColor = .red
            errorLabel.textAlignment = .center
        }
    }
    
    func hideErrorLabel() {
        errorLabel.text = nil
        errorLabel.removeFromSuperview()
    }
    
}
