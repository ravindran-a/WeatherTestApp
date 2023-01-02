//
//  WeatherInfoViewController.swift
//  SysvineWeatherApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation
import UIKit
import SnapKit

class WeatherInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewModel: WeatherInfoViewModel!
    var segmentedControl: UISegmentedControl!
    var citiesLabel: UILabel!
    var weatherInfoTableView: UITableView!
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather Info"
        setupViews()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Weather Info"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    func setupViews() {
        self.view.backgroundColor = .white
        segmentedControl = UIFactory.getSegmentedControl(id: "segmentedControl", items: ["F", "C"])
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        segmentedControl.addTarget(self, action: #selector(temperatureUnitUpdated), for: .valueChanged)
        
        citiesLabel = UIFactory.getLabel(id: "citiesLabel")
        citiesLabel.text = "Cities"
        citiesLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        citiesLabel.textColor = UIColor.darkGray
        view.addSubview(citiesLabel)
        citiesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        weatherInfoTableView = UIFactory.getTableView(id: "weatherInfoTableView", style: .plain, dataSource: self, delegate: self)
        weatherInfoTableView.refreshControl = UIRefreshControl()
        weatherInfoTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        weatherInfoTableView.register(WeatherInfoCell.self, forCellReuseIdentifier: WeatherInfoCell.cellIdentifier)
        
        view.addSubview(weatherInfoTableView)
        weatherInfoTableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        activityIndicator = UIFactory.getActivityIndicator(id: "activityIndicator", style: .large)
        view.addSubview(self.activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func temperatureUnitUpdated() {
        viewModel.selectedTemperatureUnitIndex = segmentedControl.selectedSegmentIndex
        fetchData(isRefresh: true)
    }

    @objc func refreshData() {
        weatherInfoTableView.refreshControl?.endRefreshing()
        fetchData(isRefresh: true)
    }
    
    func fetchData(isRefresh: Bool = false) {
        activityIndicator.startAnimating()
        viewModel.getWeatherData(refresh: isRefresh) { [weak self] error in
            self?.activityIndicator.stopAnimating()
            if error != nil {
                self?.showAlert(title: "Error Fetching Weather Info", message: error?.localizedDescription ?? "")
            } else {
                if self?.viewModel.getNumberOfRows() == 0 {
                    
                } else {
                    
                }
                self?.weatherInfoTableView.reloadData()
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension WeatherInfoViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInfoCell.cellIdentifier, for: indexPath) as? WeatherInfoCell {
            configureWeatherInfoCell(indexPath, cell: cell)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func configureWeatherInfoCell(_ indexPath: IndexPath, cell: WeatherInfoCell) {
        cell.cityName.text = viewModel.getCityName(indexPath.row)
        cell.cityTemperature.text = viewModel.getCityTemperature(indexPath.row)
        cell.currentWeatherIcon.image = viewModel.getCurrentWeatherIcon(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.gotoWeatherDetail(indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
