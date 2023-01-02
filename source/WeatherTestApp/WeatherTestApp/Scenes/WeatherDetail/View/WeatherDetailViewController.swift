//
//  WeatherDetailViewController.swift
//  SysvineWeatherApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation
import UIKit

class WeatherDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var viewModel: WeatherDetailViewModel!
    private var weatherDetailTableView: UITableView!
    private var activityIndicator: UIActivityIndicatorView!
    
    convenience init(viewModel: WeatherDetailViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather Detail"
        setupViews()
        fetchData()
    }
    
    private func setupViews() {
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
    
    @objc private func refreshData() {
        weatherDetailTableView.refreshControl?.endRefreshing()
        fetchData(isRefresh: true)
    }
    
    private func fetchData(isRefresh: Bool = false) {
        activityIndicator.startAnimating()
        Task {
            do {
                try await viewModel.getWeatherDetailData(refresh: isRefresh)
                self.weatherDetailTableView.reloadData()
                self.activityIndicator.stopAnimating()
            } catch let error {
                self.showAlert(title: "Error Fetching Weather Detail", message: error.localizedDescription)
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
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
            view.configureData(cityName: viewModel.getCityName(), temperature: viewModel.getCityTemperature(), icon: viewModel.getCurrentWeatherIcon())
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailCell.cellIdentifier, for: indexPath) as? WeatherDetailCell {
            cell.configureData(time: viewModel.getTime(indexPath.row), temperature: viewModel.getTemperature(indexPath.row))
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
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
