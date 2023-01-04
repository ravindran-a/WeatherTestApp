//
//  WeatherInfoViewController.swift
//  WeatherTestApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation
import UIKit
import SnapKit

class WeatherInfoViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: WeatherInfoViewModel!
    private var segmentedControl: UISegmentedControl!
    private var citiesLabel: UILabel!
    private var weatherInfoTableView: UITableView!
    
    convenience init(viewModel: WeatherInfoViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
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
    
    private func setupViews() {
        self.view.backgroundColor = .white
        configureSegmentedControl()
        configureCitiesLabel()
        configureTableView()
    }
    
    private func configureSegmentedControl() {
        segmentedControl = UIFactory.getSegmentedControl(id: "segmentedControl", items: viewModel.getSegmentedControlItems())
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        segmentedControl.addTarget(self, action: #selector(temperatureUnitUpdated), for: .valueChanged)
    }
    
    private func configureTableView() {
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
    }
    
    private func configureCitiesLabel() {
        citiesLabel = UIFactory.getLabel(id: "citiesLabel")
        citiesLabel.text = "Cities"
        citiesLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        citiesLabel.textColor = UIColor.darkGray
        view.addSubview(citiesLabel)
        citiesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
    }
    
    @objc private func temperatureUnitUpdated() {
        viewModel.updateTemperatureUnit(segmentedControl.selectedSegmentIndex)
        fetchData(isRefresh: true)
    }
    
    @objc private func refreshData() {
        weatherInfoTableView.refreshControl?.endRefreshing()
        fetchData(isRefresh: true)
    }
    
    private func fetchData(isRefresh: Bool = false) {
        showLoader()
        Task {
            do {
                try await viewModel.getWeatherData(refresh: isRefresh)
                self.weatherInfoTableView.reloadData()
                hideLoader()
            } catch let error {
                self.showAlert(title: "Error Fetching Weather Info", message: error.localizedDescription )
            }
        }
    }
}
