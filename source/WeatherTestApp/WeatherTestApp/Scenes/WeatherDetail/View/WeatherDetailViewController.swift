//
//  WeatherDetailViewController.swift
//  SysvineWeatherApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation
import UIKit

class WeatherDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewModel: WeatherDetailViewModel!
    var weatherDetailTableView: UITableView!
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather Detail"
        setupViews()
        fetchData()
    }
    
    func setupViews() {
        self.view.backgroundColor = .white
        
        weatherDetailTableView = UIFactory.getTableView(id: "weatherDetailTableView", style: .plain, dataSource: self, delegate: self)
        weatherDetailTableView.refreshControl = UIRefreshControl()
        weatherDetailTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        weatherDetailTableView.register(WeatherInfoHeaderView.self, forHeaderFooterViewReuseIdentifier: WeatherInfoHeaderView.identifier)
        weatherDetailTableView.register(WeatherDetailCell.self, forCellReuseIdentifier: WeatherDetailCell.cellIdentifier)
        
        view.addSubview(weatherDetailTableView)
        weatherDetailTableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        activityIndicator = UIFactory.getActivityIndicator(id: "activityIndicator", style: .large)
        view.addSubview(self.activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @objc func refreshData() {
        weatherDetailTableView.refreshControl?.endRefreshing()
        fetchData(isRefresh: true)
    }
    
    func fetchData(isRefresh: Bool = false) {
        activityIndicator.startAnimating()
        viewModel.getWeatherDetailData(refresh: isRefresh) { [weak self] error in
            self?.activityIndicator.stopAnimating()
            if error != nil {
                self?.showAlert(title: "Error Fetching Weather Detail", message: error?.localizedDescription ?? "")
            } else {
                self?.weatherDetailTableView.reloadData()
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension WeatherDetailViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: WeatherInfoHeaderView.identifier) as? WeatherInfoHeaderView {
            configureWeatherInfoHeader(view)
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailCell.cellIdentifier, for: indexPath) as? WeatherDetailCell {
            configureWeatherDetailCell(indexPath, cell: cell)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func configureWeatherInfoHeader(_ view: WeatherInfoHeaderView) {
        view.cityName.text = viewModel.getCityName()
        view.cityTemperature.text = viewModel.getCityTemperature()
        view.currentWeatherIcon.image = viewModel.getCurrentWeatherIcon()
    }
    
    func configureWeatherDetailCell(_ indexPath: IndexPath, cell: WeatherDetailCell) {
        cell.time.text = viewModel.getTime(indexPath.row)
        cell.temperature.text = viewModel.getTemperature(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
