//
//  WeatherDetailViewController.swift
//  WeatherTestApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation
import UIKit

class WeatherDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: WeatherDetailViewModel!
    private var weatherDetailTableView: UITableView!
    
    convenience init(viewModel: WeatherDetailViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather Detail"
        setupViews()
        fetchData()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        configureTableView()
    }
    
    private func configureTableView() {
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
    }
    
    @objc private func refreshData() {
        weatherDetailTableView.refreshControl?.endRefreshing()
        fetchData(isRefresh: true)
    }
    
    private func fetchData(isRefresh: Bool = false) {
        showLoader()
        Task {
            do {
                try await viewModel.getWeatherDetailData(refresh: isRefresh)
                self.weatherDetailTableView.reloadData()
                hideLoader()
            } catch let error {
                self.showAlert(title: "Error Fetching Weather Detail", message: error.localizedDescription)
            }
        }
    }
}
