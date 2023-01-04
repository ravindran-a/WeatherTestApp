//
//  WeatherInfoViewController+Table.swift
//  WeatherTestApp
//
//  Created by Ravindran on 04/01/23.
//

import Foundation
import UIKit

extension WeatherInfoViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInfoCell.cellIdentifier, for: indexPath) as? WeatherInfoCell {
            cell.configureData(cityName: viewModel.getCityName(indexPath.row), temperature: viewModel.getCityTemperature(indexPath.row),
                               icon: viewModel.getCurrentWeatherIcon(indexPath.row))
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.gotoWeatherDetail(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
